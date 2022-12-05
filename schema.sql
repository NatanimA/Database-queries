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