DROP DATABASE IF EXISTS example;

CREATE DATABASE example;

USE example;

CREATE TABLE flights (
    id SERIAL PRIMARY KEY,
    departure VARCHAR(255),
    arrival VARCHAR(255)
)  COMMENT='Маршруты рейсов';

INSERT INTO flights
VALUES 
	('1', 'Moscow', 'Ekaterinburg'),
	('2', 'Chelyabinsk', 'Sankt-Petersburg'),
	('3', 'Vladivostok', 'Moscow'),
	('4', 'Moscow', 'Kazan'),
	('5', 'Riga', 'Sankt-Petersburg');


CREATE TABLE cities (
    label VARCHAR(255),
    name VARCHAR(255)
)  COMMENT='Написание городов на русском языке';

INSERT INTO 
	cities 
VALUES 
	('Moscow', 'Москва'),
	('Ekaterinburg', 'Екатеринбург'),
	('Chelyabinsk', 'Челябинск'),
	('Sankt-Petersburg', 'Санкт-Петербург'),
	('Vladivostok', 'Владивосток'),
	('Kazan', 'Казань'),
	('Riga', 'Рига');

SELECT * FROM flights;

SELECT 
	id,
	(SELECT name FROM cities WHERE label = flights.departure) AS departure,
	(SELECT name FROM cities WHERE label = flights.arrival) AS arrival
FROM flights;
