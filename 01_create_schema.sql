-- ============================================
-- Purpose: Create database and all table schemas for Tutoring Management System
-- Prerequisites: None (run this first)
-- ============================================

CREATE DATABASE IF NOT EXISTS tutoring_management;
USE tutoring_management;

-- ============================================
-- TABLE: Students
-- Purpose: Store student enrollment information and contact details
-- ============================================
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    ParentContact VARCHAR(100),
    GradeLevel VARCHAR(20),
    DateEnrolled DATE DEFAULT (CURRENT_DATE),
    ActiveStatus BOOLEAN DEFAULT TRUE,
    
    -- Constraints
    CONSTRAINT chk_email_format CHECK (Email LIKE '%@%'),
    CONSTRAINT chk_grade_level CHECK (GradeLevel IN (
        'Elementary', 'Middle School', 'High School', 'AP', 'College', 'Adult'
    ))
);

-- ============================================
-- TABLE: Tutors
-- Purpose: Store tutor profiles, contact information, and employment details
-- ============================================
CREATE TABLE Tutors (
    TutorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    HireDate DATE DEFAULT (CURRENT_DATE),
    ActiveStatus BOOLEAN DEFAULT TRUE,
    Bio TEXT,
    ProfileImage VARCHAR(255),
    
    -- Constraints
    CONSTRAINT chk_tutor_email CHECK (Email LIKE '%@%')
);

-- ============================================
-- TABLE: Subjects
-- Purpose: Catalog of all subjects with tiered pricing based on difficulty
-- ============================================
CREATE TABLE Subjects (
    SubjectID INT PRIMARY KEY AUTO_INCREMENT,
    SubjectName VARCHAR(100) NOT NULL UNIQUE,
    SubjectCategory VARCHAR(20) NOT NULL,
    HourlyRate DECIMAL(6,2) NOT NULL,
    SubjectLevel VARCHAR(50),
    Description TEXT,
    IsActive BOOLEAN DEFAULT TRUE,
    
    -- Constraints
    CONSTRAINT chk_subject_category CHECK (SubjectCategory IN ('Math/Science', 'Language', 'Other')),
    CONSTRAINT chk_hourly_rate CHECK (HourlyRate > 0),
    CONSTRAINT chk_subject_level CHECK (SubjectLevel IN (
        'Elementary', 'Middle School', 'High School', 'AP', 'College', 'All Levels'
    ))
);

-- ============================================
-- TABLE: Sessions
-- Purpose: Track individual tutoring sessions (appointments) with date, time, and type
-- ============================================
CREATE TABLE Sessions (
    SessionID INT PRIMARY KEY AUTO_INCREMENT,
    TutorID INT NOT NULL,
    SubjectID INT NOT NULL,
    SessionDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    SessionType VARCHAR(20) DEFAULT 'Individual',
    MaxStudents INT DEFAULT 1,
    SessionStatus VARCHAR(20) DEFAULT 'Scheduled',
    SessionNotes TEXT,
    
    -- Foreign Keys
    FOREIGN KEY (TutorID) REFERENCES Tutors(TutorID) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    
    -- Constraints
    CONSTRAINT chk_session_type CHECK (SessionType IN ('Individual', 'Group')),
    CONSTRAINT chk_max_students CHECK (MaxStudents BETWEEN 1 AND 3),
    CONSTRAINT chk_session_status CHECK (SessionStatus IN (
        'Scheduled', 'Completed', 'Cancelled', 'No-Show'
    )),
    CONSTRAINT chk_time_order CHECK (EndTime > StartTime)
);

-- ============================================
-- TABLE: Session_Packages
-- Purpose: Manage prepaid 8-session packages with discount tracking
-- ============================================
CREATE TABLE Session_Packages (
    PackageID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    PurchaseDate DATE DEFAULT (CURRENT_DATE),
    TotalSessions INT DEFAULT 8,
    SessionsUsed INT DEFAULT 0,
    SessionsRemaining INT GENERATED ALWAYS AS (TotalSessions - SessionsUsed) STORED,
    DiscountPerSession DECIMAL(5,2) DEFAULT 5.00,
    TotalPaid DECIMAL(8,2) NOT NULL,
    PackageStatus VARCHAR(20) DEFAULT 'Active',
    
    -- Foreign Keys
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    
    -- Constraints
    CONSTRAINT chk_sessions_used CHECK (SessionsUsed >= 0 AND SessionsUsed <= TotalSessions),
    CONSTRAINT chk_total_paid CHECK (TotalPaid > 0),
    CONSTRAINT chk_package_status CHECK (PackageStatus IN ('Active', 'Completed', 'Expired', 'Refunded'))
);

