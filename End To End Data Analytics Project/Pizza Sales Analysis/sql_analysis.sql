-- KPI

-- Total Revenue
select round(sum(total_price),2) as total_revenue
from pizza_sale;

-- distinct orders
select count(distinct order_id) as total_order
from pizza_sale;

-- Total Pizzas Sold
select sum(quantity) as total_pizza_sales
from pizza_sale;

-- Average Order Value
select round(sum(total_price)/count(order_id),2) as average_order_value
from pizza_sale;

-- Average Pizzas per Order
select round(avg(quantity)) as avg_pizza_per_order
from pizza_sale;

-- Average Selling Price
select round(avg(total_price),2) as avg_selling_price
from pizza_sale;


-- Revenue by Category / Size
select pizza_category, round(sum(total_price),2) as total_revenue
from pizza_sale
group by pizza_category;


-- Top / Bottom Pizza
select pizza_category, round(sum(total_price),2) as total_revenue, round(sum(quantity)) as total_quantity
from pizza_sale
group by pizza_category
order by total_revenue desc, total_quantity desc;

-- Ingredient Demand (kg)

select i.pizza_ingredients, ROUND(SUM(s.quantity * i.items_qty_in_grams) / 1000,2) AS ingredient_demand_kg 
from pizza_ingredients i
inner join pizza_sale s
on i.pizza_name_id = s.pizza_name_id
group by i.pizza_ingredients
order by ingredient_demand_kg desc;

-- Data Analysis
-- Month-by-month performance
-- monthly revenue, orders, units and month-over-month revenue change
select month_flag, round(avg(total_price),2) as revenue, count(distinct order_id) as orders, sum(quantity) as quantity
from pizza_sale
group by month_flag;


