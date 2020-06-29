use shop;

--#1

INSERT INTO orders 
	(`user_id`) 
VALUES 
	('2'),    
	('6'),
	('5'),
	('2'),
	('5'),
	('3'),
	('2'),
	('6'),
	('5');

SELECT id, name FROM users WHERE id = ANY (SELECT user_id FROM orders);

--#2

SELECT name, (SELECT name FROM catalogs c2 WHERE c2.id = p2.catalog_id) AS 'Catalog name' FROM products p2 WHERE name LIKE 'AMD%';



