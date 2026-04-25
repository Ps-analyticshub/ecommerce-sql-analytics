# Queries

-- Q1. Who are the top 10 customers contributing the most revenue?
select c.customer_id, c.customer_name, sum(o.quantity * p.price)as total_revenue from Customers c join Orders o on c.customer_id = o.customer_id
join Products p on o.product_id = p.product_id group by c.customer_id, c.customer_name order by total_revenue desc limit 10;

-- Q2. How has revenue changed over time?
select date_format(order_date, '%Y-%m')as month, SUM(o.quantity * p.price)as monthly_revenue from Orders o join Products p on o.product_id = p.product_id
group by month order by month;

-- Q3. Which products sell the most units?
select p.product_name, sum(o.quantity)as units_sold from Orders o join Products p on o.product_id = p.product_id group by p.product_name
order by units_sold desc limit 10;

-- Q4. Which products generate the most revenue?
select p.product_name, sum(o.quantity * p.price)as revenue from Orders o join Products p on o.product_id = p.product_id group by p.product_name
order by revenue desc limit 10;

-- Q5. Which cities generate the most revenue?
select c.city, sum(o.quantity * p.price)as city_revenue from Customers c join Orders o on c.customer_id = o.customer_id
join Products p on o.product_id = p.product_id group by c.city order by city_revenue desc;

-- Q6. How many orders has each customer placed?
select c.customer_id, c.customer_name, count(o.order_id)as total_orders from Customers c join Orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name order by total_orders desc;

-- Q7. What is the average revenue per order?
select avg(order_value)as average_order_value from 
(select o.order_id, (o.quantity * p.price)as order_value from Orders o join Products p ON o.product_id = p.product_id) t;

-- Q8. Which products are running low on stock?
SELECT product_name, stock_quantity from Products where stock_quantity < 20 order by stock_quantity asc;

-- Q9. Which customers have not ordered in the last 6 months?
select c.customer_id, c.customer_name, max(o.order_date)as last_order_date from Customers c left join Orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name having last_order_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH) or last_order_date IS NULL;

-- Q10. How many unique customers purchased each product?
SELECT p.product_name, count(distinct o.customer_id)as unique_customers from Orders o join Products p on o.product_id = p.product_id
group by p.product_name order by unique_customers desc;

-- Q11. Product with the highest price.
select product_name,price from products where price = (select max(price) from products);

-- Q12. Product with the lowest price.
select product_name,price from products where price = (select min(price) from products);

-- Q13. Customer who spent the most money.
select c.customer_name as CName,sum(p.price*o.quantity)as TotalAmount from Orders o join customers c on o.customer_id=c.customer_id 
join products p on o.product_id=p.product_id group by c.customer_name order by TotalAmount desc limit 1;

-- Q14.  Most frequently ordered product
select p.product_name as PName,sum(o.quantity)as TotalQuantity from Orders o join customers c on o.customer_id=c.customer_id 
join products p on o.product_id=p.product_id group by p.product_name order by TotalQuantity desc limit 1;

-- Q15. City with the highest number of customers
select city,count(*) as Customers from customers group by city order by Customers desc limit 1;

-- Q16. Total revenue from orders
select sum(p.price*o.quantity) as TotalRevenue from Orders o join products p on o.product_id = p.product_id;

-- Q17. Customers who placed orders on the same day
select order_date, group_concat(DISTINCT c.customer_name) as Customers from Orders o join customers c on o.customer_id = c.customer_id
group by order_date having count(distinct c.customer_id) > 1;

-- Q18. Distribution of product prices.
select case 
    when price between 0 and 1000 then '0-1000'
    when price between 1001 AND 5000 then '1001-5000'
    when price between 5001 AND 10000 then '5001-10000'
    when price between 10001 AND 30000 then '10001-30000'
else '30001+' end as PriceRange,count(*) as product_count from products group by PriceRange order by PriceRange desc;

-- Q19. Running Sum according to the products.
select product_id, product_name, price, sum(price) over (order by product_id)as RunningSum from Products;


