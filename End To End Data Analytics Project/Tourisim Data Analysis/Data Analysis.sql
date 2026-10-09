-- KPI
-- Total Tourist Arrivals
select count(*) as total_tourist_arrival from tourism;

-- Total Countries
select count(distinct country) as total_countries from tourism;

-- Total Destination States
select count(distinct state) as total_destination_state from tourism;

-- Average Tourist Arrivals
select round(avg(population)) as tourist_arrivals from tourism;

-- Top Source Country
select country, count(country) as country_count from tourism
group by country
order by country_count desc;

-- Top Destination State
select state, count(state) as top_destination_state from tourism
group by state
order by top_destination_state desc
limit 1;

-- Top Entry Mode
select way_in, count(*) as way_in_count from tourism
group by way_in
order by way_in_count desc
limit 1;

-- Peak Month
select month, count(month) as month_count from tourism
group by month
order by month_count desc
;

-- •	Show arrivals by month or season using a column chart.
select seasons, count(seasons) from tourism
group by seasons;



-- Business Analysis Questions
-- 1.	What is the total number of tourist arrivals in the complete dataset?
select count(*) as total_tourist_arrival from tourism;


-- 2.	Which 5 countries contribute the highest number of tourist arrivals?
select country, count(state) as highest_number_of_tourist_arrivals from tourism
group by country
order by highest_number_of_tourist_arrivals desc
limit 5;


-- 3.	Which continents contribute the most tourist arrivals?
select continent, count(state) as highest_number_of_tourist_arrivals from tourism
group by continent
order by highest_number_of_tourist_arrivals desc
limit 1;


-- 4.	Which 5 destination states receive the highest number of tourists?
select state, count(state) as highest_number_of_tourist_arrivals from tourism
group by state
order by highest_number_of_tourist_arrivals desc
limit 5;


-- 5.	Which entry mode (Air, Land, River, or Sea) is used the most by tourists?
select way_in, count(*) as highest_number_of_tourist_arrivals from tourism
group by way_in
order by highest_number_of_tourist_arrivals desc;


-- 6.	Which month records the highest tourist arrivals?
select month, count(*) as highest_number_of_tourist_arrivals from tourism
group by month 
order by highest_number_of_tourist_arrivals desc
limit 1;


-- 7.	Which season has the highest tourist arrivals?
select seasons, count(*) as highest_number_of_tourist_arrivals from tourism
group by seasons 
order by highest_number_of_tourist_arrivals desc
limit 1;


-- 8.	How have total tourist arrivals changed year by year?
select year, count(*) as total_tourist_arrivals from tourism
group by year;

-- 9.	Which year recorded the highest tourist arrivals and which year recorded the lowest?
select year, count(*) as total_tourist_arrivals from tourism
group by year
order by total_tourist_arrivals;


-- 10.	For each year, which country contributed the highest number of tourists?
select year, country, count(*) as total_tourist_arrivals from tourism
group by year, country
order by total_tourist_arrivals desc
limit 1;


-- 11.	What are the tourist arrival trends across the 12 months?
select month, count(*) as total_tourist_arrivals from tourism
group by month;

-- 12.	How do tourist arrivals differ by entry mode across the different destination states?
select state, way_in, count(*) as total_tourist_arrivals from tourism
group by state, way_in;


