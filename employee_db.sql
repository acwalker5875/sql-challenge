DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_mgr;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;


CREATE TABLE department (
  dept_no varchar(10) NOT NULL,
  dept_name varchar(20) NOT NULL
);

CREATE TABLE employees (
  emp_no integer NOT NULL,
  emp_title_id varchar (10) NOT NULL,
  birthdate date NOT NULL,
  first_name varchar (20) NOT NULL,
  last_name varchar (20) NOT NULL,
  sex varchar (10),
  hire_date date NOT NULL
);

CREATE TABLE dept_emp (
  emp_no integer NOT NULL,
  dept_no character varying(20) NOT NULL
);

CREATE TABLE dept_mgr (
    dept_no character varying(20) NOT NULL,
    emp_no integer NOT NULL
);

CREATE TABLE salaries (
  emp_no integer NOT NULL,
  salary integer NOT NULL
);

CREATE TABLE titles (
  title_id varchar (10) NOT NULL,
  title character varying(30) NOT NULL
);


-- List the employee number, last name, first name, sex, and salary of each employee (2 points)
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s
ON (e.emp_no = s.emp_no);

-- List the first name, last name, and hire date for the employees who were hired in 1986 (2 points)
SELECT first_name, last_name, hire_date
FROM employees
WHERE YEAR(hire_date) = 1986;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name (2 points)
SELECT n.dept_no, d.dept_name, n.emp_no, e.last_name, e.first_name
FROM dept_mgr n 
JOIN employees e on n.emp_no = e.emp_no
JOIN department d on n.dept_no = d.dept_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name (2 points)
SELECT n.dept_no, n.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp n
JOIN employees e on n.emp_no = e.emp_no
JOIN department d on n.dept_no = d.dept_no;


-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B (2 points)
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name (2 points)
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN
	( 
		SELECT emp_no
		FROM dept_emp
		WHERE dept_no IN
		( 
			SELECT dept_no
			FROM department
			WHERE dept_name = 'Sales'
		)
	);
	
-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name (4 points)
SELECT n.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp n
JOIN employees e on n.emp_no = e.emp_no
JOIN department d on n.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';



-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) (4 points)
SELECT last_name, COUNT(last_name)AS Frequency
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;
