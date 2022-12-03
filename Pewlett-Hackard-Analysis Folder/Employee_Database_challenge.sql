-- Module 7 Challenge
-- Create retirement_titles table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
-- INTO retirement_titles
FROM employees AS e
	LEFT JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no, t.title DESC
;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
-- INTO unique_titles
FROM retirement_titles AS rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC
;

SELECT COUNT(title) AS "count",
	ut.title
-- INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY "count" DESC
;

SELECT COUNT 

-- Deliverable 2
-- Mentorship Eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
-- INTO mentorship_eligibility
FROM employees AS e
	LEFT JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS t
		ON (de.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no
;

SELECT COUNT (first_name) AS "Total numer of mentor ready employees"
-- INTO mentorship_count
FROM mentorship_eligibility;

-- Number of mentors per title
SELECT COUNT(title) AS "count",
	me.title
-- INTO mentorship_department_count
FROM mentorship_eligibility AS me
GROUP BY me.title
ORDER BY "count" DESC
;

-- How many total employees may retire 
-- over the course of the "silver tsunami"
SELECT COUNT (first_name) AS "Total numer of retiring employees"
-- INTO retiring_total
FROM unique_titles;

-- CREATE remaining_titles
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
-- INTO remaining_titles
FROM employees AS e
	LEFT JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date NOT BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no, t.title DESC
;

-- Use Dictinct with Orderby to remove
-- duplicate rows in remaining titles
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
-- INTO unique_remaining_titles
FROM remaining_titles AS rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC
;

-- Number of employees remaining per title
SELECT COUNT(title) AS "count",
	urt.title
-- INTO number_remaining_titles
FROM unique_remaining_titles AS urt
GROUP BY urt.title
ORDER BY "count" DESC
;