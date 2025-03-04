CREATE TABLE netflix_data (
    show_id SERIAL PRIMARY KEY,
    type TEXT,
    title TEXT,
    director TEXT,
    country TEXT,
    date_added DATE,
    release_year TEXT,
    rating TEXT,
    duration TEXT,
    listed_in TEXT
);