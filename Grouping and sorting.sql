---Sorting Data
--1. find top 5 samsung phones withe biggest screen size.
SELECT model,screen_size FROM smartphones
WHERE brand_name ='samsung'
ORDER BY screen_size DESC
LIMIT 5;

--2. sort all the phone with in decending order of number of total cameras.
SELECT model, num_front_cameras + num_rear_cameras AS 'total_camers' 
FROM smartphones
ORDER BY total_camers DESC;

--3. Sort data on the basis of ppi in decreasing order.

SELECT model,
(SQRT(resolution_width*resolution_width + resolution_height*resolution_height) /screen_size) AS PPI
FROM smartphones
ORDER BY PPI DESC;

--4. find the phone with 2nd largest battery
SELECT model,battery_capacity AS largest_battery
FROM smartphones
ORDER BY largest_battery DESC
LIMIT 1,1;

--5. Find the name and rating of the worst rated apple phone.

SELECT model,rating
FROM smartphones
WHERE brand_name = 'apple' 
ORDER BY rating ASC
LIMIT 0,1;

--6. Sort phones alphabetically and then on the basic of rating in desc order.
SELECT * FROM smartphones
ORDER BY brand_name ASC, rating DESC;

--7.Sort phones alphabetically and then on the basic of price in asc order.
SELECT * FROM smartphones
ORDER BY brand_name ASC, rating ASC;

-----------------------------------------------------------------
--Grouping Data

--1.Group smartphones by brand and get the count, average price,max rating,avg sceen size and avgbattery capacity

SELECT brand_name,COUNT(*) AS 'num_phones',
ROUND(AVG(price)) AS 'avg price',
MAX(rating) AS 'max_rating',
AVG(screen_size) AS 'AVG_screen_size',
AVG(battery_capacity) AS 'AVG_battery_capacity'
FROM smartphones
GROUP BY brand_name 
ORDER BY num_phones DESC;

--2.Group smartphones by whether they have an NFC and get the avgerage price and rating.
SELECT has_nfc, AVG(price) AS 'avg_price', AVG(rating) AS 'avg_rating'
FROM smartphones
GROUP BY has_nfc;

--3.Group smartphones by the extended memory available and get the average price.
SELECT extended_memory_available, AVG(price)
FROM smartphones
GROUP BY extended_memory_available;

--4.Group smartphones by the brand and processor brand and get the count of models and the average primary camera resolution

SELECT brand_name,processor_brand,
COUNT(*) AS 'num_phones',
ROUND(AVG(primary_camera_rear)) AS 'AVG camera resolution'
FROM smartphones
GROUP BY brand_name,processor_brand;

--5.find top 5 most costly phone brands,
SELECT brand_name ,ROUND(AVG(price)) AS 'avg_price'
FROM smartphones
GROUP BY brand_name 
ORDER BY avg_price DESC
LIMIT 5;

--6.which brand makes the smallest screen smartphones

SELECT brand_name, ROUND(AVG(screen_size)) AS 'smallest_screen'
FROM smartphones
GROUP BY brand_name
ORDER BY smallest_screen ASC
LIMIT 1;

--7.Avg price of 5g phones vs avg price of non 5g phones
SELECT has_5g ,
AVG(price) AS 'avg price'
FROM smartphones
GROUP BY has_5g;

--8. Group smartphones by the brand, and find the brand with the highest of models that have both NFC AND IE BLASCER

SELECT brand_name,COUNT(*) AS 'count'
FROM smartphones
WHERE has_nfc ='True' AND has_ir_blaster = 'TRUE'
GROUP BY brand_name
ORDER BY count DESC LIMIT 1;

--9. Find all samsung 5g enabled smartphones and find out the avg price for NFC and Non-NFC phones.
SELECT has_nfc,AVG(price) AS  'avg_price'
FROM smartphones
WHERE brand_name = 'samsung'
GROUP BY has_nfc;

--10. find the phone name, price of the costliest phone
SELECT model,price
FROM smartphones
ORDER BY price DESC
LIMIT 1;

-------------------------------------------------------------------
--Having clause
SELECT brand_name,
COUNT(*) AS 'count',
AVG(price) AS 'avg_price'
FROM smartphones
GROUP BY brand_name
HAVING count > 20
ORDER BY avg_price DESC;

--1. find the avg rating of smartphone brands which have more than 20 phones

SELECT brand_name,
COUNT(*) AS 'count',
AVG(rating) AS 'avg_rating'
FROM smartphones
GROUP BY brand_name
HAVING count >20
ORDER BY avg_rating DESC;

--2. Find the top 3 brands with the highest avg ram that have a refresh rate of at least 90 Hz and fast charging available and dont consider brands which have less than 10 phones.

SELECT brand_name, AVG(ram_capacity)
FROM smartphones
WHERE refresh_rate > 90 AND fast_charging_available = 1
GROUP BY brand_name
HAVING COUNT(*) > 10
ORDER BY 'avg_ram' DESC
LIMIT 3


--3. find the avg price of all the phone brands with avg rating > 70 and num phones more than 10 among all 5g enabled phones
SELECT brand_name,AVG(price) AS 'avg_price'
FROM smartphones
WHERE has_5g = 'True'
GROUP BY brand_name
HAVING AVG(rating) > 70 AND COUNT(*) > 10;
-----------------------------------------------------------------------------------------
--Practice
SELECT * FROM IPL;
-- find the top 5 batsman in IPL
SELECT batter,SUM(batsman_run) AS 'runs'
FROM ipl
GROUP BY batter
ORDER BY  runs DESC
LIMIT 5;


-- find the 2nd highest 6 hitter in IPL

SELECT batter,COUNT(*) AS 'num_sixes'
FROM ipl
WHERE batsman_run = 6
GROUP BY batter
ORDER BY num_sixes DESC
LIMIT 1,1

-- Find Virat Kohli's performance against all IPL teams
SELECT * FROM ipl
WHERE batter = ' V kohli'
GROUP BY 

-- Find top 10 batsman with centuries in IPL
SELECT batter,ID,SUM(batsman_run) AS 'score' 
FROM ipl
GROUP BY batter,ID
HAVING score >= 100
ORDER BY batter DESC
-- find the top 5 batsman with highest strike rate who have played a min of 1000 balls
SELECT batter,SUM(batsman_run),COUNT(batsman_run),
ROUND((SUM(batsman_run)/COUNT(batsman_run))*100,2) AS 'sr'
FROM ipl
GROUP BY batter
HAVING COUNT(batsman_run) > 1000
ORDER BY sr DESC LIMIT 5;