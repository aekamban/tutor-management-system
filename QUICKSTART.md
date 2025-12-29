# Quick Start Guide

Tested as a final project for University of Rhode Island coursework using MySQL 8.0.

1. Run `schema/01_create_schema.sql`
2. Run `schema/02_indexes.sql`
3. Run `data/01_sample_data.sql`
4. Execute queries in the `queries/` directory

## Installation Instructions

### Method 1: MySQL Command Line

```bash
# Navigate to the project directory
cd tutoring-management-system

# Run all setup scripts in sequence
mysql -u root -p < schema/01_create_schema.sql
mysql -u root -p < schema/02_indexes.sql
mysql -u root -p < data/01_sample_data.sql

# Verify installation
mysql -u root -p -e "USE tutoring_management; SHOW TABLES;"
```

### Method 2: MySQL Workbench

1. Open MySQL Workbench
2. Connect to your MySQL server
3. Open and execute files in order:
   - `schema/01_create_schema.sql`
   - `schema/02_indexes.sql`
   - `data/01_sample_data.sql`
4. Verify tables are created: `SHOW TABLES;`

## Testing the Database

### Quick Verification Queries

```sql
-- Count records in each table
USE tutoring_management;

SELECT 'Students' AS Table_Name, COUNT(*) AS Record_Count FROM Students
UNION ALL
SELECT 'Tutors', COUNT(*) FROM Tutors
UNION ALL
SELECT 'Subjects', COUNT(*) FROM Subjects
UNION ALL
SELECT 'Tutor_Subject_Expertise', COUNT(*) FROM Tutor_Subject_Expertise
UNION ALL
SELECT 'Tutor_Availability', COUNT(*) FROM Tutor_Availability;
```

Expected results:
- Students: 20
- Tutors: 8
- Subjects: 20
- Tutor_Subject_Expertise: 26
- Tutor_Availability: 28

### Run Sample Queries

```bash
# Query 1: Find qualified tutors with ratings
mysql -u root -p tutoring_management < queries/01_tutor_matching.sql

# Query 2: Revenue analysis
mysql -u root -p tutoring_management < queries/02_revenue_by_category.sql

# Query 3: Package utilization
mysql -u root -p tutoring_management < queries/03_package_utilization.sql
```

## Common Operations

### View All Tutors with Their Subjects
```sql
SELECT 
    CONCAT(T.FirstName, ' ', T.LastName) AS TutorName,
    GROUP_CONCAT(S.SubjectName ORDER BY S.SubjectName SEPARATOR ', ') AS Subjects
FROM Tutors T
JOIN Tutor_Subject_Expertise TSE ON T.TutorID = TSE.TutorID
JOIN Subjects S ON TSE.SubjectID = S.SubjectID
WHERE T.ActiveStatus = TRUE
GROUP BY T.TutorID, T.FirstName, T.LastName
ORDER BY TutorName;
```

### Check Tutor Availability for a Specific Day
```sql
SELECT 
    CONCAT(T.FirstName, ' ', T.LastName) AS TutorName,
    TA.DayOfWeek,
    TIME_FORMAT(TA.StartTime, '%h:%i %p') AS StartTime,
    TIME_FORMAT(TA.EndTime, '%h:%i %p') AS EndTime,
    TA.Timezone
FROM Tutors T
JOIN Tutor_Availability TA ON T.TutorID = TA.TutorID
WHERE TA.DayOfWeek = 'Tuesday' 
  AND TA.IsAvailable = TRUE
ORDER BY TA.StartTime;
```

### View Subjects by Price Category
```sql
SELECT 
    SubjectCategory,
    HourlyRate,
    COUNT(*) AS SubjectCount,
    GROUP_CONCAT(SubjectName ORDER BY SubjectName SEPARATOR ', ') AS Subjects
FROM Subjects
WHERE IsActive = TRUE
GROUP BY SubjectCategory, HourlyRate
ORDER BY HourlyRate DESC;
```

## Troubleshooting

### Issue: "Database already exists"
```sql
-- Drop and recreate
DROP DATABASE IF EXISTS tutoring_management;
-- Then re-run 01_create_schema.sql
```

### Issue: "Cannot add foreign key constraint"
Make sure you're running the files in the correct order:
1. Schema first (creates all tables)
2. Indexes second
3. Data last

### Issue: "Access denied for user"
```bash
# Grant necessary privileges
mysql -u root -p -e "GRANT ALL PRIVILEGES ON tutoring_management.* TO 'your_user'@'localhost';"
mysql -u root -p -e "FLUSH PRIVILEGES;"
```

## Resetting the Database

To start fresh:
```sql
DROP DATABASE IF EXISTS tutoring_management;
```

Then re-run all three SQL files in order.

## Useful MySQL Commands

```sql
-- Show database structure
SHOW DATABASES;
USE tutoring_management;
SHOW TABLES;
DESCRIBE Students;

-- Check indexes
SHOW INDEX FROM Sessions;

-- View constraints
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE TABLE_SCHEMA = 'tutoring_management';
```

## Notes
This repository focuses on database design and analytical querying rather than application-layer development.

