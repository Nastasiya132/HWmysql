use vk;

--#1

CREATE INDEX messages_created_at_idx ON messages(created_at);

CREATE INDEX media_updated_at_idx ON media(updated_at);

CREATE INDEX posts_updated_at_idx ON posts(updated_at);

--#2

SELECT DISTINCT communities.name,
  AVG(communities_users.user_id) OVER (PARTITION BY communities_users.community_id) AS Ave_users_in_Group,
  MAX(profiles.birthday) OVER (PARTITION BY communities_users.community_id) AS Yangest,
  MIN(profiles.birthday) OVER (PARTITION BY communities_users.community_id) AS Oldest,
  COUNT(profiles.birthday) OVER (PARTITION BY communities_users.community_id) AS Num_users,
  COUNT(profiles.birthday) OVER (PARTITION BY communities_users.community_id) / COUNT(users.id) OVER() * 100 AS "%%"
  FROM communities
    JOIN communities_users
      ON communities.id = communities_users.community_id
    LEFT JOIN users
      ON communities_users.user_id = users.id
    JOIN profiles
      ON users.id = profiles.user_id;
