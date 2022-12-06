/* Database schema to keep the structure of entire database. */
/* 
CREATE DATABASE vet_clinic
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
    */

CREATE TABLE animals (
    id  int generated always as identity,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts int,
    neutered bool,
    weight_kg Decimal
);


-- Add a column species of type string to your animals table. Modify your schema.sql file.
ALTER TABLE animals
ADD COLUMN species VARCHAR(40);