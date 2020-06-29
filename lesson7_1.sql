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

SELECT p.id as product_id, p.name as product_name, c.name as catalogs_name
FROM products p
LEFT JOIN catalogs c ON p.cat_id=c.id
WHERE 1
ORDER BY p.cat_id, p.name



