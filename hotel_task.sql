select * from hotel;

--1. What is the total number of reservations in the dataset? 
select count(*) as total_res from hotel;

--2. Which meal plan is the most popular among guests? 
select type_of_meal, count(*) as meal_count
from hotel
where type_of_meal in ('Meal Plan 1', 'Meal Plan 2', 'Not Selected') 
group by type_of_meal
order by meal_count desc;

--3. What is the average price per room for reservations involving children? 
select round(avg(avg_price),2) as average_price_per_room
from hotel
where no_of_children > 0 and booking_status = 'Not_Canceled';
  
--4 How many reservations were made for the year 20XX (replace XX with the desired year)? 
select count(*) as num_reservations
FROM hotel
where extract(year from arrival_date) = 2017 and booking_status = 'Not_Canceled';

--5. What is the most commonly booked room type? 
select room_type_reserved, count(*) as most_booked
from hotel
where room_type_reserved in ('Room_Type 1', 'Room_Type 2', 'Room_Type 3',
			'Room_Type 4', 'Room_Type 5', 'Room_Type 6', 'Room_Type 7') 
group by room_type_reserved
order by most_booked desc;

--6. How many reservations fall on a weekend (no_of_weekend_nights > 0)? 
select no_of_weekend, count(*) as no_of_reservations
from hotel
where no_of_weekend > 0
group by no_of_weekend
order by no_of_reservations desc;

--7. What is the highest and lowest lead time for reservations? 
select max(lead_time) as highest_time, min(lead_time) as lowest_time
from hotel
where booking_status = 'Not_Canceled';

--8. What is the most common market segment type for reservations?
select market_segment, count(*) as most_common_type
from hotel
group by market_segment
order by most_common_type desc
limit 1;

--9. How many reservations have a booking status of "Confirmed"? 
select booking_status, count(*) as confirmed
from hotel
group by booking_status
order by booking_status desc;

--10. What is the total number of adults and children across all reservations?
select sum(no_of_children) as total_children, sum(no_of_adults) as total_adults
from hotel
where booking_status = 'Not_Canceled';

--11.What is the average number of weekend nights for reservations involving children?
select Round(avg(no_of_weekend),2) as avg_no_of_weekend_nights
from hotel
where booking_status in ('Not_Canceled') and no_of_children > 0;

--12. How many reservations were made in each month of the year?
select
    DATE_PART('year', arrival_date) as year,
    DATE_PART('month', arrival_date) as month,
    count(*) as num_reservations
from hotel
where booking_status = 'Not_Canceled'
group by DATE_PART('year', arrival_date), DATE_PART('month', arrival_date)
order by year, month;

--13. What is the average number of nights (both weekend and weekday) 
--    spent by guests for each room type? 
select room_type_reserved, round(avg(no_of_weekend + no_of_week),2) as avg_total_nights
from hotel
group by room_type_reserved;

--14. For reservations involving children, what is the most common room type, 
--and what is the average price for that room type?
select room_type_reserved, count(*) as num_reservations
from hotel
where no_of_children > 0 and booking_status = 'Not_Canceled'
group by room_type_reserved
order by num_reservations desc
limit 1;

--15.Find the market segment type that generates the highest average price per room. 
select market_segment, avg(avg_price) as avg_price_per_room
from hotel
group by market_segment
order by avg_price_per_room desc
LIMIT 1;
