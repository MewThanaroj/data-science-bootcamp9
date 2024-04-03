-- create table 1 customers
CREATE TABLE customers (
  customer_id INT,
  name TEXT,
  surname TEXT,
  email TEXT
);


-- insert data into customers
INSERT INTO customers VALUES
(1, 'David', 'Jones', 'davidjones@gmail.com'),
(2, 'Jenny', 'Brown', 'jennybrown@gmail.com'),
(3, 'Eric', 'Williams', 'ericwilliams@gmail.com'),
(4, 'Jane', 'Hill', 'janehill@gmail.com'),
(5, 'Taylor', 'Walker', 'taylorwalker@gmail.com'),
(6, 'Paul', 'Turner', 'paulturner@gmail.com'),
(7, 'Chris', 'Edwards', 'chrisedwards@gmail.com'),
(8, 'Kim', 'Brooks', 'kimbrooks@gmail.com'),
(9, 'Mike', 'Hughes', 'mikehughes@gmail.com'),
(10, 'Lisa', 'Jackson', 'lisajackson@gmail.com');


-- create table 2 orders
CREATE TABLE orders (
  order_id INT,
  order_date DATE,
  customer_id INT,
  menu_id INT,
  quantity INT
);


-- insert data into orders
INSERT INTO orders VALUES
(1, '2024-01-26', 3, 12, 1),
(2, '2024-01-26', 6, 14, 1),
(3, '2024-01-27', 8, 11, 2),
(4, '2024-01-27', 4, 13, 3),
(5, '2024-01-27', 9, 15, 1),
(6, '2024-01-28', 5, 7, 1),
(7, '2024-01-28', 10, 5, 2),
(8, '2024-01-28', 1, 10, 1),
(9, '2024-01-28', 7, 9, 2),
(10,'2024-01-29', 9, 8, 1),
(11,'2024-01-29', 6, 4, 2),
(12,'2024-01-29', 3, 3, 1),
(13,'2024-01-29', 4, 1, 2),
(14,'2024-01-30', 2, 6, 3),
(15,'2024-01-30', 1, 2, 1);


-- create table 3 menus
CREATE TABLE menus (
  menu_id INT,
  menu_name TEXT,
  menu_size TEXT,
  menu_price INT,
  category TEXT
);


-- insert data into menus
INSERT INTO menus values
(1, 'Pepperoni', 'S', 299, 'Meat'),
(2, 'Pepperoni', 'M', 399, 'Meat'),
(3, 'Pepperoni', 'L', 499, 'Meat'),
(4, 'Hawaiian', 'S', 299, 'Meat'),
(5, 'Hawaiian', 'M', 399, 'Meat'),
(6, 'Hawaiian', 'L', 499, 'Meat'),
(7, 'Seafood', 'S', 399, 'Seafood'),
(8, 'Seafood', 'M', 499, 'Seafood'),
(9, 'Seafood', 'L', 599, 'Seafood'),
(10, 'Meat & Ham', 'S', 299, 'Meat'),
(11, 'Meat & Ham', 'M', 399, 'Meat'),
(12, 'Meat & Ham', 'L', 499, 'Meat'),
(13, 'Mushroom', 'S', 299, 'vegetarian'),
(14, 'Mushroom', 'M', 399, 'vegetarian'),
(15, 'Mushroom', 'L', 499,'vegetarian');


.mode box
SELECT * FROM customers;
SELECT * FROM menus;
SELECT * FROM orders;


-- three SQL queries
-- 1. Top 3 most ordered menu
SELECT 
  m.menu_id as menu_id,
  m.menu_name AS pizza_name,
  SUM(o.quantity) AS pizza_quantity
FROM customers AS c
JOIN orders AS o
on c.customer_id = o.customer_id
JOIN menus AS m
ON o.menu_id = m.menu_id
GROUP BY m.menu_name
ORDER BY SUM(o.quantity) DESC
LIMIT 3;


-- 2. Top 4 customers most paid
SELECT 
  c.customer_id AS customer_id,
  c.name || ' ' || c.surname AS full_name,
  SUM(menu_price) as total_price
FROM customers AS c
JOIN orders AS o
on c.customer_id = o.customer_id
JOIN menus AS m
ON o.menu_id = m.menu_id
GROUP BY full_Name
ORDER BY SUM(menu_price) desc
LIMIT 4;

-- 3. customer who order more than 2
SELECT 
  c.name AS name, 
  o.quantity as quantity
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
JOIN menus AS m
ON o.menu_id = o.menu_id
WHERE o.quantity > 2
GROUP BY c.name;


-- 4. Find customer who buy on "2024-01-28" ,what did they buy, menu size, menu prize, and how many quantity.
WITH sub1 AS (
  SELECT *
  FROM orders
  WHERE STRFTIME("%Y-%m-%d", order_date) = "2024-01-28"
), sub2 AS (
  SELECT *
  FROM menus
)

SELECT 
  c.customer_id,
  c.name || ' ' || c.surname  AS fullname,
  STRFTIME("%Y", sub1.order_date) AS year,
  STRFTIME("%m", sub1.order_date) AS month,
  STRFTIME("%d", sub1.order_date) AS day,
  STRFTIME("%Y-%m-%d", sub1.order_date) AS date,
  sub2.menu_name,
  sub2.menu_size,
  sub2.menu_price,
  sub1.quantity
FROM customers AS c
JOIN sub1 
ON c.customer_id = sub1.customer_id
JOIN sub2
ON sub1.menu_id = sub2.menu_id
ORDER BY sub1.quantity DESC
LIMIT 4;
