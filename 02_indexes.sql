-- ============================================
-- Purpose: Create indexes for query performance optimization
-- Prerequisites: Run 01_create_schema.sql first
-- ============================================

USE tutoring_management;

-- ============================================
-- Foreign Key Indexes
-- Purpose: Optimize JOIN operations on foreign key relationships
-- ============================================

-- Sessions table indexes
CREATE INDEX idx_sessions_tutor ON Sessions(TutorID);
CREATE INDEX idx_sessions_subject ON Sessions(SubjectID);
CREATE INDEX idx_sessions_date ON Sessions(SessionDate);

-- Session_Enrollments table indexes
CREATE INDEX idx_enrollments_student ON Session_Enrollments(StudentID);
CREATE INDEX idx_enrollments_session ON Session_Enrollments(SessionID);

-- Payments table indexes
CREATE INDEX idx_payments_student ON Payments(StudentID);

-- Session_Packages table indexes
CREATE INDEX idx_packages_student ON Session_Packages(StudentID);

-- ============================================
-- Search Optimization Indexes
-- Purpose: Speed up common search operations by email and name
-- ============================================

CREATE INDEX idx_students_email ON Students(Email);
CREATE INDEX idx_tutors_email ON Tutors(Email);
CREATE INDEX idx_subjects_name ON Subjects(SubjectName);

-- ============================================
-- Complex Query Optimization Indexes
-- Purpose: Support multi-column queries for availability matching and expertise lookups
-- ============================================

-- Composite index for availability queries (e.g., "Find tutors available Tuesday 5-6 PM")
CREATE INDEX idx_availability_day_time ON Tutor_Availability(DayOfWeek, StartTime, EndTime);

-- Composite index for tutor-subject matching queries
CREATE INDEX idx_expertise_tutor_subject ON Tutor_Subject_Expertise(TutorID, SubjectID);
