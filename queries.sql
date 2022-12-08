/*Queries that provide answers to the questions from all projects.*/
-- Find all animals whose name ends in "mon".
select * from animals where name like '%mon';
-- Find all animals whose name ends in "mon".
select name from animals where date_of_birth between '2016-1-1' and '2019-1-1';
--List the name of all animals that are neutered and have less than 3 escape attempts.
select name from animals where neutered = true and escape_attempts < 3;
-- List the date of birth of all animals named either "Agumon" or "Pikachu".
select date_of_birth from animals where name = 'Agumon' or name = 'Pikachu';
-- List name and escape attempts of animals that weigh more than 10.5kg
select name,escape_attempts from animals where weight_kg > 10.5;
-- Find all animals that are neutered.
select * from animals where neutered = true;
-- Find all animals not named Gabumon.
select * from animals where name != 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
select * from animals where weight_kg >= 10.4 and weight_kg <= 17.3 ;

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
Begin;
UPDATE animals
SET 
species = 'unspecified';
Select * from animals;
ROLLBACK;


BEGIN;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals
SET species = 'digimon'
WHERE name like '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
SELECT * From animals;
-- Commit the transaction.

COMMIT;

-- Check Changes
SELECT * from animals;


-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)
BEGIN;
DELETE from animals;
ROLLBACK;
SELECT * from animals;

-- Inside a transaction
BEGIN;
SAVEPOINT BEFORE_DELETE;
-- Delete all animals born after Jan 1st, 2022.
DELETE from animals
where date_of_birth >= '2022-1-1';
-- Create a savepoint for the transaction.
SAVEPOINT AFTER_DELETE;
-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1;
-- Rollback to the savepoint
ROLLBACK TO AFTER_DELETE;
--Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
-- Commit transaction
COMMIT;
SELECT * from animals;

-- How many animals are there?
Select COUNT(*) from animals;

--How many animals have never tried to escape?
Select COUNT(*)
from animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
Select AVG(weight_kg)
from animals;

-- Who escapes the most, neutered or not neutered animals?
Select neutered , MAX(escape_attempts) as escape_attempts
from animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
Select species , MAX(weight_kg) as WEIGHT_MAX , MIN(weight_kg) as WEIGHT_MIN
from animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
Select species , AVG(escape_attempts)
from animals
WHERE date_of_birth between '1990-1-1' and '2000-1-1'
GROUP BY species

-- DAY 3

-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
SELECT * 
FROM ANIMALS a 
JOIN OWNERS o
ON a.OWNERS_ID = o.ID
WHERE o.full_name = 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT * 
FROM ANIMALS a 
JOIN SPECIES s
ON a.SPECIES_ID = s.ID
WHERE s.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT * 
FROM ANIMALS a 
Full JOIN OWNERS o
ON a.OWNERS_ID = o.ID
-- How many animals are there per species?
SELECT s.name, Count(*)
FROM ANIMALS a 
JOIN SPECIES s
ON a.SPECIES_ID = s.ID
Group by s.name;
-- List all Digimon owned by Jennifer Orwell.
SELECT *
FROM ANIMALS a 
JOIN OWNERS o ON a.OWNERS_ID = o.ID
JOIN SPECIES s ON a.species_id = s.id
WHERE a.name = 'Digimon' and o.full_name = 'Jennifer Orwell';
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT *
FROM ANIMALS a 
JOIN OWNERS o ON a.OWNERS_ID = o.ID
WHERE a.escape_attempts = 0 and o.full_name = 'Dean Winchester';
-- Who owns the most animals?
SELECT o.full_name,count(a.name)
FROM ANIMALS a 
JOIN OWNERS o ON a.OWNERS_ID = o.ID
GROUP BY o.full_name
ORDER BY COUNT(a.name) DESC;

-- DAY 4

-- Who was the last animal seen by William Tatcher?

SELECT A.NAME,VE.NAME AS VETS_NAME , MAX(DATE_VISITED) AS LAST_VISIT
FROM ANIMALS A
JOIN VISITS VI ON A.NAME = VI.ANIMAL_NAME
JOIN VETS VE ON VI.VETS_NAME = VE.NAME
WHERE VE.NAME = 'William Tatcher'
GROUP BY A.NAME,VE.NAME
ORDER BY MAX(DATE_VISITED) DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT VE.NAME,COUNT(DISTINCT VI.ANIMAL_NAME) FROM
VISITS VI
JOIN VETS VE ON VI.VETS_NAME = VE.NAME
WHERE VE.NAME = 'Stephanie Mendez'
GROUP BY VE.NAME

-- List all vets and their specialties, including vets with no specialties.
SELECT *
FROM VETS VE
FULL JOIN SPECIALIZATIONS SP
FULL JOIN SPECIES S ON SP.SPECIES_NAME = S.NAME
ON VE.NAME = SP.VET_NAME

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT VE.NAME AS VET,A.NAME AS ANIMAL,VI.DATE_VISITED
FROM ANIMALS A
JOIN VISITS VI ON VI.ANIMAL_NAME = A.NAME
JOIN VETS VE ON VE.NAME = VI.VETS_NAME
WHERE VE.NAME = 'Stephanie Mendez'
AND VI.DATE_VISITED = '2020-AUG-30';

-- What animal has the most visits to vets?

SELECT VI.ANIMAL_NAME,COUNT(VI.ANIMAL_NAME)
FROM VISITS VI
JOIN ANIMALS A  ON VI.ANIMAL_NAME = A.NAME
GROUP BY VI.ANIMAL_NAME
ORDER BY COUNT(VI.ANIMAL_NAME) DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT VETS_NAME, MIN(DATE_VISITED) AS FIRST_VISIT
FROM VISITS 
WHERE VETS_NAME = 'Maisy Smith'
GROUP BY VETS_NAME

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT VI.VETS_NAME,A.NAME,MAX(VI.DATE_VISITED) AS RECENT_VISITS
FROM VISITS VI
JOIN ANIMALS A ON VI.ANIMAL_NAME = A.NAME
JOIN VETS VE ON VE.NAME =VI.VETS_NAME
GROUP BY VI.VETS_NAME,A.NAME
ORDER BY MAX(VI.DATE_VISITED) DESC
LIMIT 5;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT V.name AS vet_name, COUNT(visits.animal_name) AS number_of_visits from vets V
left JOIN specializations C ON V.name = C.vet_name
left JOIN visits ON visits.vetS_name = V.name
WHERE C.species_name IS NULL
GROUP BY V.name, C.species_name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT VI.VETS_NAME,VI.ANIMAL_NAME AS SHOULD_SPECIAL_ON,
COUNT(VI.ANIMAL_NAME)
FROM ANIMALS A
JOIN VISITS VI ON A.NAME = VI.ANIMAL_NAME
JOIN VETS VE  ON VE.NAME = VI.VETS_NAME
WHERE VI.VETS_NAME = 'Maisy Smith'
GROUP BY VI.VETS_NAME,VI.ANIMAL_NAME
ORDER BY COUNT(VI.ANIMAL_NAME) DESC
LIMIT 1;

