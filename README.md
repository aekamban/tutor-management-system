# Tutor Management System

## Problem
Manual tracking of tutoring sessions, payments, and scheduling does not scale, limiting visibility into revenue, tutor capacity, and operational efficiency for education services.

## Data
Relational data representing students, tutors, subjects, sessions, packages, enrollments, payments, and tutor expertise.  
The system is modeled using nine normalized tables with fully synthetic, realistic sample data designed for analytics and reporting.

## Methods
- Entity-relationship (ER) modeling  
- MySQL 8.0 schema design with constraints and business rules  
- Third Normal Form (3NF) normalization  
- Indexing for query performance  
- Analytical SQL queries for operational and revenue metrics  

## Outcome / Insight
Delivered an analytics-ready relational database that supports reliable reporting on revenue by subject category, tutor availability matching, and package utilization, demonstrating how strong data modeling underpins trustworthy analytics.

## Why This Matters
Applied data science roles often sit close to business operations. This project demonstrates the ability to translate real-world operational requirements into scalable, decision-supporting data infrastructure.

## Repository Structure

schema/ # Database schema and indexes

data/ # Synthetic sample data

queries/ # Analytical SQL queries

diagrams/ # ER diagrams

docs/ # Supporting documentation


## Quickstart
Tested as a final project for University of Rhode Island coursework using MySQL 8.0.

1. Run `schema/01_create_schema.sql`  
2. Run `schema/02_indexes.sql`  
3. Run `data/01_sample_data.sql`  
4. Execute queries in the `queries/` directory  

## Notes
This repository focuses on database design and analytical querying rather than application-layer development.
