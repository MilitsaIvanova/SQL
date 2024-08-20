# SQL Course Exercises and Tasks

Welcome to the repository where I store all the SQL exercises and tasks I have completed during my SQL course. This repository is organized according to the syllabus of the course, covering everything from SQL basics to advanced topics and professional-level techniques. Below is an overview of the course content and what you can expect to find in each file within this repository.

## Syllabus Overview

### 1. Basics: Filtering
- **`WHERE`**: Filter rows based on specific conditions.
- **`AND/OR`**: Combine multiple conditions in a `WHERE` clause.
- **`BETWEEN`**: Filter values within a specific range.
- **`IN`**: Filter rows that match any value in a list.
- **`LIKE`**: Perform pattern matching in strings.

### 2. Basics: Grouping
- **`GROUP BY`**: Group rows that have the same values in specified columns.
- **`HAVING`**: Filter groups based on aggregate functions.

### 3. Intermediate: Functions
- **String Functions**:
  - `LENGTH`, `LOWER`, `UPPER`: Analyze and modify string data.
  - `LEFT`, `RIGHT`: Extract characters from strings.
  - `Concatenate`: Combine multiple strings into one.
  - `SUBSTRING`, `POSITION`: Extract and locate parts of a string.
- **Date/Time Functions**:
  - `EXTRACT`, `TO_CHAR`: Extract and format date and time values.
  - `intervals`, `timestamps`: Work with time intervals and timestamps.

### 4. Intermediate: Conditional Expressions
- **Mathematical Functions and Operators**: Perform mathematical operations.
- **`CASE WHEN`**: Apply conditional logic in queries.
- **`CASE WHEN` and `SUM`**: Use conditional logic with aggregation.
- **`COALESCE`**: Handle `NULL` values by providing default values.
- **`CAST` and `COALESCE`**: Convert data types and manage `NULL` values.
- **`REPLACE`**: Replace parts of a string with new values.

### 5. Intermediate: Joins
- **Join Types**:
  - `INNER JOIN`, `FULL OUTER JOIN`: Combine rows from related tables.
  - `LEFT OUTER JOIN`, `RIGHT OUTER JOIN`: Combine rows with or without matching values in related tables.
- **Join Techniques**:
  - Join multiple tables.
  - Joins on multiple conditions.

### 6. Advanced: UNION and Subqueries
- **`UNION`**: Combine the results of two or more `SELECT` statements.
- **Subqueries**:
  - In `WHERE`, `FROM`, `SELECT`: Use queries within queries.
  - Correlated Subqueries: Subqueries that depend on the outer query.

### 7. Advanced: Managing Tables and Databases
- **Database Management**:
  - `CREATE DATABASE`, `DROP DATABASE`: Create and delete databases.
  - Constraints: Define rules for data integrity.
  - Primary and Foreign Key: Establish relationships between tables.
- **Table Management**:
  - `INSERT`, `ALTER TABLE`: Insert data and modify table structure.
  - `TRUNCATE`, `DROP TABLE`: Remove data or tables.
  - `CHECK`: Enforce conditions on data.

### 8. Advanced: Views and Data Manipulation
- **Views**:
  - `CREATE TABLE AS`: Create a new table based on the results of a query.
  - `CREATE VIEW`, `CREATE MATERIALIZED VIEW`: Create virtual tables.
  - Managing Views: `DROP VIEW`, `ALTER VIEW` (rename columns, rename view).

### 9. Pro: Window Functions
- **Window Functions**:
  - `OVER` with `PARTITION BY`, `ORDER BY`: Perform calculations across sets of table rows.
  - `RANK`: Assign a rank to each row within a partition.
  - `FIRST_VALUE()`, `LEAD`, `LAG`: Access different rows in a dataset.

### 10. Pro: Grouping Sets, Rollups, Self-Joins
- **Advanced Grouping**:
  - `GROUPING SETS`, `ROLLUP`, `CUBE`: Aggregate data in multiple ways.
- **Joins**:
  - `SELF JOIN`: Join a table with itself.
  - `CROSS JOIN`, `NATURAL JOIN`: Join tables without or with natural key relationships.

### 11. Pro: Stored Procedures, Transactions, and User-Defined Functions
- **Stored Procedures**: Reusable SQL code blocks.
- **Transactions**: Manage multiple SQL operations as a single unit.
- **User-Defined Functions**: Create custom functions to perform operations.

### 12. Pro: Indexes, Partitioning, and Query Optimization
- **User Management**:
  - `CREATE USER`, `ROLE`: Manage database users and roles.
  - `GRANT`, `REVOKE` Privileges: Control access to database objects.
- **Indexes**:
  - `B-tree`, `Bitmap Index`: Improve query performance.
  - Index Guidelines: Best practices for creating indexes.
- **Query Optimization**:
  - `EXPLAIN PLAN`: Analyze and optimize query performance.

### 13. CTEs (Common Table Expressions)
- **Using CTEs**: Simplify complex queries using temporary result sets.
- **Recursive CTEs**: Handle hierarchical data with recursion.

## How to Use This Repository

Each SQL file in this repository corresponds to a specific topic or set of tasks outlined in the course syllabus.

### File Naming Convention
- Files are organized by day or topic, making it easy to follow along with the course material.
