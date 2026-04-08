-- Q1. Last booked room per user
SELECT b.user_id, b.room_no
FROM bookings b
JOIN (
    SELECT user_id, MAX(booking_date) AS last_date
    FROM bookings
    GROUP BY user_id
) latest
ON b.user_id = latest.user_id
AND b.booking_date = latest.last_date;

-- Q2:Total billing amount for bookings in November 2021
SELECT 
    bc.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM booking_commercials bc
JOIN items i 
    ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 11 
  AND YEAR(bc.bill_date) = 2021
GROUP BY bc.booking_id;

-- Q3:Bills in October 2021 with amount > 1000
SELECT 
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM booking_commercials bc
JOIN items i 
    ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10
  AND YEAR(bc.bill_date) = 2021
GROUP BY bc.bill_id
HAVING total_amount > 1000;

-- Q4:Most and least ordered item per month in 2021
WITH item_sales AS (
    SELECT 
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS month,
        bc.item_id,
        SUM(bc.item_quantity) AS total_qty
    FROM booking_commercials bc
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY month, bc.item_id
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY total_qty DESC) AS highest_rank,
           RANK() OVER (PARTITION BY month ORDER BY total_qty ASC) AS lowest_rank
    FROM item_sales
)
SELECT *
FROM ranked
WHERE highest_rank = 1 OR lowest_rank = 1;

-- Q5: 2nd highest bill per month in 2021
WITH bill_data AS (
    SELECT 
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS month,
        bc.bill_id,
        SUM(bc.item_quantity * i.item_rate) AS total_amount
    FROM booking_commercials bc
    JOIN items i 
        ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY month, bc.bill_id
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY total_amount DESC) AS rnk
    FROM bill_data
)
SELECT *
FROM ranked
WHERE rnk = 2;
