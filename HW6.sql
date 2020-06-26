use vk;

--#1

ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_users_id_fk
  FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE;
    
ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_community_id_fk
  FOREIGN KEY (community_id) REFERENCES communities(id)
    ON DELETE CASCADE;
    
   
ALTER TABLE media MODIFY COLUMN media_type_id INT UNSIGNED;

ALTER TABLE media
  ADD CONSTRAINT media_media_types_id_fk
  FOREIGN KEY (media_type_id) REFERENCES media_types(id)
    ON DELETE SET NULL;
    
ALTER TABLE media MODIFY COLUMN user_id INT UNSIGNED;

ALTER TABLE media
  ADD CONSTRAINT media_users_id_fk
  FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE SET NULL;

ALTER TABLE posts
  ADD CONSTRAINT posts_users_id_fk
  FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE;

ALTER TABLE posts
  ADD CONSTRAINT posts_community_id_fk
  FOREIGN KEY (community_id) REFERENCES communities(id)
    ON DELETE CASCADE;

ALTER TABLE posts
  ADD CONSTRAINT posts_media_id_fk
  FOREIGN KEY (media_id) REFERENCES media(id)
    ON DELETE SET NULL;

ALTER TABLE likes
  ADD CONSTRAINT likes_users_id_fk
  FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE;

ALTER TABLE likes
  ADD CONSTRAINT likes_target_type_id_fk
  FOREIGN KEY (target_type_id) REFERENCES target_types(id)
    ON DELETE CASCADE;

ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk
  FOREIGN KEY (from_user_id) REFERENCES users(id)
    ON DELETE CASCADE;

ALTER TABLE messages
  ADD CONSTRAINT messages_to_user_id_fk
  FOREIGN KEY (to_user_id) REFERENCES users(id)
    ON DELETE CASCADE;

ALTER TABLE friendship MODIFY COLUMN status_id INT UNSIGNED;

ALTER TABLE friendship
  ADD CONSTRAINT friendship_status_id_fk
  FOREIGN KEY (status_id) REFERENCES friendship_statuses(id)
    ON DELETE SET NULL;

ALTER TABLE friendship
  ADD CONSTRAINT friendship_user_id_fk
  FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE;

ALTER TABLE friendship
  ADD CONSTRAINT friendship_friend_id_fk
  FOREIGN KEY (friend_id) REFERENCES users(id)
    ON DELETE CASCADE;
    
 --#2
 
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
); 
 
DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');
 
INSERT INTO likes 
  SELECT 
    id, 
    FLOOR(1 + (RAND() * 300)), 
    FLOOR(1 + (RAND() * 300)),
    FLOOR(1 + (RAND() * 4)),
    CURRENT_TIMESTAMP 
  FROM messages; 
 
 SELECT COUNT(*) FROM posts;
   
SELECT * FROM likes LIMIT 10; 

DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  community_id INT UNSIGNED,
  head VARCHAR(255),
  body TEXT NOT NULL,
  media_id INT UNSIGNED,
  is_public BOOLEAN DEFAULT TRUE,
  is_archived BOOLEAN DEFAULT FALSE,
  views_counter INT UNSIGNED DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

	--#3

DESC likes;

SELECT (SELECT gender FROM profiles WHERE user_id = likes.user_id) AS Пол,
       COUNT(user_id) AS Лайков 
    FROM likes GROUP BY Пол;
   
SELECT 'Мужчины' AS Пол,
        COUNT(user_id) AS Лайков 
        FROM likes WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'm')
UNION
SELECT 'Женщины' AS Пол,
        COUNT(user_id) AS Лайков 
        FROM likes WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'w');

       --#4
DESC profiles;

SELECT 	user_id, 
        (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE users.id = profiles.user_id) AS Name,
        (SELECT COUNT(id) FROM likes WHERE likes.user_id = profiles.user_id) AS Likes
	FROM profiles
	ORDER BY birthday DESC
	LIMIT 10;       

	--#5
	
SELECT 	id, 
		CONCAT(first_name, ' ', last_name) AS Name,
		(SELECT COUNT(*) FROM posts WHERE user_id = users.id)
		+
		(SELECT COUNT(*) FROM likes WHERE user_id = users.id)
		+
		(SELECT COUNT(*) FROM messages WHERE from_user_id = users.id) AS Activity
	FROM users
	ORDER BY Activity
	LIMIT 10;       
       
       
       
       
       
       
       
       
       
   
   