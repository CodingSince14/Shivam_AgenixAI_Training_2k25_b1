--The Conceptual Data Model provides a high-level overview of the system's data and its relationships without going into technical details. It focuses on the entities, their attributes, and the relationships between them.

/*Entities and Attributes:

Authors:
author_id (PK): Unique identifier for each author. 
first_name: First name of the author. 
last_name: Last name of the author. 
birth_date: Birth date of the author. 
nationality: Nationality of the author. 

Categories:
category_id (PK): Unique identifier for each category. 
category_name: Name of the book category (e.g., Fiction, Science, etc.). 

Books:
book_id (PK): Unique identifier for each book. 
title: Title of the book. 
author_id (FK): Foreign key referencing the Authors entity. 
category_id (FK): Foreign key referencing the Categories entity. 
publication_year: Year the book was published. 

Customers:
customer_id (PK): Unique identifier for each customer. 
first_name: First name of the customer. 
last_name: Last name of the customer. 
email: Unique email address of the customer. 
phone_number: Phone number of the customer. 

Transactions:
transaction_id (PK): Unique identifier for each transaction. 
book_id (FK): Foreign key referencing the Books entity. 
customer_id (FK): Foreign key referencing the Customers entity. 
issue_date: Date when the book is issued. 
due_date: Due date for the return of the book. 
return_date: Actual return date of the book (can be NULL if not yet returned). 
*/

/*
Conceptual ER Diagram:
+----------------+       +------------------+       +-------------------+ 
|     Authors    |       |     Categories   |       |       Books        |
+----------------+       +------------------+       +-------------------+
| author_id (PK) |       | category_id (PK) |       | book_id (PK)       |
| first_name     |       | category_name    |       | title              |
| last_name      |       +------------------+       | author_id (FK)     |
| birth_date     |                               +->| category_id (FK)   |
| nationality    |                               |  | publication_year   |
+----------------+                               |  +-------------------+
                                                 | 
                                                 | 
                                      +---------------------+  
                                      |     Transactions    |
                                      +---------------------+
                                      | transaction_id (PK) |
                                      | book_id (FK)        |
                                      | customer_id (FK)    |
                                      | issue_date          |
                                      | due_date            |
                                      | return_date         |
                                      +---------------------+
                                                 |
                                                 |
                                       +---------------------+
                                       |     Customers       |
                                       +---------------------+
                                       | customer_id (PK)    |
                                       | first_name          |
                                       | last_name           |
                                       | email               |
                                       | phone_number        |
                                       +---------------------+
*/

-- The SQL file defines the structure of the database, including tables and their relationships.
-- Install the postgres and type the command to enter in postgres terminal "sudo -i -u postgres"
-- Enter "psql" command to enter into command-line interface.
-- Create the database in postgresql database using command "createDB db_name" in command-line interface.

createdb lms_db;

-- The schema for the lms_db database:

-- author_id is defined as PRIMARY KEY in the table author.
-- Since, author must have the first name. Hence, NOT NULL constraints is used.
CREATE TABLE authors(
	author_id INT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50),
	birth_date DATE,
	nationality VARCHAR(50)
);

-- category_id is defined as PRIMARY KEY in the category table.
-- The bool in the Library must have the category like "fiction", "Drama", "Comedy". Hence used the NOT NULL constraints.
CREATE TABLE category(
	category_id INT PRIMARY KEY,
	category_name VARCHAR(50) NOT NULL
);

-- book_id is defined as PRIMARY KEY in the books table.
-- author_id and category_id are defined as FOREIGN KEY as they ae used as PRIMARY KEY in other tables.
CREATE TABLE books(
	book_id INT PRIMARY KEY,
	title VARCHAR(50),
	author_id INT,
	category_id INT,
	publication_year INT,
	FOREIGN KEY (author_id) REFERENCES authors(author_id),
	FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- customer_id is defined as PRIMARY KEY in the customers table
-- email is unique for each customer. Hence used the constraints UNIQUE.
CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50),
	email VARCHAR(50) UNIQUE NOT NULL,
	phone_number VARCHAR(20)
);

-- transaction_id is PRIMARY KEY in transactions table.
-- book_id and customer_id are defined as FOREIGN KEY as they are used as PRIMARY KEY in other tables.
-- ON DELETE CASCADE constraints is used to delete all the child table records when parent table record is deleted.
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY,
	book_id INT REFERENCES books(book_id) ON DELETE CASCADE,
	customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
	issue_date DATE NOT NULL,
	due_date DATE NOT NULL,
	return_date DATE
);
