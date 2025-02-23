CREATE DATABASE IF  NOT EXISTS campusx;
DROP DATABASE IF EXISTS campusx;

-- DDL COMMENT for table

CREATE TABLE users(
    user_id INT,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);
--insert data 
INSERT INTO users
(user_id,name,email,password)
VALUES
('1','Pradip','pradip199@gmail.com','nitish'),
('2','subha','subha123@gmail.com','1234')


TRUNCATE TABLE users
DROP TABLE users;
SELECT * FROM users;

---create a new table NOT NULL

CREATE TABLE users2(
    user_id INT not NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    password VARCHAR(255)
);
INSERT INTO users2
(user_id,name,email,password)
VALUES
('1','subha','subha12@gmail.com','122');


SELECT* FROM users2;

---create a new table UNIQUE(combo)

CREATE TABLE users3(
    user_id INT not NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,

    CONSTRAINT users_email_unique UNIQUE(name,email,password)
);

---create a new table PRIMARY KEY

CREATE TABLE users4(
    user_id INT not NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    password VARCHAR(255),

    CONSTRAINT users_pk PRIMARY KEY (user_id)
);

SELECT * FROM users3;

---create a new table Auto increment
CREATE TABLE users5(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NULL UNIQUE,
    password VARCHAR(255)
);

---create a new table check

CREATE TABLE students(
    student_id INT PRIMARY KEY  AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    age INT,

   CONSTRAINT students_age_check CHECK (age > 6 AND age < 25)
);

---create a new table Default

CREATE TABLE ticket(
    ticket_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    travel_date DATE 
);


--- create a FOREIGN KEY TABLE 

CREATE TABLE customers(
    cid INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE orders(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    cid INT NOT NULL,
    order_date DATETIME NOT NULL,
   
    FOREIGN KEY (cid) REFERENCES customers(cid)
);

SELECT * FROM orders;

-- create a alter table

ALTER TABLE customers 
ADD password VARCHAR(255) NOT NULL;

ALTER TABLE customers
DROP COLUM password;

SELECT * FROM customers;