CREATE DATABASE sampledb;
\c sampledb;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(50)
);

INSERT INTO users (name, email) VALUES ('Marie', 'alice@example.com'), ('John', 'bob@example.com');