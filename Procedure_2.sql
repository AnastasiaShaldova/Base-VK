-- Определение пола по имени
USE steam; 

CREATE PROCEDURE steam.proc_2 (IN users_id_in INT)
BEGIN
	DECLARE last_symbol TEXT;
	SELECT 	
		IF(RIGHT(firstname, 1) ='a','f', 'm') INTO last_symbol FROM profiles
	WHERE users_id = users_id_in; 
	UPDATE steam.profiles SET gender = last_symbol WHERE users_id = users_id_in;
END; 

CALL proc_2(2); 
SELECT * FROM profiles WHERE users_id = 2; 
