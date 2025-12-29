-- ============================================
-- Purpose: Load sample data for Tutoring Management System
-- Prerequisites: Run 01_create_schema.sql and 02_indexes.sql first
-- ============================================

USE tutoring_management;

-- ============================================
-- INSERT: Subjects
-- Purpose: Load catalog of subjects with tiered pricing
-- Math/Science: $75/hour | Languages: $65/hour | Other: $55/hour
-- ============================================
INSERT INTO Subjects (SubjectName, SubjectCategory, HourlyRate, SubjectLevel, Description, IsActive) VALUES
-- Math/Science subjects ($75/hour)
('AP Calculus AB', 'Math/Science', 75.00, 'AP', 'Advanced Placement Calculus AB covering limits, derivatives, and integrals', TRUE),
('AP Calculus BC', 'Math/Science', 75.00, 'AP', 'Advanced Placement Calculus BC including series and parametric equations', TRUE),
('Algebra II', 'Math/Science', 75.00, 'High School', 'High school algebra including quadratic equations, polynomials, and functions', TRUE),
('Geometry', 'Math/Science', 75.00, 'High School', 'Euclidean geometry, proofs, and spatial reasoning', TRUE),
('Pre-Calculus', 'Math/Science', 75.00, 'High School', 'Trigonometry, functions, and preparation for calculus', TRUE),
('AP Chemistry', 'Math/Science', 75.00, 'AP', 'Advanced Placement Chemistry covering atomic structure, bonding, and reactions', TRUE),
('AP Physics 1', 'Math/Science', 75.00, 'AP', 'Algebra-based physics covering mechanics and energy', TRUE),
('Biology', 'Math/Science', 75.00, 'High School', 'General biology including cell structure, genetics, and evolution', TRUE),
('Statistics', 'Math/Science', 75.00, 'High School', 'Data analysis, probability, and statistical inference', TRUE),

-- Language subjects ($65/hour)
('Spanish I', 'Language', 65.00, 'High School', 'Introduction to Spanish language and culture', TRUE),
('Spanish II', 'Language', 65.00, 'High School', 'Intermediate Spanish conversation and grammar', TRUE),
('French I', 'Language', 65.00, 'High School', 'Introduction to French language and culture', TRUE),
('AP Spanish Language', 'Language', 65.00, 'AP', 'Advanced Placement Spanish focusing on fluency and composition', TRUE),
('Mandarin Chinese', 'Language', 65.00, 'All Levels', 'Mandarin Chinese language and character writing', TRUE),

-- Other subjects ($55/hour)
('SAT Prep', 'Other', 55.00, 'High School', 'Comprehensive SAT test preparation including math and verbal', TRUE),
('ACT Prep', 'Other', 55.00, 'High School', 'Complete ACT test preparation covering all sections', TRUE),
('English Literature', 'Other', 55.00, 'High School', 'Analysis of classic and contemporary literature', TRUE),
('Essay Writing', 'Other', 55.00, 'High School', 'Academic writing, composition, and essay structure', TRUE),
('US History', 'Other', 55.00, 'High School', 'American history from colonial period to present', TRUE),
('World History', 'Other', 55.00, 'High School', 'Global history and cultural developments', TRUE);

-- ============================================
-- INSERT: Tutors
-- Purpose: Load tutor profiles with contact information and bios
-- ============================================
INSERT INTO Tutors (FirstName, LastName, Email, Phone, HireDate, ActiveStatus, Bio) VALUES
('Sarah', 'Chen', 'sarah.chen@tutoringpro.com', '401-555-0101', '2023-09-01', TRUE, 
 'MIT graduate with 5 years of experience teaching AP Calculus and Physics. Passionate about making complex concepts accessible.'),

('Michael', 'Rodriguez', 'michael.rodriguez@tutoringpro.com', '401-555-0102', '2023-08-15', TRUE,
 'Former high school math teacher with 8 years of experience. Specializes in algebra and geometry.'),

('Emma', 'Williams', 'emma.williams@tutoringpro.com', '401-555-0103', '2024-01-10', TRUE,
 'Native Spanish speaker with teaching certification. Experienced in AP Spanish and Spanish language tutoring.'),

