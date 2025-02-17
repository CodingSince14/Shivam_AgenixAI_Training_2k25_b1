# Generate Synthetic data using PYTHON

import random
import psycopg2
from faker import Faker

# Initialize Faker instance
fake = Faker()

# Constants
NUM_AUTHORS = 10
NUM_CATEGORIES = 5
NUM_BOOKS = 30
NUM_CUSTOMERS = 20
NUM_TRANSACTIONS = 50

# Database connection parameters
DB_HOST = 'localhost'
DB_NAME = 'lms_db'
DB_USER = 'shivampatel'
DB_PASSWORD = 'shivampatel'

# Function to connect to the PostgreSQL database
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

# Generate synthetic data for authors
def generate_authors():
    authors = []
    for author_id in range(1, NUM_AUTHORS + 1):
        first_name = fake.first_name()
        last_name = fake.last_name()
        birth_date = fake.date_of_birth(minimum_age=30, maximum_age=80).strftime('%Y-%m-%d')
        nationality = fake.country()
        authors.append((author_id, first_name, last_name, birth_date, nationality))
    return authors

# Generate synthetic data for categories
def generate_categories():
    categories = []
    for category_id in range(1, NUM_CATEGORIES + 1):
        category_name = fake.word()
        categories.append((category_id, category_name))
    return categories

# Generate synthetic data for books
def generate_books(authors, categories):
    books = []
    for book_id in range(1, NUM_BOOKS + 1):
        title = fake.sentence(nb_words=3)
        author_id = random.choice(authors)[0]
        category_id = random.choice(categories)[0]
        publication_year = random.randint(1900, 2023)
        books.append((book_id, title, author_id, category_id, publication_year))
    return books

# Generate synthetic data for customers
def generate_customers():
    customers = []
    for customer_id in range(1, NUM_CUSTOMERS + 1):
        first_name = fake.first_name()
        last_name = fake.last_name()
        email = fake.email()
	# Generate and truncate phone_number to 20 characters
        phone_number = fake.phone_number()[:20]
        customers.append((customer_id, first_name, last_name, email, phone_number))
    return customers

# Generate synthetic data for transactions
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

# Function to generate SQL INSERT statements and insert into the DB
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
        # Insert authors into the database
        for author in authors:
            cursor.execute("""
                INSERT INTO authors (author_id, first_name, last_name, birth_date, nationality)
                VALUES (%s, %s, %s, %s, %s);
            """, author)

        # Insert categories into the database
        for category in categories:
            cursor.execute("""
                INSERT INTO category (category_id, category_name)
                VALUES (%s, %s);
            """, category)

        # Insert books into the database
        for book in books:
            cursor.execute("""
                INSERT INTO books (book_id, title, author_id, category_id, publication_year)
                VALUES (%s, %s, %s, %s, %s);
            """, book)

        # Insert customers into the database
        for customer in customers:
            cursor.execute("""
                INSERT INTO customers (customer_id, first_name, last_name, email, phone_number)
                VALUES (%s, %s, %s, %s, %s);
            """, customer)

        # Insert transactions into the database
        for transaction in transactions:
            cursor.execute("""
                INSERT INTO transactions (transaction_id, book_id, customer_id, issue_date, due_date, return_date)
                VALUES (%s, %s, %s, %s, %s, %s);
            """, transaction)

        # Commit the transactions
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
    
'''
What the Script Does:
1. Generate Authors: Creates 10 random authors with first name, last name, birth date, and nationality. 
2. Generate Categories: Creates 5 random categories (e.g., 'Fiction', 'Science', etc.). 
3. Generate Books: Creates 30 books with random titles, authors, categories, and publication years. 
4. Generate Customers: Creates 20 customers with random first name, last name, email, and phone number. 
5. Generate Transactions: Creates 50 random book transactions (book issue and due dates). Some transactions may include a return date. 
6. Added a connect_db() function to establish a connection to the PostgreSQL database using the psycopg2 library. 
7. The insert_data_into_db() function now generates the data using the same methods as before and executes the corresponding SQL INSERT statements to insert data into the PostgreSQL database.
'''
