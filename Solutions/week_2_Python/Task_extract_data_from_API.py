import requests
import psycopg2
from psycopg2 import sql

# Define database name
DB_NAME = "covid_19"
DB_USER = "shivampatel"
DB_PASSWORD = "shivampatel"
DB_HOST = "localhost"
DB_PORT = 5432

class CovidAPIClient:
    """Client to fetch COVID-19 statistics from the API."""
    BASE_URL = "https://coronavirus.m.pipedream.net/"

    def fetch_data(self):
        """Fetch COVID-19 data from API."""
        try:
            response = requests.get(self.BASE_URL)
            response.raise_for_status()  # Raises HTTPError for bad responses
            return response.json()
        except requests.RequestException as e:
            print(f"Error fetching data: {e}")
            return None

class PostgresDB:
    """PostgreSQL database client."""

    def __init__(self, dbname, user, password, host='localhost', port=5432):
        self.dbname = dbname
        self.user = user
        self.password = password
        self.host = host
        self.port = port
        self.connection = None

    def connect(self):
        """Establish a connection to the PostgreSQL database."""
        try:
            self.connection = psycopg2.connect(
                dbname=self.dbname,
                user=self.user,
                password=self.password,
                host=self.host,
                port=self.port
            )
        except psycopg2.Error as e:
            print(f"Database connection error: {e}")
            self.connection = None

    def create_database(self):
        """Create database if it doesn't exist."""
        try:
            conn = psycopg2.connect(
                dbname="postgres",  # Connect to default "postgres" database
                user=self.user,
                password=self.password,
                host=self.host,
                port=self.port
            )
            conn.autocommit = True
            cur = conn.cursor()

            cur.execute(f"SELECT 1 FROM pg_database WHERE datname = '{self.dbname}'")
            exists = cur.fetchone()
            if not exists:
                print(f"Database '{self.dbname}' does not exist. Creating now...")
                cur.execute(sql.SQL(f"CREATE DATABASE {self.dbname}"))
                print(f"Database '{self.dbname}' created successfully.")
            else:
                print(f"Database '{self.dbname}' already exists.")

            cur.close()
            conn.close()

        except psycopg2.Error as e:
            print(f"Error checking/creating database: {e}")

    def create_table(self):
        """Create the covid_stats table if it doesn't exist."""
        if not self.connection:
            print("No database connection.")
            return

        create_table_query = """
        CREATE TABLE IF NOT EXISTS covid_stats (
            id SERIAL PRIMARY KEY,
            country TEXT NOT NULL,
            cases INTEGER,
            deaths INTEGER,
            recovered INTEGER
        );
        """
        try:
            with self.connection.cursor() as cursor:
                cursor.execute(create_table_query)
                self.connection.commit()
        except psycopg2.Error as e:
            print(f"Error creating table: {e}")
            self.connection.rollback()

    def insert_data(self, country, cases, deaths, recovered):
        """Insert country-wise COVID-19 data into the database."""
        if not self.connection:
            print("No database connection.")
            return

        # Ensure that empty strings are converted to None (NULL)
        cases = int(cases) if cases else None
        deaths = int(deaths) if deaths else None
        recovered = int(recovered) if recovered else None

        insert_query = sql.SQL("""
        INSERT INTO covid_stats (country, cases, deaths, recovered)
        VALUES (%s, %s, %s, %s);
        """)

        try:
            with self.connection.cursor() as cursor:
                cursor.execute(insert_query, (country, cases, deaths, recovered))
                self.connection.commit()
        except psycopg2.Error as e:
            print(f"Error inserting data: {e}")
            self.connection.rollback()

    def close(self):
        """Close the database connection."""
        if self.connection:
            self.connection.close()

def main():
    # Initialize API client and database client
    api_client = CovidAPIClient()
    db_client = PostgresDB(DB_NAME, DB_USER, DB_PASSWORD, DB_HOST, DB_PORT)

    # Ensure database exists
    db_client.create_database()

    # Connect to database and create table
    db_client.connect()
    db_client.create_table()

    # Fetch data from API
    data = api_client.fetch_data()
    if data and "rawData" in data:
        print("...Fetching COVID-19 statistics...")

        for record in data["rawData"]:
            country = record.get("Country_Region", "Unknown")
            cases = record.get("Confirmed", 0)
            deaths = record.get("Deaths", 0)
            recovered = record.get("Recovered", 0)

            db_client.insert_data(country, cases, deaths, recovered)

        print("Data inserted successfully.")

    # Close database connection
    db_client.close()

if __name__ == "__main__":
    main()

