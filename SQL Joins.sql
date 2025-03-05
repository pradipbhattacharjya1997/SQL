SELECT* FROM sql_cx_live.users1;
SELECT* FROM sql_cx_live.membership;

--create a cross join

SELECT * FROM  sql_cx_live.users1 t1
CROSS JOIN sql_cx_live.groups t2

--- INNER JOIN
SELECT * FROM sql_cx_live.membership t1
INNER JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id;

-- LEFT JOIN
SELECT * FROM sql_cx_live.membership t1
LEFT JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id;

-- RIGHT JOIN
SELECT * FROM sql_cx_live.membership t1
RIGHT JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id;

--FULL OUTER JOIN ----
SELECT * FROM sql_cx_live.membership t1
LEFT JOIN  sql_cx_live.users1 t2
ON t1.user_id = t2.user_id
UNION
SELECT * FROM sql_cx_live.membership t1
RIGHT JOIN  sql_cx_live.users1 t2
ON t1.user_id = t2.user_id;

---SET OPERATIONS
--UNION
SELECT * FROM sql_cx_live.person1
UNION 
SELECT * FROM sql_cx_live.person2;

----UNION ALL
SELECT * FROM sql_cx_live.person1
UNION ALL
SELECT * FROM sql_cx_live.person2;

---INTERSECT
SELECT * FROM sql_cx_live.person1
INTERSECT
SELECT * FROM sql_cx_live.person2;

---EXCEPT
SELECT * FROM sql_cx_live.person1
EXCEPT
SELECT * FROM sql_cx_live.person2;

--- SELF Joins
SELECT * FROM sql_cx_live.users1 t1
JOIN sql_cx_live.users1 t2
ON t1.emergency_contact = t2.user_id;

---JOining on more than one cols
SELECT * FROM sql_cx_live.students t1
JOIN sql_cx_live.class t2
ON t1.class_id = t2.class_id
AND t1.enrollment_year = t2.class_year;

---leftJoin on more than one cols
SELECT * FROM sql_cx_live.students t1
LEFT JOIN sql_cx_live.class t2
ON t1.class_id = t2.class_id
AND t1.enrollment_year = t2.class_year;

---rightJoin on more than one cols

SELECT * FROM sql_cx_live.students t1
RIGHT JOIN sql_cx_live.class t2
ON t1.class_id = t2.class_id
AND t1.enrollment_year = t2.class_year;

--Finde order name and corresponding category name
SELECT t1.order_id,t1.amount,t1.profit,t3.name 
FROM flipkart.order_details t1
JOIN flipkart.orders t2
ON t1.order_id = t2.order_id 
JOIN flipkart.users t3
ON t2.user_id = t3.user_id;

--Find order_id,name and city by joing users orders.

SELECT t1.order_id,t2.name,t2.city
FROM flipkart.orders t1
JOIN flipkart.users t2
ON t1.user_id = t2.user_id

--Find order_id,product category by joining order_details and category.

SELECT t1.order_id,t2.vertical
FROM flipkart.order_details t1
JOIN flipkart.category t2
ON t1.category_id = t2.category_id;


--Filtering Rows
--Find all the oders placed in pune.
SELECT * FROM flipkart.orders t1
JOIN flipkart.users t2
ON t1.user_id = t2.user_id
WHERE t2.city = 'Pune';

--Find all profiable orders

SELECT t1.order_id,SUM(t2.profit) FROM flipkart.orders t1
JOIN flipkart.order_details t2
ON t1.order_id = t2.order_id
GROUP BY t1.order_id
HAVING SUM(t2.profit) > 0

--Find the customer who has placed max number of orders.
SELECT name,COUNT(*) AS 'num_orders'
FROM flipkart.oRders t1
JOIN flipkart.users t2
ON t1.user_id = t2.user_id
GROUP BY t2.name
ORDER BY num_orders DESC LIMIT 1

---Which is the most profitable category 
SELECT t2.vertical,SUM(profit) FROM flipkart.order_details t1
JOIN flipkart.category t2
ON t1.category_id = t2.category_id
GROUP BY t2.vertical
ORDER BY SUM(profit) DESC LIMIT 1