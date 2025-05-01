create database if not exists pizza_db;
use pizza_db;

show tables;
SELECT 
    *
FROM
    pizzas;
SELECT 
    *
FROM
    pizza_details;
SELECT 
    *
FROM
    orders;
SELECT 
    *
FROM
    order_details;

-- Basic: 
-- 1. Retrieve the total number of orders placed.
SELECT 
    COUNT(*) AS num_orders
FROM
    orders;

-- 2. Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(p.price * od.quantity), 2) AS total_revenue
FROM
    pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id;

-- 3. Identify the highest-priced pizza.

SELECT 
    pd.name, p.price
FROM
    pizzas p
        JOIN
    pizza_details pd ON p.pizza_type_id = pd.pizza_type_id
WHERE
    p.price = (SELECT 
            MAX(price)
        FROM
            pizzas);

-- 4. Identify the avg price of pizza for each size
SELECT 
    size, ROUND(AVG(price), 2) AS avg_price
FROM
    pizzas
GROUP BY size
ORDER BY avg_price DESC;
     
-- 5. Identify the most common pizza size ordered.
SELECT 
    size, COUNT(*) AS num_pizzas
FROM
    pizzas
GROUP BY size;
    
-- 5. List the top 5 most ordered pizzas along with their quantities.

SELECT 
    pd.name, SUM(od.quantity) AS total_pizzas
FROM
    pizza_details pd
        JOIN
    pizzas p ON pd.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pd.name
ORDER BY total_pizzas DESC
LIMIT 5;

-- Intermediate:
-- 1. Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    category, SUM(od.quantity) AS tot_quantity
FROM
    pizza_details pd
        JOIN
    pizzas p ON p.pizza_type_id = pd.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY category;

-- 2. Determine the distribution of orders by hour of the day.
SELECT 
    CASE
        WHEN HOUR(o.time) < 12 THEN CONCAT(HOUR(o.time), '', 'AM')
        WHEN HOUR(o.time) >= 12 THEN CONCAT(HOUR(o.time), '', 'PM')
        ELSE 0
    END AS hours,
    COUNT(o.order_id) AS num_orders
FROM
    orders o
GROUP BY hours
ORDER BY hours ASC;

-- 3. Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(*) AS num_pizzas
FROM
    pizza_details
GROUP BY category
ORDER BY num_pizzas DESC;

-- 4. Group the orders by date and calculate the total pizzas ordered each date and find which day is the most happening.
SELECT 
    o.date, SUM(quantity) AS total_pizzas
FROM
    orders o
        JOIN
    order_details od ON o.order_id = od.order_id
GROUP BY o.date;

SELECT 
    DATE_FORMAT(o.date, '%W') AS day_name,
    SUM(quantity) AS total_pizzas
FROM
    orders o
        JOIN
    order_details od ON o.order_id = od.order_id
GROUP BY day_name
ORDER BY total_pizzas DESC;

-- 5. Determine the top 3 most ordered pizza types based on revenue.
select pd.category,round(sum(od.quantity * p.price),2) as total_revenue 
from pizza_details pd
join pizzas p on pd.pizza_type_id = p.pizza_type_id
join order_details od on p.pizza_id = od.pizza_id
group by pd.category
order by total_revenue desc;

-- 6. Show what all pizzas come up in which category in desc order of prices and select the top 3 highest prices pizzas from each category

with cte as ( 
select pd.category
	  ,pd.name
      ,p.price
      ,dense_rank () over(partition by pd.category order by p.price desc) as rnk
	from 
    pizza_details pd
			join 
	pizzas p on pd.pizza_type_id = p.pizza_type_id)

SELECT 
    category, name, price
FROM
    cte
WHERE
    rnk < 4;

-- Advanced:
-- 1. Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pd.category, 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue,
    ROUND(
        (SUM(od.quantity * p.price) / 
         (SELECT SUM(od2.quantity * p2.price)
          FROM pizzas p2 
          JOIN order_details od2 ON p2.pizza_id = od2.pizza_id)
        ) * 100, 2
    ) AS perc_revenue
FROM pizza_details pd
JOIN pizzas p ON pd.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pd.category
ORDER BY total_revenue DESC;