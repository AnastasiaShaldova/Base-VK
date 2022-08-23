-- Информация об играх (номер игры, название, какой жанр, разработчик, дата выхода игры, и какие системные требования нужны для игры.)

USE steam;
DROP VIEW IF EXISTS kakie_est_igry; 
CREATE 
	ALGORITHM = UNDEFINED 
	DEFINER = `root`@`localhost` 
	SQL SECURITY DEFINER
VIEW `steam`.`kakie_est_igry` AS
	SELECT 
		`gc`.`id` AS `ID`,
		`gc`.`name` AS `Название игры`,
		`gc`.`release_date` AS `Дата выхода`,
		`gg`.`ganres` AS `Жанр`,
		`d`.`name` AS `Разработчик`,
		`sr`.`operating_system` AS `Системные требования`,
		`sr`.`CPU` AS `CPU`,
		`sr`.`video_card` AS `Видеокарта`
	FROM
		(((`steam`.`game_catalog` `gc`
		LEFT JOIN `steam`.`games_genres` `gg` ON ((`gg`.`id` = `gc`.`games_genres_id`)))
		LEFT JOIN `steam`.`developer` `d` ON ((`d`.`id` = `gc`.`developer_id`)))
		LEFT JOIN `steam`.`system_requirements` `sr` ON ((`sr`.`id` = `gc`.`system_requirements_id`)))
        
SELECT * FROM kakie_est_igry; 