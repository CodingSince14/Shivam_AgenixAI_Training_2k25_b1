# Extensive Python Learning Program

Welcome to the Python Learning Program! This foundational program is tailored to help you gain a strong understanding of Python basics, with an emphasis on practical applications and hands-on exercises.

---

## **1. Getting Started with Python**

### Objectives:

- Understand Python's significance and applications in the industry.
- Set up your development environment.
- Write your first Python program.

### Topics Covered:

- Introduction to Python and its ecosystem.
- Installing Python and IDEs (e.g., PyCharm, VS Code, Jupyter Notebook).
- Understanding Python’s syntax and structure.

### Exercises:

1. Install Python and an IDE of your choice.
2. Write a "Hello, World!" program.

### Practice Material:

1. Research and list three applications of Python in real-world scenarios.
2. Explore Python’s official documentation and note three key features you find interesting.

### Practice Links:

- [Python Practice: Getting Started](https://www.hackerrank.com/domains/tutorials/30-days-of-code)

### Live Example:

```python
# Hello, World! Program
print("Hello, World!")
```

### Recommended Video:

[Python Installation and Setup Tutorial](https://www.youtube.com/watch?v=YYXdXT2l-Gg)

### Detailed Explanation:

[Python.org: Getting Started](https://www.python.org/about/gettingstarted/)

---

## **2. Python Basics**

### Objectives:

- Master basic Python concepts such as data types, variables, and control flow.
- Learn how to work with collections and loops.

### Topics Covered:

- Variables and data types: int, float, str, bool.
- Operators: arithmetic, comparison, logical.
- Control structures: if-else, for loops, while loops.
- Basic I/O operations.

### Examples:

#### Variables and Data Types:

```python
# Integer, Float, String, Boolean
x = 10       # Integer
y = 3.14     # Float
name = "John"  # String
is_active = True # Boolean

print("Values:", x, y, name, is_active)
```

#### Arithmetic and Logical Operators:

```python
# Arithmetic Operators
result = 5 + 3 - 2 * 4 / 2
print("Arithmetic Result:", result)

# Logical Operators
print(5 > 3 and 2 < 4)  # True
print(5 < 3 or 2 > 4)   # False
```

#### Control Structures:

```python
# if-else Example
age = int(input("Enter your age: "))
if age >= 18:
    print("You are an adult.")
else:
    print("You are a minor.")

# for Loop Example
for i in range(1, 6):
    print("Counting:", i)

# while Loop Example
count = 0
while count < 3:
    print("Count:", count)
    count += 1
```

### Practice Material:

1. Write a program to check if a number is positive, negative, or zero.
2. Create a multiplication table using a for loop.
3. Write a program that takes a user’s input and prints whether it’s an integer or a float.

### Practice Links:

- [Python Basics Practice](https://www.practicepython.org/)

### Recommended Video:

[Python Variables and Data Types](https://www.youtube.com/watch?v=CqvZ3vGoGs0)

### Detailed Explanation:

[Real Python: Python Basics](https://realpython.com/python-basics/)

---

## **3. Data Structures in Python**

### Objectives:

- Learn and apply Python’s built-in data structures for solving problems.

### Topics Covered:

- Lists, tuples, sets, and dictionaries.

### Examples:

#### Lists:

```python
# List Operations
fruits = ["apple", "banana", "cherry"]
fruits.append("orange")  # Add an item
print("Fruits:", fruits)

# Iterating through a List
for fruit in fruits:
    print(fruit)
```

#### Tuples:

```python
# Immutable Collection
dimensions = (1920, 1080)
print("Width:", dimensions[0], "Height:", dimensions[1])
```

#### Sets:

```python
# Unique and Unordered
unique_numbers = {1, 2, 3, 3, 2}
print("Unique Numbers:", unique_numbers)
```

#### Dictionaries:

```python
# Key-Value Pair Storage
student = {"name": "Alice", "age": 20}
print("Name:", student["name"])

# Add New Key-Value Pair
student["grade"] = "A"
print(student)
```

### Practice Material:

1. Create a list of 5 integers and calculate their sum and average.
2. Write a program to find the largest number in a list.
3. Create a dictionary with 3 key-value pairs and update one value.
4. Write a program to check if a tuple contains a specific value.

### Practice Links:

- [Data Structures Practice on W3Schools](https://www.w3schools.com/python/python_lists.asp)

### Recommended Video:

[Python Data Structures](https://www.youtube.com/watch?v=R-HLU9Fl5ug)

### Detailed Explanation:

[W3Schools: Python Data Structures](https://www.w3schools.com/python/python_lists.asp)

---

## **4. Functions in Python**

### Objectives:

- Understand the importance of functions and how to define them.

### Topics Covered:

- Defining and calling functions.
- Arguments and return values.

### Examples:

#### Basic Function:

```python
def greet():
    print("Hello from a function!")

greet()
```

#### Function with Parameters:

```python
def add_numbers(a, b):
    return a + b

result = add_numbers(5, 3)
print("Sum:", result)
```

#### Function with Default Arguments:

```python
def introduce(name, age=18):
    print(f"I am {name} and I am {age} years old.")

introduce("Alice")
introduce("Bob", 25)
```

### Practice Material:

1. Write a function that takes a string as input and returns its reverse.
2. Create a function to check if a number is even or odd.
3. Write a function to calculate the factorial of a number.

### Practice Links:

- [Functions Practice on HackerRank](https://www.hackerrank.com/domains/python/py-functions)

### Recommended Video:

[Python Functions](https://www.youtube.com/watch?v=NSbOtYzIQI0)

### Detailed Explanation:

[GeeksforGeeks: Python Functions](https://www.geeksforgeeks.org/functions-in-python/)

---

## **5. Basic File Handling**

### Objectives:

- Learn how to read and write files in Python.

### Topics Covered:

- Opening and closing files.
- Reading from and writing to text files.

### Examples:

#### Writing to a File:

```python
with open("example.txt", "w") as file:
    file.write("Hello, File Handling!")
```

#### Reading from a File:

```python
with open("example.txt", "r") as file:
    content = file.read()
    print(content)
```

### Practice Material:

1. Write a program to create a file and write user input into it.
2. Write a program to read and display the content of a file.
3. Create a program to append text to an existing file and then display its content.

### Practice Links:

- [File Handling Practice on Programiz](https://www.programiz.com/python-programming/file-operation)

### Recommended Video:

[Python File Handling](https://www.youtube.com/watch?v=Uh2ebFW8OYM)

### Detailed Explanation:

[Python.org: File Handling](https://docs.python.org/3/tutorial/inputoutput.html#reading-and-writing-files)

---

## **6. Exception Handling**

### Objectives:

- Learn how to manage errors gracefully in Python.

### Topics Covered:

- Try-except blocks.
- Multiple exceptions.
- Finally and else clauses.

### Examples:

#### Basic Try-Except:

```python
try:
    number = int(input("Enter a number: "))
    print(10 / number)
except ValueError:
    print("Please enter a valid number!")
except ZeroDivisionError:
    print("Cannot divide by zero!")
```

#### Finally Clause:

```python
try:
    file = open("example.txt", "r")
    print(file.read())
finally:
    file.close()
```

### Practice Material:

1. Write a program to handle division by zero.
2. Handle multiple exceptions in a program that takes user input.
3. Use the `finally` clause to ensure a file is closed after operations.

### Practice Links:

- [Exception Handling Exercises](https://www.geeksforgeeks.org/python-exception-handling/)

### Recommended Video:

[Exception Handling in Python](https://www.youtube.com/watch?v=NIWwJbo-9_8)

### Detailed Explanation:

[Python.org: Errors and Exceptions](https://docs.python.org/3/tutorial/errors.html)

---

## **7. Constructors and Destructors**

### Objectives:

- Understand object initialization and cleanup in Python.

### Topics Covered:

- Constructor (`__init__` method).
- Destructor (`__del__` method).

### Examples:

#### Constructor:

```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def display_info(self):
        print(f"Name: {self.name}, Age: {self.age}")

person = Person("Alice", 30)
person.display_info()
```

#### Destructor:

```python
class Person:
    def __init__(self, name):
        self.name = name
        print(f"{self.name} is created.")

    def __del__(self):
        print(f"{self.name} is destroyed.")

# Object creation and destruction
person = Person("John")
del person
```

### Practice Material:

1. Create a class `Student` with a constructor that initializes `name` and `grade`. Add a destructor that prints a farewell message.
2. Write a program to demonstrate object creation and destruction in a sequence.
3. Use destructors to ensure that a resource, such as a database connection, is closed when the object is destroyed.

### Practice Links:

- [Constructor and Destructor Practice](https://www.hackerrank.com/domains/python/classes)

### Recommended Video:

[Python Constructors and Destructors](https://www.youtube.com/watch?v=x5MfGEWh674)

### Detailed Explanation:

[GeeksforGeeks: Python Constructors and Destructors](https://www.geeksforgeeks.org/constructors-and-destructors-in-python/)

---


