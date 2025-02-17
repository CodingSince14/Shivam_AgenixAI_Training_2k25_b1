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


--1: Retrieve the top 5 most-issued books with their issue count.

SELECT books.book_id, books.title, COUNT(transaction_id) AS num_transaction
FROM books
JOIN transactions ON books.book_id = transactions.book_id
GROUP BY books.book_id, books.title
ORDER BY num_transaction DESC
LIMIT 5;

/*
Output:
lms_db=# SELECT books.book_id, books.title, COUNT(transaction_id) AS num_transaction
FROM books
JOIN transactions ON books.book_id = transactions.book_id
GROUP BY books.book_id, books.title
ORDER BY num_transaction DESC
LIMIT 5;
 book_id |       title        | num_transaction 
---------+--------------------+-----------------
       4 | Boy mean church.   |               6
      28 | Foot during.       |               4
      18 | Opportunity first. |               4
       7 | Image soon.        |               4
      19 | Director consumer. |               3
(5 rows)

lms_db=# 
*/

--Explaination:
-- SELECT books.book_id, books.title, COUNT(transaction_id) AS num_transaction
-- "books.book_id" - Retrieves the book id of each book
-- "books.title" - Retrieves the title of each book
-- "COUNT(transaction_id) AS num_transaction" - Counts how many time the book appears on transaction table and stores in num_transaction.
-- "FROM books" - Specifies to select books table
-- "JOIN transactions ON books.book_id = transactions.book_id" - Combines the data from books and transactions table.
-- "GROUP BY books.book_id, books.title" - Groups the results for each book's ID and title
-- "ORDER BY num_transaction DESC" - Sort the order in descending order
-- "LIMIT 5" - Limit to 5


--2: List books along with their authors that belong to the "Fantasy" genre, sorted by publication year in descending order.

SELECT books.title, books.publication_year, author.first_name, author.last_name
FROM books
JOIN authors ON books.author_id = author.author_id
JOIN category ON books.category_id = category.category_id
WHERE category.category_name = 'Fantasy'
ORDER BY books.publication_year DESC;

/*
Output:
lms_db=# SELECT books.title, books.publication_year, authors.first_name, authors.last_name
FROM books
JOIN authors ON books.author_id = authors.author_id
JOIN category ON books.category_id = category.category_id
WHERE category.category_name = 'Fantasy'
ORDER BY books.publication_year DESC;
 title | publication_year | first_name | last_name 
-------+------------------+------------+-----------
(0 rows)

lms_db=# 
*/
/*
Explanation:
"books.title": Retrieves the title of the book
"books.publication_year": Retrieves the year the book was published
"authors.first_name and authors.last_name": Retrieves the first and last name of the book's author
"FROM books" - Specifies to select books table
"JOIN authors ON books.author_id = authors.autor_id": Combines the data from books and authors table
"JOIN category ON books.category_id = category.category_id": Combines the data from books and category table
"WHERE category.category_name = 'Fantasy'" : Filters to include the books where category is Fantasy
"ORDER BY books.publication_year DESC;": Sorts the publication yar in descending order.
*/


--3: Identify the top 3 customers who have borrowed the most books.

SELECT customers.customer_id, customers.first_name, customers.last_name, COUNT(transactions.transaction_id) AS borrow_count
FROM customers
JOIN transactions ON customers.customer_id = transactions.customer_id
GROUP BY customers.customer_id
ORDER BY borrow_count DESC
LIMIT 3;

/*
lms_db=# SELECT customers.customer_id, customers.first_name, customers.last_name, COUNT(transactions.transaction_id) AS borrow_count
FROM customers
JOIN transactions ON customers.customer_id = transactions.customer_id
GROUP BY customers.customer_id
ORDER BY borrow_count DESC
LIMIT 3;
 customer_id | first_name  | last_name | borrow_count 
-------------+-------------+-----------+--------------
          17 | David       | Sweeney   |            6
           3 | Christopher | Donovan   |            4
          11 | Warren      | Delacruz  |            4
(3 rows)

lms_db=# 
*/


--4: List all customers who have overdue books (assume overdue if ReturnDate is null and IssueDate is older than 30 days).

SELECT customers.customer_id, customers.first_name, customers.last_name, transactions.book_id, transactions.issue_date
FROM customers
JOIN transactions ON customers.customer_id = transactions.customer_id
WHERE transactions.return_date IS NULL
AND transactions.issue_date < CURRENT_DATE - INTERVAL '30 days';

