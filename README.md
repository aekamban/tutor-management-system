# Tutor Management System

## Problem
Manual tracking of tutoring sessions, payments, and scheduling does not scale, limiting visibility into revenue, tutor capacity, and operational efficiency for education services.

## Data
Relational data representing students, tutors, subjects, sessions, packages, enrollments, payments, and tutor expertise.
The system is modeled using nine normalized tables with realistic, fully synthetic sample data designed for analytics and reporting.

## Methods
- Entity-relationship (ER) modeling
- MySQL 8.0 schema design with constraints and business rules
- Third Normal Form (3NF) normalization
- Indexing for query performance
- Analytical SQL queries for operational and revenue metrics

## Outcome / Insight
Delivered an analytics-ready relational database that supports reliable reporting on revenue by subject category, tutor availability matching, and package utilization—demonstrating how strong data modeling underpins trustworthy analytics.

## Why This Matters
Applied data science roles often sit close to business operations. This project demonstrates the ability to translate real-world operational requirements into scalable, decision-supporting data infrastructure.

## Repository Structure
schema/ # Database schema and indexes
data/ # Synthetic sample data
queries/ # Analytical SQL queries
diagrams/ # ER diagrams
docs/ # Supporting documentation

## Database Schema

The system consists of 9 interconnected tables:

### Core Tables
- **Students** - Student profiles and enrollment information
- **Tutors** - Tutor profiles, contact details, and bios
- **Subjects** - Subject catalog with tiered pricing ($55-$75/hour)
- **Sessions** - Individual tutoring session appointments

### Junction Tables
- **Session_Enrollments** - Links students to sessions (enables group sessions)
- **Tutor_Subject_Expertise** - Maps tutors to their qualified subjects
- **Tutor_Availability** - Weekly recurring availability schedules

### Supporting Tables
- **Session_Packages** - Prepaid 8-session packages with discount tracking
- **Payments** - Transaction records with Stripe integration

## Pricing Structure

| Category | Hourly Rate | Examples |
|----------|-------------|----------|
| Math/Science | $75/hour | AP Calculus, Chemistry, Physics |
| Languages | $65/hour | Spanish, French, Mandarin |
| Other | $55/hour | SAT Prep, History, Essay Writing |

**Package Discount:** $5 off per session when purchasing 8-session packages

## Getting Started

### Prerequisites
- MySQL 8.0 or higher
- MySQL Workbench (optional, for GUI)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/tutoring-management-system.git
   cd tutoring-management-system
   ```

2. **Run the SQL files in order:**

   ```bash
   # Step 1: Create database and tables
   mysql -u your_username -p < schema/01_create_schema.sql
   
   # Step 2: Create indexes for performance
   mysql -u your_username -p < schema/02_indexes.sql
   
   # Step 3: Load sample data
   mysql -u your_username -p < data/01_sample_data.sql
   ```

3. **Run showcase queries** (optional)
   ```bash
   mysql -u your_username -p tutoring_management < queries/01_tutor_matching.sql
   mysql -u your_username -p tutoring_management < queries/02_revenue_by_category.sql
   mysql -u your_username -p tutoring_management < queries/03_package_utilization.sql
   ```

## Sample Queries

### 1. Tutor Matching (`01_tutor_matching.sql`)
Find qualified tutors with high ratings (≥4.0) for specific subjects and time slots.

**Example:** Find AP Calculus tutors available Tuesday 5-6 PM EST

### 2. Revenue Analysis (`02_revenue_by_category.sql`)
Business analytics query showing revenue breakdown by subject category.

**Insight:** Validates effectiveness of tiered pricing strategy

### 3. Package Utilization (`03_package_utilization.sql`)
Track prepaid package usage to identify students who need scheduling reminders.

**Operational Use:** Proactive student engagement and package expiration management

## Sample Data Included

- **8 Tutors** with diverse subject expertise
- **20 Students** across various grade levels
- **20 Subjects** spanning Math/Science, Languages, and Test Prep
- **40+ Sessions** demonstrating individual and group scenarios
- **Complete availability schedules** for all tutors

## Entity Relationships

```
Students ──┬── Session_Enrollments ──── Sessions ──── Tutors
           │                                 │
           └── Session_Packages              └── Subjects
           │
           └── Payments

Tutors ──── Tutor_Subject_Expertise ──── Subjects
       │
       └── Tutor_Availability
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

**Abi Kambanis**
- MS in Data Science, University of Rhode Island

## Contributing

This is an academic project, but suggestions and feedback are welcome! Feel free to:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## Contact

For questions or feedback about this project, please reach out via GitHub issues.

---

**Note:** This database includes sample data for demonstration purposes. For production use, implement proper security measures, user authentication, and backup procedures.
