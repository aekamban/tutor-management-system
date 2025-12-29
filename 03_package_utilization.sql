-- ============================================
-- Purpose: Track prepaid package utilization for active students
-- Prerequisites: Run schema, indexes, and sample data first
-- 
-- Use Case: Operational monitoring to identify students who need reminders
-- to schedule sessions before their package credits expire
-- 
-- Demonstrates: JOINs, Calculated fields, Filtering, Percentage calculations
-- ============================================

USE tutoring_management;

SELECT 
    CONCAT(St.FirstName, ' ', St.LastName) AS StudentName,
    St.GradeLevel,
    SP.PurchaseDate,
    SP.TotalSessions,
    SP.SessionsUsed,
    SP.SessionsRemaining,
    CONCAT(ROUND((SP.SessionsUsed / SP.TotalSessions * 100), 1), '%') AS UtilizationRate,
    CONCAT('$', FORMAT(SP.TotalPaid, 2)) AS AmountPaid,
    SP.PackageStatus
FROM Students St
INNER JOIN Session_Packages SP ON St.StudentID = SP.StudentID
WHERE SP.PackageStatus = 'Active'
ORDER BY SP.SessionsRemaining ASC;

-- Expected Results:
-- List of students with active prepaid packages, ordered by remaining sessions (lowest first)
-- Students with low remaining credits may need reminders to schedule sessions
-- Demonstrates the package credit management and utilization tracking system
