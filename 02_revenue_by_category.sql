-- ============================================
-- Purpose: Analyze revenue generation by subject category
-- Prerequisites: Run schema, indexes, and sample data first
-- 
-- Use Case: Business analytics to evaluate the effectiveness of tiered pricing
-- and identify which subject categories generate the most revenue
-- 
-- Demonstrates: Aggregation, GROUP BY, LEFT JOINs, Business metrics calculation
-- ============================================

USE tutoring_management;

SELECT 
    Subj.SubjectCategory,
    Subj.HourlyRate AS StandardRate,
    COUNT(DISTINCT S.SessionID) AS TotalSessions,
    COUNT(SE.EnrollmentID) AS TotalEnrollments,
    CONCAT('$', FORMAT(SUM(P.Amount), 2)) AS TotalRevenue
FROM Subjects Subj
LEFT JOIN Sessions S ON Subj.SubjectID = S.SubjectID
LEFT JOIN Session_Enrollments SE ON S.SessionID = SE.SessionID
LEFT JOIN Payments P ON SE.StudentID = P.StudentID
WHERE P.PaymentStatus = 'Completed'
GROUP BY Subj.SubjectCategory, Subj.HourlyRate
ORDER BY SUM(P.Amount) DESC;

-- Expected Results:
-- Revenue breakdown by subject category (Math/Science, Language, Other)
-- Math/Science subjects typically generate highest revenue due to $75/hour premium pricing
-- Validates the business value of the tiered pricing structure
