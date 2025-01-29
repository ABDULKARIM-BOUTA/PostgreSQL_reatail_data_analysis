-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
transaction_id INT PRIMARY KEY,	
sale_date DATE,	 
sale_time TIME,	
customer_id	INT,
gender	VARCHAR(15),
age	INT,
category VARCHAR(15),	
quantity INT,
price_per_unit FLOAT,	
cogs	FLOAT,
total_sale FLOAT);

select * from retail_sales rs ;

select count(*) from retail_sales rs;

-- removing rows with null values
SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    or
    customer_id is null 
    or
    gender IS NULL
    or
    age is null 
    or
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS null
    or 
    price_per_unit is null;

delete FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    or
    customer_id is null 
    or
    gender IS NULL
    or
    age is null 
    or
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS null
    or 
    price_per_unit is null;

select * from retail_sales rs;

select count(*) from retail_sales rs;

--data analysis

-- sum of total sales:
select sum(total_sale) from retail_sales rs;

--how many customrs
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

--retrieve all columns for sales made on '2022-11-05
select * from retail_sales rs where sale_date = '2022-11-05';

-- retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022
select * from retail_sales rs where category = 'Clothing' and quantity > 2 and to_char(sale_date, 'YYYY-MM') = '2022-11' ;

-- calculate the total sales (total_sale) for each category.
select category ,sum(total_sale) as total_sales from retail_sales rs group by category;

-- find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age)) as AVG_Age from retail_sales rs where category = 'Beauty'

-- find all transactions where the total_sale is greater than 1000.
select * from retail_sales rs where total_sale > 1000

-- find the total number of transactions made by each gender in each category.
select gender , category, count(*) as total_transactions from retail_sales rs  group by gender, category 

-- calculate the average sale for each month. Find out best selling month in each year
select year, month, avg_sales from
(select extract(year from sale_date) as Year,
extract(month from sale_date) as month,
round(avg(total_sale)) as avg_sales,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from retail_sales rs
group by 1,2 order by rank) where rank = 1;

-- find the top 5 customers based on the highest total sales 
select customer_id ,sum(total_sale) from retail_sales rs group by customer_id order by sum(total_sale) desc limit 5;

-- find the number of unique customers who purchased items from each category.
select category ,count(distinct(customer_id)) from retail_sales rs group by category

-- create each shift and number of orders 
select case 
	when extract (hour from sale_time) <= 12 then 'morning'
	when extract (hour from sale_time) between 12 and 17 then 'afternoon'
	else 'evening'
end as shift, count(*) 
from retail_sales rs 
group by shift