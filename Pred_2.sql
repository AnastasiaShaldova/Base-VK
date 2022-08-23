-- Покупатели игр (Получаем покупателя, данные, какую игру купили и когда)

USE steam;
DROP VIEW IF EXISTS pokupateli_igr; 
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `steam`.`pokupateli_igr` AS
    SELECT 
    	`u`.`login` AS `Login`, 
    	CONCAT(`p`.`firstname`, ' ', `p`.`lastname`) AS 'Имя Фамилия', 
        `gc`.`name` AS `Name_Game_Catalog`,
        `gc`.`release_date` AS `Release_Date`, 
        `b`.`purchase_date` AS `Дата покупки`
		
    FROM
        ((((`steam`.`users_games` `ug`
        LEFT JOIN `steam`.`users` `u` ON `u`.`id` = `ug`.`users_id`)
        LEFT JOIN `steam`.`profiles` `p` ON `p`.`users_id` = `u`.`id`)
        LEFT JOIN `steam`.`game_catalog` `gc` ON `gc`.`id` = `ug`.`game_catalog_id`)
        LEFT JOIN `steam`.`basket` `b` ON `b`.`id` = `ug`.`game_catalog_id`)
        
SELECT * FROM pokupateli_igr; 