-- KPI ---
-- Total trains
select count(distinct i.train_no) as total_trains from train_info i
inner join train_schedule s
on i.train_no = s.train_no;


-- Total stations
select count(distinct station_code) as total_stations from train_schedule;


-- Trains per station
select station_code, count(distinct train_no) as trains_per_station from train_schedule
group by station_code;


-- Station entries per train
select train_no, count(*) as station_entries
from train_schedule
group by train_no;


-- Trains by operating day
select days, count(distinct train_no) as trains_by_operating_day from train_info
group by days;

-- Trains by source station
select source_station_name, count(distinct train_no) as no_of_trains from train_info
group by source_station_name;


-- Trains by destination station
select destination_station_name, count(distinct train_no) as no_of_trains from train_info
group by destination_station_name;


-- Trains missing schedules
select count(distinct i.train_no) from train_info i
left join train_schedule s
on i.train_no = s.train_no
where s.train_no is null;



-- Schedule trains missing details
select count(distinct i.train_no) from train_info i
left join train_schedule s
on i.train_no = s.train_no
where i.train_no is null;


-- DATA ANALYSIS--
-- 1. How many different trains are listed in the train details file?
select  count(distinct train_name) as no_of_trains from train_info;


-- 2. How many different stations are listed in the schedule file?
select  count(distinct station_name) as no_of_trains from train_schedule;


-- 3. Which trains have schedules, and what are their names?
select distinct i.train_no, i.train_name from train_info i
inner join train_schedule s
on i.train_no = s.train_no;



-- 4. Which trains have no schedule records?
select distinct i.train_no from train_info i
left join train_schedule s
on i.train_no = s.train_no
where s.train_no is null;


-- 5. Which train numbers in the schedule file have no train details?
select distinct train_no from train_schedule
where train_no is null;

-- 6. How many station entries does each train have, and what is its name?
select i.train_name, count(*) as no_of_station_entries 
from train_info i
inner join train_schedule s
on i.train_no = s.train_no
group by i.train_name;


-- 7. Which 5 trains have the most station entries?
select i.train_no,i.train_name,count(*) as no_of_station_entries
from train_info i
inner join train_schedule s
on i.train_no = s.train_no
group by i.train_no,i.train_name
order by no_of_station_entries desc
limit 5;


-- 8. How many different trains serve each station?
select station_code, station_name, count(distinct train_no) as serve_each_station
from train_schedule
group by station_code,station_name;


-- 9. How many different trains are listed for each operating day?
SELECT days,COUNT(DISTINCT train_no) AS diff_trains
FROM train_info
GROUP BY days;


-- 10. Which source and destination pairs have the most trains with schedule records?
select i.source_station_name,i.destination_station_name, count(DISTINCT i.train_no) as no_of_trains 
from train_info i
inner join train_schedule s
on i.train_no = s.train_no
group by i.source_station_name,i.destination_station_name
order by no_of_trains desc
limit 5;


