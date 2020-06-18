use vk;

select * from messages limit 10;
update messages set from_user_id = FLOOR(1 + RAND() * 100),
to_user_id = FLOOR(1 + RAND() * 100),
madia_id = FLOOR(1 + RAND() * 100);

select * from messages limit 10;

desc messages ;

alter table messages change madia_id media_id int(10) unsigned;

SELECT media;
desc media;
SELECT  * FROM media limit 10;

SELECT * FROM media_types;

update media set user_id = FLOOR(1 + RAND() * 100);

CREATE temporary table extensions (name varchar(50));

insert into extensions values ('jpeg'), ('avi'), ('mp3'), ('png');

UPDATE media set filename = concat (
'http://dropbox.net/vk/',
filename,
'.',
(SELECT  name FROM extensions order by rand () limit 1));

update media set size = FLOOR(10000 + RAND() * 10000) where size < 1000;


UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');  

ALTER TABLE media MODIFY COLUMN metadata JSON;

SELECT * from media;

select * from media_types;

DELETE from media_types ;

insert into media_types (name) values
('photo'),
('video'),
('audio');

TRUNCATE media_types;

UPDATE media set media_type_id = FLOOR(1 + RAND() * 3); 

show tables;

DESC friendship;

SELECT * FROM friendship LIMIT 10;

SELECT * from friendship_statuses;

INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');

update friendship set user_id = FLOOR(1 + RAND() * 100),
friend_id = FLOOR(1 + RAND() * 100),
status_id = FLOOR(1 + RAND() * 3);



 










 
 
 
 