/*
Output:
lms_db=# SELECT customers.customer_id, customers.first_name, customers.last_name, transactions.book_id, transactions.issue_date
FROM customers
JOIN transactions ON customers.customer_id = transactions.customer_id
WHERE transactions.return_date IS NULL
AND transactions.issue_date < CURRENT_DATE - INTERVAL '30 days';
 customer_id | first_name  | last_name | book_id | issue_date 
-------------+-------------+-----------+---------+------------
           2 | Rebecca     | Foster    |       5 | 2023-12-14
           2 | Rebecca     | Foster    |      16 | 2022-04-17
           3 | Christopher | Donovan   |      27 | 2021-01-08
           3 | Christopher | Donovan   |      11 | 2020-05-13
           3 | Christopher | Donovan   |      24 | 2023-10-18
           4 | Stephanie   | Lopez     |      16 | 2021-03-01
           5 | Sherri      | Glenn     |       4 | 2022-09-11
           5 | Sherri      | Glenn     |      23 | 2023-04-30
           6 | Bradley     | Glover    |      10 | 2024-06-28
           7 | Mary        | Price     |      26 | 2021-06-18
           9 | Krystal     | Garcia    |      23 | 2023-04-08
           9 | Krystal     | Garcia    |      19 | 2022-04-22
          10 | William     | Jones     |      28 | 2024-10-21
          10 | William     | Jones     |      29 | 2020-04-11
          11 | Warren      | Delacruz  |      11 | 2023-02-17
          11 | Warren      | Delacruz  |      29 | 2022-07-06
          12 | Joseph      | Harris    |      12 | 2023-01-28
          12 | Joseph      | Harris    |       6 | 2024-05-13
          12 | Joseph      | Harris    |       6 | 2023-09-19
          13 | Hunter      | Fields    |      19 | 2020-07-04
          13 | Hunter      | Fields    |      21 | 2021-03-09
          13 | Hunter      | Fields    |      28 | 2024-02-27
          14 | Brian       | Wright    |       8 | 2020-01-04
          15 | Dustin      | Soto      |       4 | 2021-12-23
          17 | David       | Sweeney   |      28 | 2020-12-20
          17 | David       | Sweeney   |       4 | 2020-09-23
          17 | David       | Sweeney   |      18 | 2022-12-11
          17 | David       | Sweeney   |       4 | 2020-12-14
          17 | David       | Sweeney   |      20 | 2023-07-14
          19 | Patricia    | Jackson   |      28 | 2022-07-23
          19 | Patricia    | Jackson   |       7 | 2022-12-24
          20 | Rose        | Larson    |      15 | 2020-03-04
(32 rows)

lms_db=# 
*/


--5. Find authors who have written more than 3 books.

SELECT authors.author_id, authors.first_name, authors.last_name, COUNT(books.book_id) AS book_count
FROM authors
JOIN books ON authors.author_id = books.author_id
GROUP BY authors.author_id
HAVING COUNT(books.book_id) > 3;

/*
Output:
lms_db=# SELECT authors.author_id, authors.first_name, authors.last_name, COUNT(books.book_id) AS book_count
FROM authors
JOIN books ON authors.author_id = books.author_id
GROUP BY authors.author_id
HAVING COUNT(books.book_id) > 3;
 author_id | first_name | last_name | book_count 
-----------+------------+-----------+------------
         4 | Ryan       | Medina    |          6
        10 | David      | Smith     |          4
         5 | Eric       | Anderson  |          5
(3 rows)

lms_db=# 
*/

--6. Retrieve a list of authors who have books issued in the last 6 months.

SELECT DISTINCT authors.author_id, authors.first_name, authors.last_name
FROM authors
JOIN books ON authors.author_id = books.author_id
JOIN transactions ON books.book_id = transactions.book_id
WHERE transactions.issue_date > CURRENT_DATE - INTERVAL '6 months';

/*
Output:
postgres=# \c lms_db 
You are now connected to database "lms_db" as user "postgres".
lms_db=# SELECT DISTINCT authors.author_id, authors.first_name, authors.last_name
FROM authors
JOIN books ON authors.author_id = books.author_id
JOIN transactions ON books.book_id = transactions.book_id
WHERE transactions.issue_date > CURRENT_DATE - INTERVAL '6 months';
 author_id | first_name | last_name 
-----------+------------+-----------
        10 | David      | Smith
(1 row)

lms_db=# 
*/
