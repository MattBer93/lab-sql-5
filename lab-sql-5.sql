use sakila;

-- 1 Drop column picture from staff.
alter table staff
drop column picture;

-- 2) A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO staff values 
('3', 'Tammy', 'Sanders', 5, 'tammy.sanders@sakilastaff.com', 2, 1, 'Tammy', null, now());
select * from staff;

-- 3) Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
-- You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there. 
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
insert into rental values
(16050, now(), 9, 130, null, 1, now());

select * from rental
order by last_update desc;

-- 4) Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users 
-- that would be deleted. Follow these steps:
use sakila;

-- Check if there are any non-active users
select * from customer
where active = 0;

-- Create a table backup table as suggested
	-- How to check data types?
	describe customer;
    
create table if not exists deleted_users (
	`cancellation_id` int unique not null auto_increment,
	`customer_id` smallint unsigned default null,
    `email` varchar(40) default null,
    `date` datetime,
    constraint primary key (cancellation_id),
    constraint foreign key (customer_id) references customer(customer_id)
) ;

drop table deleted_users;

-- Insert the non active users in the table backup table
insert into deleted_users (customer_id, email, `date`) 
select customer_id, email, create_date
from customer;

-- Delete the non active users from the table customer
set SQL_SAFE_UPDATES = 0;
set FOREIGN_KEY_CHECKS=0;
delete from customer
where active = 0;
set FOREIGN_KEY_CHECKS = 1;
set SQL_SAFE_UPDATES = 1;

-- check
select * from customer
where active = 0; -- gives null
select * from deleted_users;











