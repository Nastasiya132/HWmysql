use vk;

SELECT (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = from_user_id) AS friend,
  COUNT(*) AS total_messages 
  FROM messages INNER JOIN (SELECT friend_id AS id 
                             FROM friendship 
                             --  WHERE user_id = 52
                             UNION
                             SELECT user_id AS id 
                             FROM friendship 
                             -- WHERE friend_id = 52
                             ) as users
  ON messages.from_user_id = users.id 
  WHERE to_user_id = 53 
  GROUP BY messages.from_user_id
  ORDER BY total_messages DESC;
  
SELECT SUM(likes_per_user) AS likes_total 
FROM ( 
      SELECT COUNT(*) AS likes_per_user 
      FROM likes INNER JOIN (SELECT user_id 
                             FROM profiles 
                             ORDER BY birthday 
                             DESC LIMIT 10
							) AS sorted_profiles 
      WHERE target_type_id = 3
        AND target_id = sorted_profiles.user_id 
      GROUP BY target_id
) AS counted_likes;

SELECT users.id, CONCAT(first_name, ' ', last_name) AS name, (COUNT(posts.id) + COUNT(likes.id) + COUNT(messages.id)) AS activity FROM users
	LEFT JOIN posts
	 	ON users.id = posts.user_id
	LEFT JOIN likes
		ON users.id = likes.user_id 
	LEFT JOIN messages
		ON users.id = messages.from_user_id
	GROUP BY users.id 
	ORDER BY activity
	LIMIT 10;