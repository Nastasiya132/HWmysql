--#1

DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;

CREATE TABLE shop.users (
   id bigint unsigned NOT NULL AUTO_INCREMENT
  ,name varchar(255) DEFAULT NULL COMMENT 'Имя покупателя'
  ,birthday_at date DEFAULT NULL COMMENT 'Дата рождения'
  ,created_at datetime DEFAULT CURRENT_TIMESTAMP
  ,updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  ,PRIMARY KEY (id)
  ,UNIQUE KEY id (id)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Покупатели'
;

INSERT INTO shop.users
(id, name, birthday_at, created_at, updated_at)
VALUES
 (1, 'Ольга', '1964-07-11', '2019-06-20 21:28:27.0', '2020-06-21 21:28:27.0')
,(2, 'Наталья', '1975-05-05', '2020-06-20 21:28:27.0', '2020-06-20 21:28:27.0')
,(3, 'Александр', '1968-04-26', '2020-06-20 21:28:27.0', '2020-06-20 21:28:27.0')
,(4, 'Сергей', '1986-04-21', '2020-06-20 21:28:27.0', '2020-06-20 21:28:27.0')
,(5, 'Анастасия', '1991-09-02', '2020-06-20 21:28:27.0', '2020-06-20 21:28:27.0')
,(6, 'Мария', '1975-09-21', '2020-06-20 21:28:27.0', '2020-06-20 21:28:27.0')
;


DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;

CREATE TABLE sample.users (
   id bigint unsigned NOT NULL AUTO_INCREMENT
  ,name varchar(255) DEFAULT NULL COMMENT 'Имя пользователя'
  ,birthday_at date DEFAULT NULL COMMENT 'Дата рождения'
  ,created_at datetime DEFAULT CURRENT_TIMESTAMP
  ,updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  ,PRIMARY KEY (id)
  ,UNIQUE KEY id (id)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Пользователи'
;

START TRANSACTION;
SET @moveid = 1;
INSERT INTO sample.users
  SELECT * FROM shop.users
  WHERE shop.users.id = @moveid
;  
DELETE FROM shop.users WHERE shop.users.id = @moveid LIMIT 1;
COMMIT;

--#1.2

CREATE OR REPLACE VIEW shop.cat AS 
  SELECT p.name AS Product,c.name AS Catalog
  FROM 
  shop.products AS p
  JOIN
  shop.catalogs AS c
  WHERE p.catalog_id = c.id
;

SELECT * FROM shop.cat
;

--#2.1
DELIMITER //
DROP FUNCTION IF EXISTS hello//

CREARE FUNCTION hello(time_ TIME)
RETURN VARCHAR(15) DETERMINISTIC
BEGIN
	DECLARE word VARCHAR(15);
	IF (time_ >= '06:00:00' AND time_ <'12:00:00') THEN SET word = 'Доброе утро!';
	ELSEIF (time_ >= '12:00:00' AND time_ <'18:00:00') THEN SET word = 'Добрый день!';
	ELSEIF (time_ >= '18:00:00' AND time_ <='23:59:59') THEN SET word = 'Добрый вечер!';
	ELSE SET word = 'Доброй ночи!';
	END IF;
RETURN word;
END//

SELECT hello('07:09:56')// 
SELECT hello('4:00:00')// 
SELECT hello('12:00:00')// 
SELECT hello('19:30:00')// 
SELECT hello('17:59:59')// 
DELIMITER ;


--#3.1
DELIMITER //
DROP TRIGGER IF EXISTS desc_and_name_check_before_insert//
CREATE TRIGGER desc_and_name_check_before_insert BEFORE INSERT ON products  
FOR EACH ROW
BEGIN
	IF (NEW.name IS NULL) AND (NEW.description IS NULL)
    	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "products name or description can`t be NULL"; 
  	END IF;
END//

DROP TRIGGER IF EXISTS desc_and_name_check_before_update//
CREATE TRIGGER desc_and_name_check_before_update BEFORE UPDATE ON products 
FOR EACH ROW
BEGIN
  	IF (NEW.name IS NULL) AND (NEW.description IS NULL)
    	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "products name or description can`t be NULL"; 
  	END IF;
END//

DELIMITER ;