-- DATA MODELLING
-- Inspect the CSVs and sketch out an ERD of the tables
-- SEE Employee_ERD.sql file

-- DATA ENGINEERING 
--
-- Create table schema for each of the six csv files
-- Import each CSV file into the corresponding SQL table
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS departments;

-- departments.csv
CREATE TABLE departments(
	dept_no VARCHAR(10) PRIMARY KEY not null ,
	dept_name VARCHAR(50) UNIQUE not null
);
select * from departments;

-- dept_emp.csv
CREATE TABLE dept_emp(
	emp_no INT not null ,
	dept_no VARCHAR(10) not null,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
select * from dept_emp;

-- dept_manager.csv
CREATE TABLE dept_manager(
	dept_no VARCHAR(10) not null ,
	emp_no INT PRIMARY KEY not null,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
-- 	FOREIGN KEY (emp_no) REFERENCES dept_emp(emp_no)
);
select * from dept_manager;

-- salaries.csv
CREATE TABLE salaries(
	emp_no INT not null PRIMARY KEY,
	salary INT not null
);
select * from salaries;

-- titles.csv
CREATE TABLE titles(
	title_id VARCHAR(10) PRIMARY KEY not null ,
	title VARCHAR(50) UNIQUE not null
);
select * from titles;

-- employees.csv
CREATE TABLE employees(
	emp_no INT PRIMARY KEY not null ,
	emp_title_id VARCHAR(10) not null,
	birth_date DATE,
	first_name VARCHAR(50) not null,
	last_name VARCHAR(50) not null,
	sex VARCHAR(1) not null,
	hire_date DATE,
-- 	FOREIGN KEY (emp_no) REFERENCES dept_emp(emp_no),
-- 	FOREIGN KEY (emp_no) REFERENCES dept_manager(emp_no),
	FOREIGN KEY (emp_no) REFERENCES salaries(emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);
select * from employees;

-- DATA ANALYSIS
--
-- 1. List the following details of each employee: 
-- employee number, last name, first name, sex, and salary.
SELECT e.emp_no, 
	e.last_name, 
	e.first_name, 
	e.sex, 
	s.salary
FROM employees as e
	JOIN salaries as s
		ON e.emp_no = s.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT 
	first_name, 
	last_name,
	hire_date
FROM employees
	WHERE hire_date
	BETWEEN '1986-01-01' AND '1986-12-31';

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT
	m.dept_no, 
	d.dept_name, 
	m.emp_no, 
	e.last_name, 
	e.first_name
FROM dept_manager as m
	JOIN departments as d
		ON m.dept_no = d.dept_no
	JOIN employees as e
		ON e.emp_no = m.emp_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT
	e.emp_no,
	e.last_name, 
	e.first_name,
	d.dept_name
FROM employees as e
	JOIN dept_emp as de
		ON e.emp_no = de.emp_no
	JOIN departments as d
		ON de.dept_no = d.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B".
SELECT
	first_name, 
	last_name,
	sex
FROM employees
	WHERE first_name = 'Hercules' 
	AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT
	e.emp_no, 
	e.last_name, 
	e.first_name,
	d.dept_name
FROM employees as e
	JOIN dept_emp as de
		ON e.emp_no = de.emp_no
	JOIN departments as d
		ON de.dept_no = d.dept_no
		WHERE d.dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT
	e.emp_no, 
	e.last_name, 
	e.first_name,
	d.dept_name
FROM employees as e
	JOIN dept_emp as de
		ON e.emp_no = de.emp_no
	JOIN departments as d
		ON de.dept_no = d.dept_no
		WHERE d.dept_name = 'Sales'
		OR d.dept_name = 'Development';

-- 8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
SELECT
	last_name,
	COUNT(last_name) as last_name_frequency
FROM employees
	GROUP BY last_name
	ORDER BY last_name_frequency DESC;

-- Bonus (Optional)
--
-- 1. Import the SQL database into Pandas


-- 2. Create a histogram to visualize the most common salary ranges for employees

-- 3. Create a bar chart of average salary by title
