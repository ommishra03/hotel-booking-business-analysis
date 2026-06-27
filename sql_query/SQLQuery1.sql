CREATE DATABASE Om_Mishra_Assessment;
GO

USE Om_Mishra_Assessment;
GO

SELECT TOP 10 *FROM hotel_bookings;

Select Count (*) From hotel_bookings;

--- Table 1: Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_segment VARCHAR(30),
    customer_signup_date DATE NOT NULL,
    customer_home_city VARCHAR(100),
    customer_loyalty_tier VARCHAR(20)
);

--- Table 2: Properties
CREATE TABLE properties (
    property_id INT PRIMARY KEY,
    property_name VARCHAR(150) NOT NULL,
    property_city VARCHAR(100) NOT NULL,
    property_star_rating DECIMAL(2,1),
    property_type VARCHAR(50),
    property_total_rooms INT NOT NULL,

    CONSTRAINT uq_property
    UNIQUE(property_name, property_city) 
/*UNIQUE(property_name, property_city) 
prevents duplicate property records for the same hotel within the same city.*/
);

--- Table 3: Bookings
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,

    customer_id INT NOT NULL,
    property_id INT NOT NULL,

    booking_date DATE NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,

    room_type VARCHAR(50),
    num_rooms INT NOT NULL,
    nights INT NOT NULL,

    booking_channel VARCHAR(30),

    adr DECIMAL(10,2),
    discount_amount DECIMAL(12,2),
    coupon_code VARCHAR(50),

    total_amount DECIMAL(12,2) NOT NULL,

    payment_method VARCHAR(50),

    booking_status VARCHAR(20) NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (property_id)
        REFERENCES properties(property_id),

    CONSTRAINT chk_dates
    CHECK (checkout_date > checkin_date)
/*CHECK(checkout_date > checkin_date) prevents impossible stays and improves data quality. */
);

--- Table 4: Reviews
CREATE TABLE reviews (
    booking_id INT PRIMARY KEY,

    review_rating VARCHAR(20),
    review_date DATE,

    FOREIGN KEY (booking_id)
        REFERENCES bookings(booking_id)
);

/*Indexing because most customer analytics queries 
(LTV, booking sequence analysis, retention analysis, VIP identification) 
are performed at the customer level.
Indexing customer_id improves join performance and accelerates window 
functions partitioned by customer. */
CREATE INDEX idx_bookings_customer
ON bookings(customer_id);


--- C-Q1 (Booking Sequence Analysis)
WITH ranked_bookings AS (

    SELECT
        customer_id,
        total_amount,

        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY checkin_date
        ) AS booking_sequence

    FROM hotel_bookings

    WHERE booking_status = 'Completed'
)

SELECT
    CASE
        WHEN booking_sequence = 1 THEN 'First'
        WHEN booking_sequence = 2 THEN 'Second'
        ELSE 'Third+'
    END AS sequence_label,

    COUNT(*) AS n,
    ROUND(AVG(total_amount), 2) AS avg_total

FROM ranked_bookings

GROUP BY
    CASE
        WHEN booking_sequence = 1 THEN 'First'
        WHEN booking_sequence = 2 THEN 'Second'
        ELSE 'Third+'
    END;


--- C-Q2
/*
Reviews associated with bookings made through Corporate Portal are on the 1–10 scale and 
should be normalized to 1–5 by dividing by 2 before averaging, as instructed in the case prompt.
*/
WITH normalized_reviews AS (

    SELECT
        property_name,
        property_city,

        CASE
            WHEN booking_channel = 'Corporate Portal'
                THEN CAST(review_rating AS FLOAT) / 2.0
            ELSE CAST(review_rating AS FLOAT)
        END AS normalized_rating

    FROM hotel_bookings

    WHERE review_rating IS NOT NULL
)

SELECT TOP 5

    property_name,
    property_city,

    COUNT(*) AS num_reviews,

    CAST(
        AVG(normalized_rating)
        AS DECIMAL(5,2)
    ) AS normalized_avg_rating

FROM normalized_reviews

GROUP BY
    property_name,
    property_city

HAVING COUNT(*) >= 20

ORDER BY normalized_avg_rating DESC;