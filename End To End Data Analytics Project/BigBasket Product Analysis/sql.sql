-- KPI

-- Total Products	
select count(product) as total_products from bb_products;

-- Total Brands	
select count(brand) as total_brandss from bb_products;

-- Total Categories	
select count(category) as total_category from bb_products;


-- Average Sale Price	
select round(avg(sale_price),2) as avg_sales_price from bb_products;


-- Average Market Price
select round(avg(market_price),2) as avg_sales_price from bb_products;	

-- Average Discount %
select round(avg(discount_per),2) as avg_sales_price from bb_products;	

-- Average Rating
select round(avg(rating),2) as avg_sales_price from bb_products;

-- Which categories contain the highest and lowest number of products?
select category, count(product) as product_count from bb_products
group by category
order by product_count desc;




	
