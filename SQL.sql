---Create table

create table hrdata
(
	emp_no int8 PRIMARY KEY,
	gender varchar(50) NOT NULL,
	marital_status varchar(50),
	age_band varchar(50),
	age int8,
	department varchar(50),
	education varchar(50),
	education_field varchar(50),
	job_role varchar(50),
	business_travel varchar(50),
	employee_count int8,
	attrition varchar(50),
	attrition_label varchar(50),
	job_satisfaction int8,
	active_employee int8
)


Select * from hrdata

----Employee count
select sum(employee_count) as Employee_Count from hrdata;

----Attrition count
select count(attrition) from hrdata where attrition='Yes';


----Attrition rate
select round(((select count(attrition) from hrdata where attrition ='Yes' and department='Sales')/
sum (employee_count))*100,2) from hrdata
where department = 'Sales'


----Active employee
select sum(employee_count)-(select count(attrition) from hrdata where attrition ='Yes'
						   and gender='Male')
from hrdata where gender ='Male'

----Average age
Select round (avg(age),0) as Avg_age from hrdata

----Attrition by gender

select gender, count (attrition) from hrdata
where attrition='Yes' and education ='High School'
group by gender
order by count(attrition) desc

---Department wise attrition
select department, count(attrition) from hrdata
where attrition='Yes'
group by department
order by count (attrition) desc

select department, count(attrition),
round((cast(count (attrition) as numeric)
	  /(select count(attrition) from hrdata where attrition='Yes'))*100,2) as pct
from hrdata
where attrition='Yes' and gender='Female'
group by department
order by count (attrition) desc

----No of employee by age group
select age, sum(employee_count) from hrdata
where department ='R&D'
group by age

---Education Field wise Attrition
Select education_field, count (attrition) from hrdata
where attrition ='Yes' and department='Sales'
group by education_field
order by count(attrition) desc

---Attrition rate by gender for different age group
Select age_band,gender, count (attrition) from hrdata
where attrition ='Yes' 
group by age_band,gender
order by age_band,gender

Select age_band,gender, count (attrition), 
round((cast(count(attrition)as numeric)/
(select count(attrition)from hrdata where attrition='Yes'))*100,2) as pct
from hrdata
where attrition ='Yes' 
group by age_band,gender
order by age_band,gender

---Job satisfaction rating
CREATE EXTENSION IF NOT EXISTS tablefunc;


SELECT *
FROM crosstab(
  'SELECT job_role, job_satisfaction, sum(employee_count)
   FROM hrdata
   GROUP BY job_role, job_satisfaction
   ORDER BY job_role, job_satisfaction'
	) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;

---No of employee by age group

Select age_band, gender,sum(employee_count) from hrdata
group by age_band,gender
order by age_band,gender desc



