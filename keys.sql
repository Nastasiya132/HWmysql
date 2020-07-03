use vk;

ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;

ALTER TABLE profiles DROP FOREIGN KEY profiles_user_id_fk;
ALTER TABLE profiles MODIFY COLUMN photo_id INT(10) UNSIGNED;
      

DESC messages;

ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);


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
    
   