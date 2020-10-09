SELECT 	emp_no,	
		first_name,
		last_name
FROM employees
--
SELECT 	title, 
		from_date, 
		to_date
FROM titles

-- Create the retirement titles table
SELECT 	e.emp_no,	
		e.first_name,
		e.last_name,
		ti.title,
		ti.from_date,
		ti.to_date
INTO retirement_titles
FROM employees e
LEFT JOIN titles ti
ON e.emp_no=ti.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' and '1955-12-31'

-- Use Dictinct with Orderby to remove duplicate rows
-- Create the unique titles table 
SELECT DISTINCT ON 	(emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Create the retiring titles table
SELECT COUNT(title) AS total, 
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY total DESC;

-- Create mentorship eligibility table
SELECT  DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees e
LEFT JOIN dept_emp de
ON e.emp_no =de.emp_no
LEFT JOIN titles ti
ON e.emp_no =ti.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date = '9999-01-01')
ORDER BY emp_no, de.to_date