('David', 'Park', 'david.park@tutoringpro.com', '401-555-0104', '2023-10-20', TRUE,
 'PhD candidate in Chemistry at Brown University. Specializes in AP Chemistry and general science.'),

('Jessica', 'Thompson', 'jessica.thompson@tutoringpro.com', '401-555-0105', '2024-02-01', TRUE,
 'SAT/ACT prep specialist with proven track record of score improvements. Also tutors English and writing.'),

('James', 'Lee', 'james.lee@tutoringpro.com', '401-555-0106', '2023-11-05', TRUE,
 'Computer Science major tutoring Statistics and Pre-Calculus. Great with students who struggle with math anxiety.'),

('Maria', 'Garcia', 'maria.garcia@tutoringpro.com', '401-555-0107', '2024-03-15', TRUE,
 'Bilingual tutor specializing in French and Spanish. Study abroad experience in France and Spain.'),

('Robert', 'Johnson', 'robert.johnson@tutoringpro.com', '401-555-0108', '2023-09-20', TRUE,
 'History teacher with passion for making social studies engaging. Specializes in AP US History.');

-- ============================================
-- INSERT: Tutor_Subject_Expertise
-- Purpose: Map tutors to their qualified subjects with experience levels
-- ============================================
INSERT INTO Tutor_Subject_Expertise (TutorID, SubjectID, YearsExperience, CertificationDate, PreferredLevels, IsActive) VALUES
-- Sarah Chen (Math/Science specialist)
(1, 1, 5, '2023-09-01', 'AP, High School', TRUE),  -- AP Calculus AB
(1, 2, 5, '2023-09-01', 'AP', TRUE),                -- AP Calculus BC
(1, 7, 4, '2023-09-01', 'AP, High School', TRUE),  -- AP Physics 1
(1, 5, 5, '2023-09-01', 'High School', TRUE),      -- Pre-Calculus

-- Michael Rodriguez (Math teacher)
(2, 3, 8, '2023-08-15', 'High School, Middle School', TRUE),  -- Algebra II
(2, 4, 8, '2023-08-15', 'High School, Middle School', TRUE),  -- Geometry
(2, 5, 6, '2023-08-15', 'High School', TRUE),                 -- Pre-Calculus
(2, 9, 5, '2023-08-15', 'High School', TRUE),                 -- Statistics

-- Emma Williams (Spanish specialist)
(3, 10, 6, '2024-01-10', 'All Levels', TRUE),  -- Spanish I
(3, 11, 6, '2024-01-10', 'All Levels', TRUE),  -- Spanish II
(3, 13, 4, '2024-01-10', 'AP', TRUE),          -- AP Spanish Language

-- David Park (Chemistry/Biology)
(4, 6, 4, '2023-10-20', 'AP, High School', TRUE),  -- AP Chemistry
(4, 8, 3, '2023-10-20', 'High School', TRUE),      -- Biology
(4, 9, 2, '2023-10-20', 'High School', TRUE),      -- Statistics

-- Jessica Thompson (Test Prep & English)
(5, 15, 6, '2024-02-01', 'High School', TRUE),  -- SAT Prep
(5, 16, 6, '2024-02-01', 'High School', TRUE),  -- ACT Prep
(5, 17, 5, '2024-02-01', 'High School', TRUE),  -- English Literature
(5, 18, 5, '2024-02-01', 'High School', TRUE),  -- Essay Writing

-- James Lee (Math with focus on Stats)
(6, 9, 3, '2023-11-05', 'High School, College', TRUE),  -- Statistics
(6, 5, 2, '2023-11-05', 'High School', TRUE),           -- Pre-Calculus
(6, 3, 2, '2023-11-05', 'High School', TRUE),           -- Algebra II

-- Maria Garcia (French/Spanish)
(7, 10, 4, '2024-03-15', 'All Levels', TRUE),  -- Spanish I
(7, 11, 4, '2024-03-15', 'All Levels', TRUE),  -- Spanish II
(7, 12, 3, '2024-03-15', 'All Levels', TRUE),  -- French I
(7, 14, 2, '2024-03-15', 'All Levels', TRUE),  -- Mandarin Chinese

