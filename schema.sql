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

-- Create a table named owners with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- full_name: string
-- age: integer
DROP TABLE IF EXISTS owners;

CREATE TABLE owners(
	id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(80),
	age INT,
	PRIMARY KEY(id)
);

-- Create a table named species with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string

DROP TABLE IF EXISTS species;

CREATE TABLE species(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(80),
	PRIMARY KEY(id)
);

-- Modify animals table:
-- Make sure that id is set as autoincremented PRIMARY KEY
ALTER TABLE ANIMALS
ADD PRIMARY KEY(id);
-- Remove column species
ALTER TABLE ANIMALS
DROP COLUMN species;
-- Add column species_id which is a foreign key referencing species table
ALTER TABLE ANIMALS
ADD COLUMN SPECIES_ID int REFERENCES SPECIES (id)
ADD FOREIGN KEY (SPECIES_ID) REFERENCES SPECIES(ID);
-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE ANIMALS
ADD COLUMN OWNERS_ID int REFERENCES OWNERS (id)
ADD FOREIGN KEY (SPECIES_ID) REFERENCES SPECIES(ID);


-- DAY 4

/*
Create a table named vets with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
name: string
age: integer
date_of_graduation: date
*/

DROP TABLE IF EXISTS VETS;

CREATE TABLE VETS (
	ID INT GENERATED ALWAYS AS IDENTITY,
	NAME VARCHAR(80),
	AGE INT,
	DATE_OF_GRADUATION DATE,
	PRIMARY KEY (ID)
);

BEGIN;
ALTER TABLE VETS
ADD UNIQUE (NAME);

ALTER TABLE SPECIES
ADD UNIQUE (NAME);

COMMIT;

/*
There is a many-to-many relationship between
 the tables species and vets: a vet can specialize 
 in multiple species, and a species can have multiple 
 vets specialized in it. Create a 
"join table" called specializations to handle this relationship.
*/
DROP TABLE IF EXISTS SPECIALIZATIONS;

CREATE TABLE SPECIALIZATIONS(
	VET_NAME VARCHAR(80),
	SPECIES_NAME VARCHAR(80),
	FOREIGN KEY (VET_NAME) REFERENCES VETS(NAME),
	FOREIGN KEY (SPECIES_NAME) REFERENCES SPECIES(NAME)
);

/*
There is a many-to-many relationship between 
the tables animals and vets: an animal can 
visit multiple vets and one vet can be 
visited by multiple animals. 
Create a "join table" called visits to 
handle this relationship, it should also keep track 
of the date of the visit.

*/

ALTER TABLE ANIMALS
ADD UNIQUE (NAME);

DROP TABLE IF EXISTS VISITS;

CREATE TABLE VISITS(
	VETS_NAME VARCHAR(80),
	ANIMAL_NAME VARCHAR(80),
	DATE_VISITED DATE,
	FOREIGN KEY (VETS_NAME) REFERENCES VETS (NAME),
	FOREIGN KEY (ANIMAL_NAME) REFERENCES ANIMALS (NAME)
);

