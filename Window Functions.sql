USE user;

CREATE TABLE marks (
 student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);

INSERT INTO marks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51)

SELECT * FROM marks;



SELECT *, AVG(marks) OVER(PARTITION BY branch)
FROM user.marks;


SELECT *,
AVG(marks) Over() AS 'Overall_avg',
MIN(marks) OVER(),
MAX(marks) OVER(),
MIN(marks) OVER(PARTITION BY branch),
MAX(marks) OVER(PARTITION BY branch)
FROM marks
ORDER BY student_id;

--Aggregate Function with OVER()
--Find all the students who have marks higgher than avg marks of thir respective branch

SELECT * FROM(SELECT *,
AVG(marks) OVER(PARTITION BY branch) AS "branch_avg"
FROM marks) t
WHERE t.marks > t.branch_avg;

--RANK/DENSE_RANK/ROW_NUMBER

SELECT *,
RANK() OVER(PARTITION BY branch ORDER BY marks DESC),
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC)
FROM marks;
--DENSE_RANK
SELECT *,
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC)
FROM marks;
--ROW_NUMBER
SELECT *,
ROW_NUMBER() OVER(PARTITION BY  branch)
FROM marks

SELECT *,
CONCAT(branch,'_',ROW_NUMBER() OVER(PARTITION BY branch))
FROM marks;


--1.Find top 2 mostpaying customers of each month


SELECT * FROM (SELECT date, MONTH(date) AS 'month',user_id,SUM(amount) AS 'total',
              RANK() OVER(PARTITION BY MONTHNAME(date)ORDER BY SUM(amount).DESC) AS 'month_rank'
              FROM orders
              GROUP BY MONTHNAME(date),user_id;
              ORDER BY MONTH(date)) t
              WHERE t.month_rank < 3
              ORDER BY month DESC,month_rank ASC



USE user;
--FIRST_VALUE/

SELECT * ,
FIRST_VALUE(marks) OVER(ORDER BY marks DESC)
FROM marks;

--LAST VALUE/

SELECT * ,
LAST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC
                     ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
FROM marks;

--NTH_VALUE
SELECT * ,
NTH_VALUE(name,4) OVER(PARTITION BY branch 
                     ORDER BY marks DESC
                     ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
FROM marks;

Window w AS ()

--1. Find the branch toppers
SELECT name,branch,marks FROM(SELECT *,
FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC) AS 'topper_name',
FIRST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC) AS 'topper_marks'
FROM marks) t
WHERE t.name =t.topper_name AND t.marks = t.topper_marks;

--2. FRAME Clause
--3. Find the last guy of each branch

SELECT name,branch,marks FROM(SELECT *,
LAST_VALUE(name) OVER (w)  AS 'topper_name',
LAST_VALUE(marks) OVER (w) AS 'topper_marks'
FROM marks) t
WHERE t.name =t.topper_name AND t.marks = t.topper_marks

Window (PARTITION BY branch 
            ORDER BY marks DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS w;

--4. Alternate way of writing Window functions
SELECT name,branch,marks FROM(SELECT *,
LAST_VALUE(name) OVER (w)  AS 'topper_name',
LAST_VALUE(marks) OVER (w) AS 'topper_marks'
FROM marks) t
WHERE t.name =t.topper_name AND t.marks = t.topper_marks

Window (PARTITION BY branch 
            ORDER BY marks DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS w;
--5. Find the 2nd last guy of each branch, 5th topper of each branch
SELECT * ,
NTH_VALUE(name,4) OVER(PARTITION BY branch 
                     ORDER BY marks DESC
                     ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
FROM marks;

--LEAD & LAG
SELECT *,
LAG(marks) OVER(PARTITION BY  branch ORDER BY student_id),
LEAD(marks) OVER(PARTITION BY branch ORDER BY student_id)
FROM marks;