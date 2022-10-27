-- DATA MODELLING
-- Inspect the CSVs and sketch out an ERD of the tables

---- SEE Employee_ERD.sql file

-- DATA ENGINEERING 
-- Create table schema for each of the six csv files
-- Import each CSV file into the corresponding SQL table

CREATE TABLE departments(
	dept_no VARCHAR(10) not null,
	dept_name VARCHAR(50) not null
);

CREATE TABLE dept_emp(
	emp_no INT not null,
	dept_no VARCHAR(10) not null
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(10) not null,
	emp_no INT not null
);

CREATE TABLE employees(
	emp_no INT not null,
	emp_title_id VARCHAR(10) not null,
	birth_date DATE,
	first_name VARCHAR(50) not null,
	last_name VARCHAR(50) not null,
	sex VARCHAR(1) not null,
	hire_date DATE
);

CREATE TABLE salaries(
	emp_no INT not null,
	salary INT not null
);

CREATE TABLE titles(
	title_id VARCHAR(10) not null,
	title VARCHAR(50) not null
);

-- DATA ANALYSIS
-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.

-- 2. List first name, last name, and hire date for employees who were hired in 1986.

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

-- 8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.

-- Bonus (Optional)
-- 1. Import the SQL database into Pandas

-- 2. Create a histogram to visualize the most common salary ranges for employees

-- 3. Create a bar chart of average salary by title
