USE steam;


-- Выбираем игры покупателей 
SELECT 
	p.firstname AS 'Имя', 
	p.lastname AS 'Фамилия', 
	gc.name AS 'Название игры', 
	ug.date_buy AS 'Дата покупки'
FROM users_games ug 
	JOIN Users u ON u.id = ug.users_id
	JOIN Profiles p ON p.users_id = u.id
	JOIN Game_Catalog gc ON gc.id = ug.game_catalog_id
	ORDER BY ug.date_buy; 


-- Кто кому написал больше сообщений 
SELECT 
	COUNT(m.from_users_id) AS cnt,
	p1.firstname AS 'Кто написал',
	p2.firstname AS 'Кому написал'
FROM messages m
	JOIN profiles p1 ON p1.users_id = m.from_users_id
	JOIN profiles p2 ON p2.users_id = m.to_users_id
GROUP BY m.from_users_id 
ORDER BY cnt DESC
LIMIT 1; 	


-- Какие есть Экшен игры в каталоге 
SELECT 
	gc.name AS 'Название игры', 
	gg.ganres AS 'Жанр',
	gc.release_date AS 'Дата выхода', 
	gc.price AS 'Цена'
FROM game_catalog gc 
	JOIN games_genres gg ON gg.id = gc.games_genres_id 
WHERE gg.ganres = 'Экшены'; 


-- Количество игр по жанрам
SELECT 
	COUNT(gc.games_genres_id) AS 'Количество',  
	gg.ganres AS 'Жанр'
FROM game_catalog gc 
	JOIN games_genres gg ON gg.id = gc.games_genres_id 
GROUP BY gc.games_genres_id


-- Какие игры поступили в оплату
SELECT 
	b.id AS 'Номер чека', 
	gc.name AS 'Название игры', 
	gc.price AS 'Цена'
FROM payment p 
	JOIN basket b ON b.id = p.id 
	JOIN game_catalog gc ON b.id = gc.id 
ORDER BY b.id 

-- Выборка данных по пользователю id = 1
SELECT 
	u.login AS 'Логин',
	CONCAT(p.firstname, ' ', p.lastname) AS 'Имя Фамилия',
	gc.name AS 'Название игр'
FROM users u 
	JOIN profiles p ON p.users_id = u.id 
	JOIN users_games ug ON u.id = ug.id 
	JOIN game_catalog gc ON gc.id = ug.id 
WHERE u.id = 1









