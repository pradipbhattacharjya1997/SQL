
---create a subqueries

SELECT * FROM sub.movies
WHERE score =(SELECT MAX(score) FROM sub.movies) 

--Independent SubQuery - Scalar Subquery

-- Find the movie with highest profit(vs order by)

SELECT * FROM sub.movies
WHERE (gross - budget) = (SELECT MAX(gross - budget)FROM sub.movies);

SELECT * FROM sub.movies
ORDER BY (gross - budget) DESC LIMIT 1;

--- Find how many moveies have a rating > the avg of all the movie ratings(Find the count of above averege movies)

SELECT COUNT(*) FROM sub. movies
WHERE score > (SELECT AVG(score) FROM sub.movies);

-- Finde the highest rated movie of 2000
SELECT * FROM sub.movies
WHERE year = 2000 and score =(SELECT MAX(score) FROM sub.movies
WHERE year = 2000);

--Find the highest rated movie among all movies whose number of votes are > the dataset avg votes
SELECT * FROM sub.movies
WHERE score = (SELECT MAX(score) FROM sub.movies
                 WHERE votes > (SELECT AVG(votes) 
                                FROM sub.movies))

---Independent Subquery - Row Subquery(One Col Multi Rows)
USE sub;
--Find all users who never ordered
SELECT * FROM users
WHERE user_id NOT IN (SELECT DISTINCT(user_id) FROM orders);

--Find all the movies made by top 3 directors(in terms of total gross income)

 SELECT * FROM movies
 WHERE director IN (SELECT director 
                FROM movies 
                GROUP BY director 
                ORDER BY SUM(gross) DESC 
                LIMIT 3);


--Find all movies of all those actors whose filmography's avg rating > 8.5(take25000 votes as cutoff)

SELECT * FROM movies
WHERE star IN ( SELECT star FROM movies
WHERE votes > 25000
GROUP BY  star
HAVING AVG(score) > 8.5)

---Independent Subquery - Table Subquery(Multi col multi Row)

--Find the most profitable movie of each year

SELECT * FROM movies
WHERE (year,gross - budget) IN (SELECT year,MAX(gross - budget)
                                 FROM movies
                                 GROUP BY year);

--Find the highest rated movie of each genre votes cutoff of 25000


SELECT * FROM movies
WHERE(genre,score) IN (SELECT genre,MAX(score)
                       FROM movies
                       WHERE votes > 25000
                       GROUP BY genre)
AND votes > 25000;


--Find the highest grossing movies of top 5 actor/director combo in terms of total gross income
USE sub;
WITH top_duos AS (
SELECT star, director,SUM(gross),MAX(gross)
FROM movies
GROUP BY star,director
ORDER by SUM(gross) DESC LIMIT 5;
)

SELECT * FROM movies
WHERE (star,director,gross) IN (SELECT * FROM top_duos)

--Correlated Subquery
--Find all the movies that have a rating higher than the average rating of moviesin the same genre.[Animation]

SELECT * FROM movies m1
WHERE score > (SELECT AVG(score) FROM movies m2 WHERE m2.genre = m1.genre)



--Find the favorite food of each customer.
USE sub;
WITH fav_food AS (
SELECT name,f_name,COUNT(*) AS 'frequency' FROM users t1
JOIN orders t2 ON t1.user_id = t2.user_id
JOIN order_details t3 ON t2.order_id = t3.order_id
JOIN food t4 ON t3.f_id = t4.f_id
GROUP BY t2.user_id,t3.f_id
)

SELECT * FROM fav_food

--Usage with SELECT
USE sub;
--1. Get the percentage of voters for each movie compared to the total number of votes.
SELECT name, (votes/(SELECT SUM(votes) FROM movies))*0.1 FROM movies
--2.Display all movie names,genre,score and avg(score) of genre

SELECT name,genre,score,
(SELECT AVG(score) FROM movies m2 WHERE m2.genre=m1.genre) 
FROM movies.m1

--Usage with FROM
--1.Display average rating of all the restaurants

SELECT r_name,avg_rating
FROM (SELECT r_id,AVG(restaurant_rating) AS 'avg_rating'
      FROM orders 
      GROUP BY r_id) t1 JOIN restaurants t2
      ON t1.r_id = t2.r_id
--Usage with HAVING
--1.Find genres having avg score >avg score of all the movies
USE sub;
SELECT genre,AVG(score)
FROM movies
GROUP BY genre
HAVING AVG(score) > (SELECT AVG(score)FROM movies)

--subquery in INSERT

--Populate a already created loyal_customers table with records of only those customers who have ordered food more than 3 times.
