-- Q1: Last booked room per user
SELECT b.user_id, b.room_no
FROM bookings b
JOIN (
    SELECT user_id, MAX(booking_date) AS last_date
    FROM bookings
    GROUP BY user_id
) latest
ON b.user_id = latest.user_id
AND b.booking_date = latest.last_date;
