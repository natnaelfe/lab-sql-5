USE sakila;

# 1. Drop column picture from staff.
SELECT *
FROM staff;

ALTER TABLE staff
DROP COLUMN picture;

# 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT *
FROM customer
WHERE first_name = "tammy";

INSERT INTO staff
VALUES (3, 'Tammy', 'Sanders', 3, 'tammy.Sanders@sakilastaff.com', 2, 1, 'Tammy', 'sdasas', '2006-02-15 03:57:16');

# 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
SELECT *
FROM film
WHERE title = "Academy Dinosaur";

SELECT customer_id FROM sakila.customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER';

SELECT film_id FROM film
WHERE title = "Academy Dinosaur";

SELECT staff_id FROM staff
WHERE first_name = 'Mike' AND last_name = 'Hillyer'; # --> staff_id = 1

SELECT * 
FROM rental; # --> rental_id = 16050

INSERT INTO rental
VALUES (16050, NOW(), 1, 130, NOW(), 1, NOW());

SELECT *
FROM rental;

# 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
# Check if there are any non-active users
SELECT *
FROM customer
WHERE active = 0

# Create a table backup table as suggested

CREATE TABLE deleted_users (
  customer_id INT(11) NOT NULL,
  email VARCHAR(50) NOT NULL,
  deleted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

# Insert the non active users in the table backup table
INSERT INTO deleted_users (customer_id, email) 
SELECT customer_id, email 
FROM customer 
WHERE active = 0;

SELECT *
FROM deleted_users;

# Delete the non active users from the table customer

SELECT rental_id, rental_date, return_date, customer_id
FROM rental
WHERE customer_id IN (SELECT customer_id FROM customer WHERE active = 0);

DELETE FROM rental WHERE customer_id IN (SELECT customer_id FROM customer WHERE active = 0);

DELETE FROM customer 
WHERE active = 0;

SELECT *
FROM customer
WHERE active = 0; # --> Zero returns