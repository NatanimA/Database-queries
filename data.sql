/* Populate database with sample data. */
--  His name is Agumon. He was born on Feb 3rd, 2020, and currently weighs 10.23kg. He was neutered and he has never tried to escape.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Agumon','2020-Feb-3',10.23,true,0);
--  Her name is Gabumon. She was born on Nov 15th, 2018, and currently weighs 8kg. She is neutered and she has tried to escape 2 times.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Gabumon','2018-Nov-15',8,true,2);
-- His name is Pikachu. He was born on Jan 7th, 2021, and currently weighs 15.04kg. He was not neutered and he has tried to escape once.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Pikachu','2021-Jan-7',15.04,false,1);
-- Her name is Devimon. She was born on May 12th, 2017, and currently weighs 11kg. She is neutered and she has tried to escape 5 times.
INSERT into animals(name,date_of_birth,weight_kg,neutered,escape_attempts) values('Devimon','2017-May-12',11,true,5);

