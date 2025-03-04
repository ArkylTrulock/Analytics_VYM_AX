COPY netflix_data
FROM 'C:\Users\tailb\Data Science\PostgreSQL Projects\CSV files\netflix1.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');