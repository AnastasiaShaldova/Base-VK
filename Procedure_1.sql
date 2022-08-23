-- Заполнение данных из разных таблиц по id 

CREATE PROCEDURE steam.proc_1(IN id_game_catalog INT)
BEGIN
	DECLARE game_catalog_name TEXT;
	DECLARE genres_name VARCHAR(50);
	DECLARE developer_name VARCHAR(50);
	SELECT  	
		g.name, d.name, gg.ganres into game_catalog_name, developer_name, genres_name 
	FROM game_catalog g
		LEFT JOIN developer d ON d.id = g.developer_id
		LEFT JOIN games_genres gg ON gg.id = g.games_genres_id
	WHERE g.id = id_game_catalog;
	UPDATE game_catalog 
	SET desription = CONCAT('Игра: ', game_catalog_name, ' Жанр: ', genres_name, ' Разраб. :', developer_name)
	WHERE id = id_game_catalog;
END; 

CALL proc_1(3);
SELECT * FROM game_catalog WHERE id = 3; 
