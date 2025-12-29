-- ============================================
-- Purpose: Find qualified tutors with high ratings for specific time slots
-- Prerequisites: Run schema, indexes, and sample data first
-- 
-- Use Case: Student needs an AP Calculus tutor available Tuesday 5-6 PM EST
-- with a minimum average rating of 4.0/5.0
-- 
-- Demonstrates: Multiple JOINs, Aggregation, GROUP BY, HAVING clauses
-- ============================================

USE tutoring_management;

SELECT 
    CONCAT(T.FirstName, ' ', T.LastName) AS TutorName,
    T.Email,
    S.SubjectName,
    ROUND(AVG(SE.SessionRating), 2) AS AvgRating,
    COUNT(DISTINCT Sess.SessionID) AS SessionsTaught,
    TA.DayOfWeek,
    TIME_FORMAT(TA.StartTime, '%h:%i %p') AS AvailableStart,
    TIME_FORMAT(TA.EndTime, '%h:%i %p') AS AvailableEnd
FROM Tutors T
INNER JOIN Tutor_Subject_Expertise TSE ON T.TutorID = TSE.TutorID
INNER JOIN Subjects S ON TSE.SubjectID = S.SubjectID
INNER JOIN Sessions Sess ON T.TutorID = Sess.TutorID
INNER JOIN Session_Enrollments SE ON Sess.SessionID = SE.SessionID
INNER JOIN Tutor_Availability TA ON T.TutorID = TA.TutorID
WHERE 
    S.SubjectName = 'AP Calculus AB'
    AND TA.DayOfWeek = 'Tuesday'
    AND TA.StartTime <= '17:00:00'
    AND TA.EndTime >= '18:00:00'
    AND SE.SessionRating IS NOT NULL
GROUP BY T.TutorID, S.SubjectName, TA.AvailabilityID
HAVING AVG(SE.SessionRating) >= 4.0
ORDER BY AvgRating DESC;

-- Expected Results:
-- Shows qualified AP Calculus tutors with high ratings (≥4.0) 
-- who are available during the requested time slot.
-- Tutors are ranked by average rating (highest first).
