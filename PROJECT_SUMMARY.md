# Tutoring Management System 

## Project Structure

```
tutoring_management_system/
├── README.md                          # Main project documentation
├── QUICKSTART.md                      # Installation and testing guide
├── .gitignore                         # Git ignore rules
│
├── schema/
│   ├── 01_create_schema.sql         # Database and table creation (9 tables)
│   └── 02_indexes.sql               # Performance indexes (13 indexes)
│
├── data/
│   └── 01_sample_data.sql           # Sample data (8 tutors, 20 students, 20 subjects)
│
└── queries/
    ├── 01_tutor_matching.sql        # Find qualified tutors by availability
    ├── 02_revenue_by_category.sql   # Revenue analysis by subject category
    └── 03_package_utilization.sql   # Track prepaid package usage
```

## What's Included

### Schema Files (schema/)
1. **01_create_schema.sql**
   - Creates `tutoring_management` database
   - 9 tables with full constraints and relationships
   - Header comments explaining purpose and prerequisites
   - All CREATE TABLE statements 

2. **02_indexes.sql**
   - 13 performance-optimized indexes
   - Foreign key indexes for JOIN operations
   - Search indexes for email/name lookups
   - Composite indexes for complex queries
   - Clear header and grouping comments

### Data Files (data/)
1. **01_sample_data.sql**
   - INSERT statements for all base tables
   - 20 subjects across 3 pricing tiers
   - 8 tutors with bios and contact info
   - 26 tutor-subject expertise mappings
   - 28 availability time slots
   - 20 students (5 initial + 15 Phase 2)

### Query Files (queries/)
Each query file includes:
- Purpose and use case explanation
- Prerequisites
- Expected results documentation

1. **01_tutor_matching.sql**
   - Multi-table JOIN query
   - Find tutors by subject, availability, and rating
   - Demonstrates: Aggregation, GROUP BY, HAVING

2. **02_revenue_by_category.sql**
   - Business analytics query
   - Revenue breakdown by subject category
   - Demonstrates: LEFT JOINs, business metrics

3. **03_package_utilization.sql**
   - Operational monitoring query
   - Track prepaid package usage
   - Demonstrates: Calculated fields, filtering

### Documentation
1. **README.md**
   - Installation instructions
   - Project overview and features
   - Sample data description
   - Database schema summary
   - Academic context
   - Contact information

2. **QUICKSTART.md**
   - Step-by-step installation guide
   - Verification queries
   - Common operations examples
   - Troubleshooting section
   - MySQL command reference

3. **.gitignore**
   - Ignores backup files
   - Ignores IDE configurations
   - Ignores OS-specific files
   - Protects sensitive information