-- ============================================
-- TABLE: Session_Enrollments
-- Purpose: Junction table managing many-to-many relationship between Sessions and Students
-- Enables group sessions with individual student enrollment tracking
-- ============================================
CREATE TABLE Session_Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    SessionID INT NOT NULL,
    StudentID INT NOT NULL,
    PackageID INT NULL,
    PaymentID INT NULL,
    EnrollmentStatus VARCHAR(20) DEFAULT 'Confirmed',
    SessionRating INT,
    RatingComment TEXT,
    CancellationDate DATETIME NULL,
    RefundEligible BOOLEAN,
    
    -- Foreign Keys
    FOREIGN KEY (SessionID) REFERENCES Sessions(SessionID) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (PackageID) REFERENCES Session_Packages(PackageID) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    
    -- Constraints
    CONSTRAINT chk_enrollment_status CHECK (EnrollmentStatus IN (
        'Confirmed', 'Attended', 'Cancelled', 'No-Show'
    )),
    CONSTRAINT chk_session_rating CHECK (SessionRating BETWEEN 1 AND 5 OR SessionRating IS NULL),
    CONSTRAINT uq_student_session UNIQUE (SessionID, StudentID)
);

-- ============================================
-- TABLE: Payments
-- Purpose: Track all payment transactions with Stripe integration
-- ============================================
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    EnrollmentID INT NULL,
    PackageID INT NULL,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(7,2) NOT NULL,
    PaymentMethod VARCHAR(50) DEFAULT 'Stripe',
    StripeTransactionID VARCHAR(100),
    PaymentStatus VARCHAR(20) DEFAULT 'Completed',
    
    -- Foreign Keys
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (EnrollmentID) REFERENCES Session_Enrollments(EnrollmentID) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (PackageID) REFERENCES Session_Packages(PackageID) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    
    -- Constraints
    CONSTRAINT chk_amount CHECK (Amount > 0),
    CONSTRAINT chk_payment_status CHECK (PaymentStatus IN (
        'Pending', 'Completed', 'Failed', 'Refunded'
    ))
);

-- ============================================
-- TABLE: Tutor_Subject_Expertise
-- Purpose: Junction table managing many-to-many relationship between Tutors and Subjects
-- Tracks tutor qualifications and subject certifications
-- ============================================
CREATE TABLE Tutor_Subject_Expertise (
    ExpertiseID INT PRIMARY KEY AUTO_INCREMENT,
    TutorID INT NOT NULL,
    SubjectID INT NOT NULL,
    YearsExperience INT DEFAULT 0,
    CertificationDate DATE,
    PreferredLevels VARCHAR(100),
    IsActive BOOLEAN DEFAULT TRUE,
    
    -- Foreign Keys
    FOREIGN KEY (TutorID) REFERENCES Tutors(TutorID) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Constraints
    CONSTRAINT chk_years_experience CHECK (YearsExperience >= 0),
    CONSTRAINT uq_tutor_subject UNIQUE (TutorID, SubjectID)
);

-- ============================================
-- TABLE: Tutor_Availability
-- Purpose: Store recurring weekly availability schedules for tutors
-- Supports time zone tracking and temporal validity dates
-- ============================================
CREATE TABLE Tutor_Availability (
    AvailabilityID INT PRIMARY KEY AUTO_INCREMENT,
    TutorID INT NOT NULL,
    DayOfWeek VARCHAR(10) NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    Timezone VARCHAR(10) DEFAULT 'EST',
    IsAvailable BOOLEAN DEFAULT TRUE,
    EffectiveDate DATE DEFAULT (CURRENT_DATE),
    EndDate DATE NULL,
    Notes TEXT,
    
    -- Foreign Keys
    FOREIGN KEY (TutorID) REFERENCES Tutors(TutorID) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Constraints
    CONSTRAINT chk_day_of_Week CHECK (DayOfWeek IN (
        'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    )),
    CONSTRAINT chk_availability_time CHECK (EndTime > StartTime),
    CONSTRAINT chk_end_date CHECK (EndDate IS NULL OR EndDate >= EffectiveDate)
);