-- Robert Johnson (History)
(8, 19, 7, '2023-09-20', 'High School, AP', TRUE),  -- US History
(8, 20, 7, '2023-09-20', 'High School', TRUE);      -- World History

-- ============================================
-- INSERT: Tutor_Availability
-- Purpose: Load weekly recurring availability schedules
-- Note: Multiple tutors are available Tuesday 5-6 PM EST for query demonstrations
-- ============================================
INSERT INTO Tutor_Availability (TutorID, DayOfWeek, StartTime, EndTime, Timezone, IsAvailable, EffectiveDate, Notes) VALUES
-- Sarah Chen - Available Tuesday 5-6 PM
(1, 'Tuesday', '17:00:00', '18:00:00', 'EST', TRUE, '2024-09-01', 'Regular availability'),
(1, 'Tuesday', '18:00:00', '19:00:00', 'EST', TRUE, '2024-09-01', 'Regular availability'),
(1, 'Thursday', '16:00:00', '18:00:00', 'EST', TRUE, '2024-09-01', 'Regular availability'),
(1, 'Saturday', '10:00:00', '14:00:00', 'EST', TRUE, '2024-09-01', 'Weekend sessions'),

-- Michael Rodriguez - Also available Tuesday 5-6 PM
(2, 'Monday', '15:00:00', '18:00:00', 'EST', TRUE, '2024-09-01', 'After school hours'),
(2, 'Tuesday', '17:00:00', '18:00:00', 'EST', TRUE, '2024-09-01', 'Regular availability'),
(2, 'Wednesday', '15:00:00', '18:00:00', 'EST', TRUE, '2024-09-01', 'After school hours'),
(2, 'Thursday', '15:00:00', '18:00:00', 'EST', TRUE, '2024-09-01', 'After school hours'),

-- Emma Williams
(3, 'Tuesday', '16:00:00', '19:00:00', 'EST', TRUE, '2024-01-10', 'Late afternoon sessions'),
(3, 'Wednesday', '16:00:00', '19:00:00', 'EST', TRUE, '2024-01-10', 'Late afternoon sessions'),
(3, 'Friday', '15:00:00', '18:00:00', 'EST', TRUE, '2024-01-10', 'End of Week sessions'),

-- David Park - Available Tuesday 5-6 PM
(4, 'Tuesday', '17:00:00', '18:00:00', 'EST', TRUE, '2024-09-01', 'Chemistry sessions'),
(4, 'Tuesday', '18:00:00', '19:00:00', 'EST', TRUE, '2024-09-01', 'Chemistry sessions'),
(4, 'Thursday', '17:00:00', '19:00:00', 'EST', TRUE, '2024-09-01', 'Regular availability'),
(4, 'Sunday', '13:00:00', '16:00:00', 'EST', TRUE, '2024-09-01', 'Weekend availability'),

-- Jessica Thompson
(5, 'Monday', '18:00:00', '20:00:00', 'EST', TRUE, '2024-02-01', 'Evening test prep'),
(5, 'Wednesday', '18:00:00', '20:00:00', 'EST', TRUE, '2024-02-01', 'Evening test prep'),
(5, 'Saturday', '09:00:00', '13:00:00', 'EST', TRUE, '2024-02-01', 'Weekend SAT/ACT prep'),

-- James Lee
(6, 'Tuesday', '19:00:00', '21:00:00', 'EST', TRUE, '2024-09-01', 'Evening sessions'),
(6, 'Thursday', '19:00:00', '21:00:00', 'EST', TRUE, '2024-09-01', 'Evening sessions'),
(6, 'Friday', '17:00:00', '19:00:00', 'EST', TRUE, '2024-09-01', 'Weekend prep'),

-- Maria Garcia
(7, 'Monday', '16:00:00', '19:00:00', 'EST', TRUE, '2024-03-15', 'Language sessions'),
(7, 'Wednesday', '16:00:00', '19:00:00', 'EST', TRUE, '2024-03-15', 'Language sessions'),
(7, 'Friday', '16:00:00', '19:00:00', 'EST', TRUE, '2024-03-15', 'Language sessions'),

