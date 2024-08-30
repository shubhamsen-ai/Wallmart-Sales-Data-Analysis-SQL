CREATE DATABASE IF NOT EXISTS Wallmartsales;
use wallmartsales;
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR (30) NOT NULL,
    CUSTOMER_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR (100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6,4) NOT NULL,
    total DECIMAL(12,4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15),
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12,4) NOT NULL,
    rating FLOAT(2,1)
    );
    
    
    -- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- --------------------------------------------------------- Feature Engineering ------------------------------------------------------------------------------------------------
    
    -- time_of_day
    
    SELECT
		time,
		(CASE
        When `time` BETWEEN "00:00:00" AND "12:00:00" Then "Morning"
		When `time` BETWEEN "12:01:00" AND "16:00:00" Then "Afternoon"
		else "Evening"
        END
        ) AS time_of_date
From sales;
    
      set sql_safe_updates=0;
    ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
    UPDATE sales
    SET time_of_day = (
		CASE
        When `time` BETWEEN "00:00:00" AND "12:00:00" Then "Morning"
		When `time` BETWEEN "12:01:00" AND "16:00:00" Then "Afternoon"
		else "Evening"
        END
        );
    
    -- day_name
SELECT date,DAYNAME(date)
From sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
UPDATE sales
SET day_name =DAYNAME(date);

-- month_name
SELECT date,MONTHNAME(date)
from sales;

ALTER TABLE sales ADD COLUMN month_name varchar(10);
UPDATE sales
SET month_name = MONTHNAME(date);
-- -------------------------------------------------------------------------------------------------------------------------------------------
    
-- ----------------------------------------------------------------------------------------------------------------------------------------  
-- ---------------------  Generic  -----------------------------------------------------------------------------------
-- Q1.How many unique cities does the data have?
SELECT  distinct city from sales;

-- Q2.IN which city is each branch?
SELECT DISTINCT branch from sales;

SELECT DISTINCT city,
		branch
From sales;
	
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------- Product -------------------------------------------------------------------------------------

-- Q1.How many unique product lines does the data have?
 SELECT 
		count(DISTINCT product_line)
 FROM sales;
 
 -- Q2.What is the most common payment method?
SELECT 
	payment_method,count(payment_method) as cnt
FROM sales
GROUP BY payment_method
ORDER BY cnt DESC;
 
SELECT 
	product_line,count(product_line) as cnt
FROM sales
GROUP BY product_line
ORDER BY cnt DESC; 

-- Q3.What is the total revenue by month?
SELECT 
	month_name AS month,
    sum(total) as total_revenue
FROM sales
GROUP BY month
ORDER BY total_revenue desc;

-- Q4.What month had the largest COGS?    
SELECT
	month_name as month,
	SUM(cogs) as cogs
FROM sales
GROUP BY month_name
ORDER BY cogs desc;

-- Q5.What product line had the largest revenue?
SELECT
	product_line,
    SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- Q6.What is the city with the largest revenue?
SELECT
    branch,
    city,
    SUM(total) AS total_revenue
FROM sales 
Group BY city, branch
ORDER BY total_revenue DESC;

-- Q7.What product line had the largest VAT?
SELECT
    product_line,
    AVG(VAT) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Q8.Which branch sold more products than average product sold?
SELECT
    branch,
    SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- Q9.What is the most common product line by gender?
SELECT 
    gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender,product_line
ORDER BY total_cnt DESC;

-- Q10.What is the average rating of each product line?
SELECT
    ROUND(AVG(rating),2) AS avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------Sales-----------------------------------------------------------------------------------------------------
-- Q1.Number of sales made in each time of the day per weekday
Select
	time_of_day,
    COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Monday"
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Q2.Which of the customer types brings the most revenue?
SELECT
    Customer_type,
    SUM(total) AS total_rev
FROM sales
GROUP BY customer_type
ORDER BY total_rev DESC;

-- Q3.Which city has the largest tax percent/VAT(Value Added Tax)?
SELECT
    City,
    AVG(VAT) AS VAT
FROM sales
GROUP BY City
ORDER BY VAT DESC;

-- Q4.Which customer type pays the most in VAT?
SELECT
    Customer_type,
    AVG(VAT) AS VAT
FROM sales
GROUP BY Customer_type
ORDER BY VAT DESC;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------ Customers -----------------------------------------------------------------------------------------------------------
-- Q1.How many unique customer types does the data have?
SELECT
    DISTINCT customer_type
FROM sales;

-- Q2. How many unique payment methods does the data have?
SELECT
    DISTINCT payment_method
FROM Sales;

-- Q3.Which customer type buys the most?
SELECT
    Customer_type ,
    COUNT(*) AS Customer_COUNT
FROM sales
GROUP BY Customer_type;

-- Q4.What is the gender of most of the customer?
SELECT
    Gender,
    count(*) AS gender_count
FROM sales
GROUP BY Gender;

-- Q5.What is the gender distribution per branch?
SELECT
    Gender,
    count(*) AS gender_cnt
FROM sales
WHERE branch = "A"
GROUP BY gender
ORDER BY gender DESC;

-- Q6.Which time of the day do customers give most rating?
SELECT
	time_of_day,
    AVG(rating) AS avg_rating
FROM sales 
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Q7.Which time of the day do customers give most ratings per branch?
SELECT
    time_of_day,
    AVG(rating) AS avg_rating
FROM sales
Where branch = "C"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Q8.Which day of the week has the best avg rating?
SELECT
	day_name,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings per branch?
SELECT
    day_name,
    AVG(rating) AS avg_rating
From sales
WHERE branch = "C"
GROUP BY day_name
ORDER BY avg_rating DESC;

-- ----------------------------------------------------------END----------------------------------------------------------------------------------------------------------------------
    
    




    