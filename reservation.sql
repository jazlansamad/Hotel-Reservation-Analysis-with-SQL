-- see All Data
SELECT *
FROM HotelRD;

-- 1.check the reservation
SELECT 
count('BOOKING_ID')
FROM HotelRD hr 

-- Check how many Meal available
SELECT 
    COUNT(DISTINCT type_of_meal_plan) as number_of_meal_plans
FROM 
    HotelRD hr

 -- Check the name of Meal available in data
SELECT 
    DISTINCT type_of_meal_plan
FROM
    HotelRD hr 
  
-- 2. Check The Most Popular Meal reserved at the Hotel
SELECT 
    type_of_meal_plan,
    COUNT(*) as count
FROM 
    HotelRD hr 
GROUP BY 
    type_of_meal_plan
ORDER BY 
    count DESC 
LIMIT 1;

-- 3. How much average price per room with children 
SELECT 
    AVG(avg_price_per_room) as average_price
FROM 
    HotelRD hr
WHERE 
    no_of_children > 0;


-- 4. How many Reservation in Hotel in 2018
SELECT 
    COUNT(*) as num_reservations_2018
FROM 
    HotelRD hr
WHERE 
  substr(arrival_date, -4) = '2018';
 
 
 -- 5. What is the commonly book Room type?
 SELECT 
    room_type_reserved,
    COUNT(*) AS booking_count
FROM 
    HotelRD
GROUP BY 
    room_type_reserved
ORDER BY 
    booking_count DESC
LIMIT 1;


-- 6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?
SELECT 
    COUNT(*) AS num_weekend_reservations
FROM 
    HotelRD
WHERE 
    no_of_weekend_nights > 0;

 
-- 7. What is the highest and lowest lead time for reservations?
SELECT 
    MAX(lead_time) AS max_lead_time,
    MIN(lead_time) AS min_lead_time
FROM 
    HotelRD;
    
-- 8. What is the most common market segment type for reservations?
SELECT 
    market_segment_type,
    COUNT(*) AS segment_count
FROM 
    HotelRD
GROUP BY 
    market_segment_type
ORDER BY 
    segment_count DESC
LIMIT 1;

-- 9. How many reservations have a booking status of "Confirmed"?
SELECT 
    COUNT(*) AS num_confirmed_reservations
FROM 
    HotelRD
WHERE 
    booking_status = 'Not_Canceled';
    
-- 10. What is the total number of adults and children across all reservations?
  SELECT 
    SUM(no_of_adults) AS total_adults,
    SUM(no_of_children) AS total_children
FROM 
    HotelRD;
    
 -- 11. What is the average number of weekend nights for reservations involving children
 SELECT 
    AVG(no_of_weekend_nights) AS avg_weekend_nights_with_children
FROM 
    HotelRD
WHERE 
    no_of_children > 0;
    
 -- 12. How many reservations were made in each month of the year?
    ALTER TABLE HotelRD
ADD COLUMN standardized_arrival_date DATE;

UPDATE HotelRD
SET standardized_arrival_date = STR_TO_DATE(arrival_date, '%d/%m/%Y')
WHERE arrival_date LIKE '%/%/%';

UPDATE HotelRD
SET standardized_arrival_date = STR_TO_DATE(arrival_date, '%d-%m-%Y')
WHERE arrival_date LIKE '%-%-%';

SELECT arrival_date, standardized_arrival_date
FROM HotelRD
LIMIT 100;

 -- 12. How many reservations were made in each month of the year?
SELECT
    YEAR(standardized_arrival_date) AS year,
    MONTH(standardized_arrival_date) AS month,
    COUNT(*) AS num_reservations
FROM
    HotelRD
GROUP BY
    year, month
ORDER BY
    year, month;
    
   -- 13. What is the average number of nights (both weekend and weekday) spent by guests for each room type?   
   SELECT
    room_type_reserved,
    ROUND(AVG(no_of_weekend_nights + no_of_week_nights)/2.0, 3) AS avg_number_of_nights
FROM
    HotelRD
GROUP BY
    room_type_reserved
ORDER BY
    avg_number_of_nights ASC;

-- 14. For reservations involving children, what is the most common room type, and what is the average price for that room type?
   
    SELECT
        room_type_reserved,
        AVG(avg_price_per_room) AS avg_price
    FROM
        HotelRD
    WHERE
        no_of_children > 0
    GROUP BY
        room_type_reserved
	ORDER BY
    	count(*) desc LIMIT 1;
	

-- 15. Find the market segment type that generates the highest average price per room.
SELECT
    market_segment_type,
    AVG(avg_price_per_room) AS avg_price_per_room
FROM
    HotelRD
GROUP BY
    market_segment_type
ORDER BY
    avg_price_per_room DESC
LIMIT 6;



