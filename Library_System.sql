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
	customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE
	issue_date DATE NOT NULL,
	due_date DATE NOT NULL,
	return_date DATE
);


-- Generate Synthetic data using PYTHON

import random
import psycopg2
from faker import Faker

-- Initialize Faker instance
fake = Faker()

-- Constants
NUM_AUTHORS = 10
NUM_CATEGORIES = 5
NUM_BOOKS = 30
NUM_CUSTOMERS = 20
NUM_TRANSACTIONS = 50

-- Database connection parameters
DB_HOST = 'localhost'
DB_NAME = 'lms_db'
DB_USER = 'postgres'
DB_PASSWORD = 'password'

-- Function to connect to the PostgreSQL database
def connect_db():
    try:
        connection = psycopg2.connect(
            host=DB_HOST,
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD
        )
        return connection
    except Exception as e:
        print(f"Error connecting to the database: {e}")
        return None

-- Generate synthetic data for authors
def generate_authors():
    authors = []
    for author_id in range(1, NUM_AUTHORS + 1):
        first_name = fake.first_name()
        last_name = fake.last_name()
        birth_date = fake.date_of_birth(minimum_age=30, maximum_age=80).strftime('%Y-%m-%d')
        nationality = fake.country()
        authors.append((author_id, first_name, last_name, birth_date, nationality))
    return authors

-- Generate synthetic data for categories
def generate_categories():
    categories = []
    for category_id in range(1, NUM_CATEGORIES + 1):
        category_name = fake.word()
        categories.append((category_id, category_name))
    return categories

-- Generate synthetic data for books
def generate_books(authors, categories):
    books = []
    for book_id in range(1, NUM_BOOKS + 1):
        title = fake.sentence(nb_words=3)
        author_id = random.choice(authors)[0]
        category_id = random.choice(categories)[0]
        publication_year = random.randint(1900, 2023)
        books.append((book_id, title, author_id, category_id, publication_year))
    return books

-- Generate synthetic data for customers
def generate_customers():
    customers = []
    for customer_id in range(1, NUM_CUSTOMERS + 1):
        first_name = fake.first_name()
        last_name = fake.last_name()
        email = fake.email()
        phone_number = fake.phone_number()
        customers.append((customer_id, first_name, last_name, email, phone_number))
    return customers

-- Generate synthetic data for transactions
def generate_transactions(books, customers):
    transactions = []
    for transaction_id in range(1, NUM_TRANSACTIONS + 1):
        book_id = random.choice(books)[0]
        customer_id = random.choice(customers)[0]
        issue_date = fake.date_this_decade().strftime('%Y-%m-%d')
        due_date = fake.date_this_decade().strftime('%Y-%m-%d')
        return_date = None if random.choice([True, False]) else fake.date_this_decade().strftime('%Y-%m-%d')
        transactions.append((transaction_id, book_id, customer_id, issue_date, due_date, return_date))
    return transactions

-- Function to generate SQL INSERT statements and insert into the DB
def insert_data_into_db():
    connection = connect_db()
    if not connection:
        return
    
    cursor = connection.cursor()

    authors = generate_authors()
    categories = generate_categories()
    books = generate_books(authors, categories)
    customers = generate_customers()
    transactions = generate_transactions(books, customers)
try:
        -- Insert authors into the database
        for author in authors:
            cursor.execute("""
                INSERT INTO authors (author_id, first_name, last_name, birth_date, nationality)
                VALUES (%s, %s, %s, %s, %s);
            """, author)

        -- Insert categories into the database
        for category in categories:
            cursor.execute("""
                INSERT INTO category (category_id, category_name)
                VALUES (%s, %s);
            """, category)

        -- Insert books into the database
	for book in books:
            cursor.execute("""
                INSERT INTO books (book_id, title, author_id, category_id, publication_year)
                VALUES (%s, %s, %s, %s, %s);
            """, book)

        -- Insert customers into the database
        for customer in customers:
            cursor.execute("""
                INSERT INTO customers (customer_id, first_name, last_name, email, phone_number)
                VALUES (%s, %s, %s, %s, %s);
            """, customer)

        -- Insert transactions into the database
        for transaction in transactions:
            return_clause = f", %s" if transaction[5] else ", NULL"
            cursor.execute(f"""
                INSERT INTO transactions (transaction_id, book_id, customer_id, issue_date, due_date, return_date)
                VALUES (%s, %s, %s, %s, %s{return_clause});
            """, (transaction[0], transaction[1], transaction[2], transaction[3], transaction[4], transaction[5] if transaction[5] else None))

        -- Commit the transactions
        connection.commit()
        print("Data inserted successfully!")

    except Exception as e:
        print(f"Error inserting data: {e}")
        connection.rollback()

    finally:
        cursor.close()
        connection.close()

if __name__ == '__main__':
    insert_data_into_db()

/*
What the Script Does:
1. Generate Authors: Creates 10 random authors with first name, last name, birth date, and nationality. 
2. Generate Categories: Creates 5 random categories (e.g., 'Fiction', 'Science', etc.). 
3. Generate Books: Creates 30 books with random titles, authors, categories, and publication years. 
4. Generate Customers: Creates 20 customers with random first name, last name, email, and phone number. 
5. Generate Transactions: Creates 50 random book transactions (book issue and due dates). Some transactions may include a return date. 
6. Added a connect_db() function to establish a connection to the PostgreSQL database using the psycopg2 library. 
7. The insert_data_into_db() function now generates the data using the same methods as before and executes the corresponding SQL INSERT statements to insert data into the PostgreSQL database.
*/


/*
Below are the questions which needs to answer by an SQL queries:
1: Retrieve the top 5 most-issued books with their issue count.
2: List books along with their authors that belong to the "Fantasy" genre, sorted by publication year in descending order.
3: Identify the top 3 customers who have borrowed the most books.
4: List all customers who have overdue books (assume overdue if ReturnDate is null and IssueDate is older than 30 days).
5: Find authors who have written more than 3 books.
6: Retrieve a list of authors who have books issued in the last 6 months.
7. Calculate the total number of books currently issued and the percentage of books issued compared to the total available.
8. Generate a monthly report of issued books for the past year, showing month, book count, and unique customer count.
9: Add appropriate indexes to optimize queries.
10:Analyze query execution plans for at least two queries using EXPLAIN and write your understanding from execution query plan in your words.
*/


