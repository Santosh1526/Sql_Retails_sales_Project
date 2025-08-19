#SQL sales retail Analysis
Create Database SQL_Project
use SQL_Project;
Drop table Retails_sale;
#Create Table 
CREATE TABLE Retails_sales(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(50),
    age INT,
    category VARCHAR(50),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

Select * 
from Retails_sales;


Select
Count(*)
from Retails_sales;


Select * from Retails_sales
Where   transactions_id is null


SELECT * 
FROM Retails_sales
WHERE transactions_id IS NULL 
   OR sale_date IS NULL 
   OR sale_time IS NULL 
   OR customer_id IS NULL 
   OR gender IS NULL 
   OR age IS NULL 
   OR category IS NULL 
   OR quantity IS NULL 
   OR price_per_unit IS NULL 
   OR cogs IS NULL 
   OR total_sale IS NULL;


#Data Exploration
-- How many sales we have?

SELECT 
    COUNT(*) AS Total_sale
FROM
    Retails_sales;

-- how many unique customer we have?

SELECT 
    COUNT(Distinct customer_id) AS Total_customers
FROM
    Retails_sales;
   
-- how many categories we have ?

SELECT 
   Distinct category AS Total_categories
FROM
    Retails_sales;

-- Data analytic and business key problems and answers


-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000 ?
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category ?
-- Q.7 Write a SQL query to find  to calculate the average sale for each month. Find out best selling month in each year 
-- Q.8 write a SQL query to find the top 5 customers based on the highest total sales
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q. 10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17 ?





-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05 ? 
Select *
From Retails_sales
Where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than the month of Nov-2022

SELECT *
FROM retails_sales
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
  
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    Category, SUM(Total_Sale) AS net_scale
FROM
    Retails_sales
GROUP BY Category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

Select Avg(Age)
From Retails_sales
Where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000 ?

Select Count(*) as Total_sale 
From Retails_sales
Where Total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category ?

SELECT 
    Category, Gender, COUNT(*) AS Total_trans
FROM
    retails_sales
GROUP BY Category , Gender
Order by Category 


-- Q.7 Write a SQL query to find  to calculate the average sale for each month. Find out best selling month in each year ?

Select * From 
(Select 
Year(Sale_date),
Month(Sale_date),
Round(AVG(Total_sale),2) as Avg_sale,
Rank() Over(Partition by Year(Sale_date) order by AVG(Total_sale) Desc) as Ranks
From Retails_sales
Group by 1,2) as t1
Where Ranks = 1;
-- Order by 1, 3 desc

-- Q.8 write a SQL query to find the top 5 customers based on the highest total sales ?

SELECT 
    customer_id, SUM(Total_sale) AS Total_sales
FROM
    Retails_sales
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    Category, COUNT(DISTINCT customer_id)
FROM
    retails_sales
GROUP BY Category

-- Q. 10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening > 17 ?


With hourly_sale
as (
SELECT 
    *,
    CASE
        WHEN EXTRACT(HOUR FROM Sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM Sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift
FROM
    Retails_sales)

select shift,
Count(*) as total_orders
 From hourly_sale
Group by Shift 


-- end of Project]