-- Robert Johnson
(8, 'Tuesday', '15:00:00', '17:00:00', 'EST', TRUE, '2024-09-01', 'History tutoring'),
(8, 'Thursday', '15:00:00', '17:00:00', 'EST', TRUE, '2024-09-01', 'History tutoring'),
(8, 'Saturday', '10:00:00', '12:00:00', 'EST', TRUE, '2024-09-01', 'Weekend sessions');

-- ============================================
-- INSERT: Students (Phase 1 - Initial 5 students)
-- Purpose: Load initial student enrollment data
-- ============================================
INSERT INTO Students (FirstName, LastName, Email, Phone, ParentContact, GradeLevel, DateEnrolled, ActiveStatus) VALUES
('Emily', 'Martinez', 'emily.martinez@email.com', '401-555-1001', 'parent.martinez@email.com', 'High School', '2024-09-15', TRUE),
('Ryan', 'Smith', 'ryan.smith@email.com', '401-555-1002', 'parent.smith@email.com', 'AP', '2024-09-10', TRUE),
('Sophia', 'Johnson', 'sophia.johnson@email.com', '401-555-1003', 'parent.johnson@email.com', 'High School', '2024-09-20', TRUE),
('Daniel', 'Brown', 'daniel.brown@email.com', '401-555-1004', 'parent.brown@email.com', 'High School', '2024-10-01', TRUE),
('Olivia', 'Davis', 'olivia.davis@email.com', '401-555-1005', 'parent.davis@email.com', 'AP', '2024-09-25', TRUE);

-- ============================================
-- INSERT: Students (Phase 2 - Additional 15 students)
-- Purpose: Expand student enrollment for more comprehensive testing
-- ============================================
INSERT INTO Students (FirstName, LastName, Email, Phone, ParentContact, GradeLevel, DateEnrolled, ActiveStatus) VALUES
('Candace', 'Browning', 'candace.browning@email.com', '401-555-5755', 'parent.browning@email.com', 'High School', '2024-09-22', TRUE),
('Alisa', 'Bishop', 'alisa.bishop@email.com', '401-555-3416', 'parent.bishop@email.com', 'College', '2024-10-06', TRUE),
('Oprah', 'Mack', 'oprah.mack@email.com', '401-555-6951', 'parent.mack@email.com', 'AP', '2024-09-11', TRUE),
('Wang', 'Graham', 'wang.graham@email.com', '401-555-3594', 'parent.graham@email.com', 'High School', '2024-10-04', TRUE),
('Luke', 'Flores', 'luke.flores@email.com', '401-555-4655', 'parent.flores@email.com', 'High School', '2024-09-17', TRUE),
('Linus', 'Mosley', 'linus.mosley@email.com', '401-555-4554', 'parent.mosley@email.com', 'AP', '2024-09-21', TRUE),
('Sage', 'Chapman', 'sage.chapman@email.com', '401-555-8855', 'parent.chapman@email.com', 'High School', '2024-10-07', TRUE),
('Shelby', 'Owen', 'shelby.owen@email.com', '401-555-8162', 'parent.owen@email.com', 'High School', '2024-09-24', TRUE),
('Basia', 'Eaton', 'basia.eaton@email.com', '401-555-7428', 'parent.eaton@email.com', 'AP', '2024-10-02', TRUE),
('Dai', 'Hayden', 'dai.hayden@email.com', '401-555-4523', 'parent.hayden@email.com', 'College', '2024-10-04', TRUE),
('Baxter', 'Richard', 'baxter.richard@email.com', '401-555-3725', 'parent.richard@email.com', 'College', '2024-10-06', TRUE),
('Axel', 'England', 'axel.england@email.com', '401-555-7535', 'parent.england@email.com', 'College', '2024-09-14', TRUE),
('Guy', 'Fuller', 'guy.fuller@email.com', '401-555-3437', 'parent.fuller@email.com', 'College', '2024-10-06', TRUE),
('Rebecca', 'Cabrera', 'rebecca.cabrera@email.com', '401-555-8534', 'parent.cabrera@email.com', 'College', '2024-09-28', TRUE),
('Kay', 'Smith', 'kay.smith@email.com', '401-555-7137', 'parent.smith@email.com', 'College', '2024-10-12', TRUE);
