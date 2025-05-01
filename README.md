# 🍕 Pizza Sales Analysis (SQL Project)

This repository contains SQL queries and insights derived from analyzing pizza sales data. 
The dataset simulates an online pizza restaurant's order records and includes details about pizzas, orders, categories, prices, and sales performance.

---

## 📂 Database Structure

Database: `pizza_db`

### Tables:
- `orders`: Stores order ID, date, and time.
- `order_details`: Contains details about each pizza ordered per order.
- `pizzas`: Stores pizza IDs, size, price, and pizza type ID.
- `pizza_details`: Contains pizza names, category, and description.

---

## ✅ Objectives Covered

### Basic Analysis

1. **Total Number of Orders**
2. **Retrieve the total number of orders placed.**
3. **Calculate the total revenue generated from pizza sales.**
4. **Identify the highest-priced pizza.**
5. **Identify the most common pizza size ordered.**
6. **List the top 5 most ordered pizza types along with their quantities.**

### Intermediate:
1. **Join the necessary tables to find the total quantity of each pizza category ordered.**
2. **Determine the distribution of orders by hour of the day.**
3. **Join relevant tables to find the category-wise distribution of pizzas.**
4. **Group the orders by date and calculate the average number of pizzas ordered per day.**
5. **Determine the top 3 most ordered pizza types based on revenue.**
6. **Calculate the percentage contribution of each pizza type to total revenue.**

#### Refer to the .sql file for all the questions and solutions

## 📚 How to Use

1. Open mysql and run this:
2. ```sql
   create database if not exists pizza_db;
   use pizza_db;
   show tables;
3. Run the python script sql_loading.ipynb in your local machine to load the database and tables given in /data directory.
5. Run the queries in your SQL environment (MySQL, PostGRE etc.).
---

## 💡 Tools Used

- Python
- SQL (MySQL)
- Database: pizza_db

## Clone this repository

    ```bash
    git clone https://github.com/your-username/pizza-sales-analysis.git
    cd pizza-sales-analysis
    ```
