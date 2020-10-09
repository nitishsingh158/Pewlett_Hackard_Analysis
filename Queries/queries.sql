SELECT * FROM departments;

SELECT * FROM dept_manager;

SELECT departments.dept_no, dept_manager.emp_no, dept_manager.from_date, dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

SELECT 	retirement_info.emp_no,
		retirement_info.first_name,
		retirement_info.last_name,
		dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no

SELECT 	ri.emp_no,
		ri.first_name,
		ri.last_name,
		de.to_date
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no

SELECT	ri.emp_no,
		ri.first_name,
		ri.last_name,
		de.to_date
INTO current_emp
FROM retirement_info ri
LEFT JOIN dept_emp de
ON ri.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01';
		
SELECT de.dept_no, COUNT(ce.emp_no) AS number_employees
INTO retiring_dept
FROM current_emp ce
LEFT JOIN dept_emp de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY 2 DESC;

SELECT emp_no, first_name, last_name, gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT	e.emp_no,
		e.first_name,
		e.last_name,
		e.gender,
		s.salary,
		de.to_date
INTO	emp_info
FROM 	employees e
INNER JOIN 	salaries s
ON 	e.emp_no = s.emp_no
INNER JOIN 	dept_emp de
ON 	e.emp_no = de.emp_no
WHERE 	(e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
		AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
		AND (de.to_date = '9999-01-01');
		

-- Select managers from each dept
SELECT 	dm.dept_no,
		d.dept_name,
		dm.emp_no, 
		ce.first_name,
		ce.last_name,
		dm.from_date,
		dm.to_date
INTO 	manager_info
FROM dept_manager dm
INNER JOIN current_emp ce
ON dm.emp_no = ce.emp_no
INNER JOIN departments d
ON dm.dept_no = d.dept_no

-- Current Emp list with departments
SELECT 	ce.emp_no,
		ce.first_name,
		ce.last_name,
		d.dept_name
INTO dept_info
FROM current_emp ce
INNER JOIN dept_emp de 
ON ce.emp_no = de.emp_no
INNER JOIN departments d
ON de.dept_no = d.dept_no

SELECT 	e.emp_no,
		e.first_name,
		e.last_name,
		d.dept_name
FROM employees e
LEFT JOIN dept_emp de
ON e.emp_no = de.emp_no
LEFT JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales','Development')


