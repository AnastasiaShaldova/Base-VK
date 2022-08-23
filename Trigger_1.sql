-- Записывает даты сообщений для выбранного пользователя. Если параметр задеть с отрицательным числом, например (-5), то можно увидеть все сообщения написанные 5 дней назад

USE steam;

DROP TRIGGER IF EXISTS messages_BEFORE_INSERT; 
DELIMITER //
CREATE TRIGGER messages_BEFORE_INSERT AFTER INSERT ON messages
FOR EACH ROW
BEGIN 
	INSERT INTO messages SET created_at = NOW();
END; 
DELIMITER ; 















