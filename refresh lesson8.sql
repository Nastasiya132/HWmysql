USE vk;

--#1


SELECT 
	(SELECT CONCAT_WS(' ', first_name, last_name) FROM users u2 WHERE id = from_user_id) AS User , COUNT(from_user_id) AS Num_messages 
		FROM messages m JOIN 
			(SELECT user_id AS id FROM friendship f2 WHERE friend_id = 10 AND status_id = 3
			UNION
			SELECT friend_id AS id FROM friendship WHERE user_id = 10 AND status_id = 3) AS Fr
		ON m.to_user_id = Fr.id OR m.from_user_id = Fr.id
		GROUP BY from_user_id
		ORDER BY Num_messages DESC
		LIMIT 1;
	
--#2

SELECT CONCAT_WS(' ', first_name, last_name) AS User_name FROM users u2 
	JOIN
		(SELECT sp.id, COUNT(*) AS Total_likes
		FROM likes l
		JOIN 
			(SELECT user_id AS id FROM profiles p2 ORDER BY birthday DESC) AS sp
		ON l.target_id = sp.id		
		GROUP BY target_id
		ORDER BY Total_likes DESC
		LIMIT 10) AS us
	ON u2.id = us.id;

--#3

SELECT CASE(gender)
		WHEN 'm' THEN 'man'
		WHEN 'f' THEN 'woman'
	END AS sex, COUNT(*) AS Total_likes FROM likes l2 JOIN
	profiles p2
	ON l2.user_id = p2.user_id
	GROUP BY gender
	ORDER BY Total_likes DESC;

--#4

SELECT 
	CONCAT_WS(' ', first_name, last_name) AS user,
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = u2.id) +
	(SELECT COUNT(*) FROM  media WHERE media.user_id = u2.id) +
	(SELECT COUNT(*) FROM messages m2 WHERE m2.from_user_id = u2.id)
	AS Overall_activity
	FROM users u2
	ORDER BY Overall_activity
	LIMIT 10;

