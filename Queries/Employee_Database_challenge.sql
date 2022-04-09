--Create a table for the titles of retiring employees
select e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
into retirement_titles
from employees as e
inner join titles as t
on e.emp_no = t.emp_no
where (e.birth_date between '1952-01-01' and '1955-12-31')
order by e.emp_no;

select * from retirement_titles

--Use Distinct with Orderby to remove duplicate rows
select distinct on (emp_no) emp_no, first_name, last_name, title
into unique_titles
from retirement_titles
where to_date = '9999-01-01'
order by emp_no, to_date desc;

select * from unique_titles

--Create a count of retiring employees' titles
select count(title), title
into retiring_titles
from unique_titles
group by title 
order by count(title) desc;

select * from retiring_titles

--create a table of current employees eligible to be mentors to new employees
select distinct on (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, e.gender, de.from_date, de.to_date, t.title
into mentorship_eligibility
from employees as e
join dept_emp as de on (e.emp_no = de.emp_no)
join titles as t on (e.emp_no = t.emp_no)
where (e.birth_date between '1965-01-01' and '1965-12-31') and (de.to_date = '9999-01-01')
order by e.emp_no
;

select * from mentorship_eligibility

-- Most veteran PH employees
select count(*) from mentorship_eligibility 
where (to_date = '9999-01-01') and (from_date between '1900-01-01' and '1989-12-31');

-- Share of potential mentors that are women 
select count(*) from mentorship_eligibility
where gender = 'F'












