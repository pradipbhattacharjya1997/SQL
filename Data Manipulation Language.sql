-- careate database
CREATE DATABASE user;

-- create table
CREATE TABLE user(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);
-- insert data
INSERT INTO user
(user_id,name,email,password)
VALUES
(NULL,'rishabh','rishabh@gmail.com','12345'),
(NULL,'rohan','rohan@gmail.com','12345'),
(NULL,'rahul','rahul@gmail.com', '12345')

SELECT * FROM user;

--import data in mySql workbench
SELECT * FROM campusx.smartphones;

-- filter columns
SELECT model,battery_capacity,os FROM campusx.smartphones;

--alias  renaming columns
SELECT model,battery_capacity AS MH,os AS 'Operating System' FROM campusx.smartphones;

--create expression using columns
SELECT model,
SQRT(resolution_width * resolution_width + resolution_height*resolution_height) /screen_size AS PPI
FROM campusx.smartphones;

-- ALL phone rating
SELECT model,rating/10 FROM campusx.smartphones;

-- constants
SELECT model, 'smartphone' AS 'type' FROM campusx.smartphones;

--Distinct(unique) values from a col
SELECT DISTINCT (brand_name) AS 'All Brands' 
FROM campusx.smartphones;

SELECT DISTINCT(processor_brand) AS 'all_Processors'
FROM campusx.smartphones;

SELECT DISTINCT(OS) AS  'all_operating system'
FROM campusx.smartphones;

--Distinct unique combonishan
SELECT DISTINCT brand_name,processor_brand
FROM campusx.smartphones;

--Filter rows WHERE clause---
--Find all samsung phones
SELECT * FROM campusx.smartphones
WHERE brand_name = 'samsung';

--find all phones with price > 50000
SELECT *  FROM smartphones
WHERE price > 50000;

--BETWEEN ---
--find all phones in the price range of 10000 and 20000

SELECT * FROM smartphones
WHERE price > 10000 AND price< 20000;

SELECT * FROM smartphones
WHERE price BETWEEN 10000  AND 20000;

--FINDE phones with rating > 80 and  price < 25000

SELECT * FROM smartphones
WHERE price < 25000 AND rating > 80;

-- Find all samsung phones with ram > 8GB
SELECT * FROM smartphones
WHERE brand_name = 'samsung' AND ram_capacity > 8;

-- Find all samsung phones with snapdragon processor
SELECT * FROM smartphones
WHERE brand_name ='samsung' AND processor_brand = 'snapdragon';


-- Query Execution Order
-- find brands who sell phones with price > 50000.

SELECT DISTINCT (brand_name) FROM smartphones
WHERE price > 50000;

-- IN  and NOT IN
SELECT * FROM smartphones
WHERE processor_brand IN('snapdragon','exynos','bionic');
--NOT IN
SELECT * FROM smartphones
WHERE processor_brand IN('snapdragon','exynos','bionic');

--------------------------------------------------------
--Update
UPDATE campusx.smartphones
SET processor_brand = 'dimensity'
WHERE processor_brand = 'mediatek';

SELECT * FROM smartphones;

UPDATE user
SET email ='rishabh123@gmail.com',password = '12345678'
WHERE name = 'rishabh';
SELECT * FROM user;

--Delete
--Delete all phones price > 200000
sELECT * FROM smartphones
WHERE price > 200000;

DELETE FROM campusx.smartphones
WHERE price > 200000;

----------------------------------------------------------
--Types of functions 
--Aggreate Function
-- MAX/MIN
--FINDE the minimum and maximum price
SELECT MAX(price) FROM campusx.smartphones;
SELECT MIN(price) FROM campusx.smartphones;

SELECT MAX(ram_capacity) FROM smartphones;
SELECT MIN(ram_capacity) FROM smartphones;

--find the price of the costliest samsung phone.

SELECT MAX(price) FROM campusx.smartphones
WHERE brand_name = 'samsung'

--AVG
-- FIND avg rating of apple phones.
SELECT AVG(rating) FROM smartphones
WHERE brand_name ='apple';

--SUM
SELECT SUM(price) FROM smartphones;
--COUNT
--find the number of oneplus phones
SELECT COUNT(*) FROM smartphones
WHERE brand_name = 'oneplus';

--Count(DIstinct)
-- find the number of brands available
SELECT COUNT(DISTINCT(brand_name)) FROM smartphones;
SELECT COUNT(DISTINCT(processor_brand)) FROM smartphones;

--STD
--find std of screen sizes
SELECT STD(screen_size) FROM smartphones;
--------------------------------
--Scalar Functions
--ABS
-- find diff from avg rating of all samsung phone ratings.
SELECT ABS(price - 100000 )AS 'Temp' FROM smartphones;

--ROUND
--round the ppi to 1 decimal place
SELECT model,
ROUND(SQRT(resolution_width * resolution_width + resolution_height*resolution_height) /screen_size ,2)AS PPI
FROM campusx.smartphones;

--CEIL / FLOOR
SELECT CEIL(screen_size) FROM smartphones;
SELECT FLOOR(screen_size) FROM smartphones;