/* Populate database with sample data. */
--  His name is Agumon. He was born on Feb 3rd, 2020, and currently weighs 10.23kg. He was neutered and he has never tried to escape.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Agumon','2020-Feb-3',10.23,true,0);
--  Her name is Gabumon. She was born on Nov 15th, 2018, and currently weighs 8kg. She is neutered and she has tried to escape 2 times.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Gabumon','2018-Nov-15',8,true,2);
-- His name is Pikachu. He was born on Jan 7th, 2021, and currently weighs 15.04kg. He was not neutered and he has tried to escape once.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Pikachu','2021-Jan-7',15.04,false,1);
-- Her name is Devimon. She was born on May 12th, 2017, and currently weighs 11kg. She is neutered and she has tried to escape 5 times.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Devimon','2017-May-12',11,true,5);


--  His name is Charmander. He was born on Feb 8th, 2020, and currently weighs -11kg. He is not neutered and he has never tried to escape.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Charmander','2020-Feb-8',11,false,0);

-- Her name is Plantmon. She was born on Nov 15th, 2021, and currently weighs -5.7kg. She is neutered and she has tried to escape 2 times.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Plantmon','2021-Nov-15',5.7,true,2);

-- His name is Squirtle. He was born on Apr 2nd, 1993, and currently weighs -12.13kg. He was not neutered and he has tried to escape 3 times.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Squirtle','1993-Apr-2',12.13,false,3);

-- His name is Angemon. He was born on Jun 12th, 2005, and currently weighs -45kg. He is neutered and he has tried to escape once.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Angemon','2005-Jun-12',45,true,1);

-- His name is Boarmon. He was born on Jun 7th, 2005, and currently weighs 20.4kg. He is neutered and he has tried to escape 7 times.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Boarmon','2005-Jun-7',20.4,true,7);

-- Her name is Blossom. She was born on Oct 13th, 1998, and currently weighs 17kg. She is neutered and she has tried to escape 3 times.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Blossom','1998-Oct-13',17,true,3);

-- His name is Ditto. He was born on May 14th, 2022, and currently weighs 22kg. He is neutered and he has tried to escape 4 times.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Ditto','2022-May-14',22,true,4);

-- Day 3

/*
Insert the following data into the owners table:
Sam Smith 34 years old.
Jennifer Orwell 19 years old.
Bob 45 years old.
Melody Pond 77 years old.
Dean Winchester 14 years old.
Jodie Whittaker 38 years old.
*/
INSERT INTO owners(full_name,age)
VALUES ('Sam Smith',34),
		('Jennifer Orwell',19),
		('Bob',45),
		('Melody Pond',77),
		('Dean Winchester',14),
		('Jodie Whittaker',38);

-- Insert the following data into the species table:
-- Pokemon
-- Digimon
INSERT INTO SPECIES(NAME)
VALUES ('Pokemon'),
		('Digimon');

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
UPDATE ANIMALS
SET SPECIES_ID = 2
WHERE NAME LIKE '%mon';
-- All other animals are Pokemon
UPDATE ANIMALS
SET SPECIES_ID = 1
WHERE NAME NOT LIKE '%mon';

-- Modify your inserted animals to include owner information (owner_id)
BEGIN;
-- Sam Smith owns Agumon.
UPDATE ANIMALS
SET OWNERS_ID = 1
WHERE NAME = 'Agumon';
-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE ANIMALS
SET OWNERS_ID = 2
WHERE NAME = 'Gabumon' OR NAME = 'Pikachu';
-- Bob owns Devimon and Plantmon.
UPDATE ANIMALS
SET OWNERS_ID = 3
WHERE NAME = 'Devimon' OR NAME = 'Plantmon';
-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE ANIMALS
SET OWNERS_ID = 4
WHERE NAME = 'Charmander' OR NAME = 'Squirtle' OR NAME = 'Blossom';
-- Dean Winchester owns Angemon and Boarmon.
UPDATE ANIMALS
SET OWNERS_ID = 5
WHERE NAME = 'Angemon' OR NAME = 'Boarmon';

COMMIT;