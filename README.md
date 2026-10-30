# 🛒 Olist E-Commerce Store Analysis

### MySQL | Python | Brazilian E-Commerce Dataset | 9 Tables | 100k+ Orders

## 📌 Project Overview
This project analyzes the Brazilian Olist E-Commerce Store data to understand customer purchasing behavior, payment preferences, delivery performance, and customer satisfaction.

Dataset: 9 relational tables with ~100k orders. I used Python to import CSVs into MySQL and performed 5 Business KPI Analyses.

Database: olist_store_analysis

## 📂 Dataset Structure
- olist_customers_dataset (99,441 rows)
- olist_orders_dataset (99,441 rows)
- olist_order_items_dataset (112,650 rows)
- olist_order_payments_dataset (103,886 rows)
- olist_order_reviews_dataset (99,224 rows)
- olist_products_dataset (32,951 rows)
- olist_sellers_dataset (3,095 rows)
- olist_geolocation_dataset (1,000,163 rows)
- product_category_name_translation (71 rows)

## 🎯 Business KPIs & Findings

### KPI 1: Weekday vs Weekend Payment
Result: Credit Card = 57,954 Weekday + 18,551 Weekend
Insight: Credit Card dominates both periods.

### KPI 2: Five-Star + Credit Card
Result: 43,981 unique orders (DISTINCT validated)
Insight: High satisfaction loyal segment.

### KPI 3: Pet Shop Delivery Time
Result: 11.23 days avg for 1,688 orders

### KPI 4: Sao Paulo Analysis
Result: 15,402 orders | Avg Price $112.58 | Avg Payment $140.92

### KPI 5: Shipping vs Review Score (KEY FINDING)
5-Star = 10.63 days
4-Star = 12.25 days
3-Star = 14.20 days
2-Star = 16.61 days
1-Star = 21.25 days
Insight: Faster delivery = Happier customers. Strong inverse relationship.

## 🛠️ SQL Concepts
INNER JOIN, CTE (WITH), GROUP BY, COUNT DISTINCT, DATEDIFF, TIMESTAMPDIFF, CASE WHEN, LOWER(), AVG, SUM, ROUND

## 📁 Project Files
1. import_olist.py - Python import script
2. Olist_5_KPIs_Final.sql - 5 KPI queries
3. README.md - This file

## 🚀 How to Run
pip install pandas sqlalchemy pymysql
python import_olist.py

## 👤 Author
Aditya Bhoyar - Data Analyst | Pune, India

📍 Location: Pune, Maharashtra, India
🔗 GitHub: github.com/AdityaBhoyar-14
📧 Email: adityabhoyar160@mail.com
💼 LinkedIn: https://www.linkedin.com/in/aditya-bhoyar14

Feel free to contact me for collaborations or opportunities!

## ⭐ Business Recommendation
Reduce shipping time to < 12 days to increase 5-star reviews.
