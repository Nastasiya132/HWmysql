use ls5;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Anastasiya', '1991-09-02', '10.12.2010 12:05', '15.02.2010 12:45'),
  ('Nataliya', '1975-06-10', '21.04.2009 05:31', '05.12.2015 12:55'),
  ('Alina', '1998-02-02', '16.09.2012 10:02', '13.08.2016 20:10'),
  ('Sergey', '1987-04-21', '21.10.2010 9:45', '21.10.2020 9:14'),
  ('Olga', '1964-11-07', '15.12.2015 12:43', '25.12.2019 13:22'),
  ('Alexandr', '1968-03-25', '25.03.2013 8:56', '22.05.2012 7:44');
  
 UPDATE
  users
SET
  created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
  updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');
 
 ALTER TABLE
  users
CHANGE
  created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
 
ALTER TABLE
  users
CHANGE
  updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP; 
 
 DESCRIBE users;

CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, 543, 0),
  (1, 789, 2500),
  (1, 3432, 0),
  (1, 826, 30),
  (1, 719, 500),
  (1, 638, 1);
 
 SELECT * FROM storehouses_products
ORDER BY IF(value > 0, 0, 1),
  value;
 
 SELECT * FROM storehouses_products
ORDER BY value = 0, value;
 
 
 
