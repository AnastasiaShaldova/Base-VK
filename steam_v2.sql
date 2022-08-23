/* Суть проекта Steam - упрощенная модель интернет-магазина компьютерных игр.
Пользователи могут писать друг другу сообщения, просматривать каталог игр, покупать игры. */ 


DROP DATABASE IF EXISTS steam;
CREATE DATABASE steam;
USE steam;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	login VARCHAR(100) UNIQUE COMMENT 'Имя покупателя',
	password_hash VARCHAR(20), 
	is_delete BIT(1), 
	INDEX idx_login_users(login)
) COMMENT = 'Пользователь';


DROP TABLE IF EXISTS profiles; 
CREATE TABLE profiles (
	users_id BIGINT UNSIGNED NOT NULL UNIQUE, 
	firstname VARCHAR(50),
	lastname VARCHAR(50), 
	phone BIGINT UNSIGNED UNIQUE,
	gender CHAR(1), 
	birthday DATE, 
	photo_id BIGINT UNSIGNED NULL, 
	created_at DATETIME DEFAULT NOW(), 
	FOREIGN KEY (users_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT = 'Данные пользователя';


-- сообщения между пользователями
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL,
	from_users_id BIGINT UNSIGNED NOT NULL,
	to_users_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	created_at DATETIME DEFAULT NOW(),
	FOREIGN KEY (from_users_id) REFERENCES users(id),
	FOREIGN KEY (to_users_id) REFERENCES users(id)
) COMMENT = 'Сообщения пользователей';


DROP TABLE IF EXISTS developer;
CREATE TABLE developer (
	id SERIAL PRIMARY KEY, 
	name VARCHAR(100)
) COMMENT = 'Разработчик';


DROP TABLE IF EXISTS media;
CREATE TABLE media (
	id SERIAL,
	filename VARCHAR(255),
	size INT, 
	metadata JSON,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
)  COMMENT = 'Медиа';

-- Системные требования
DROP TABLE IF EXISTS system_requirements; 
CREATE TABLE system_requirements (
	id SERIAL PRIMARY KEY, 
	operating_system VARCHAR(255)  COMMENT 'Операционная система', 
	CPU VARCHAR(255)  COMMENT 'Процессор', 
	RAM VARCHAR(255)  COMMENT 'Оперативная память', 
	video_card VARCHAR(255)  COMMENT 'Видеокарта', 
	DirectX VARCHAR(255)  COMMENT 'Версия DirectX', 
	disk_space VARCHAR(255) COMMENT 'Место на диске'
) COMMENT = 'Системные требования для игр'; 

DROP TABLE IF EXISTS games_genres;
CREATE TABLE games_genres (
	id SERIAL PRIMARY KEY,
	ganres VARCHAR(255)
) COMMENT = 'Жанры'; 

DROP TABLE IF EXISTS game_catalog;
CREATE TABLE game_catalog (
	id SERIAL PRIMARY KEY,
	media_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(255), 
	desription TEXT, 
	release_date DATE COMMENT 'Дата выхода', 
	games_genres_id BIGINT UNSIGNED NOT NULL COMMENT 'Жанр',
	developer_id BIGINT UNSIGNED NOT NULL COMMENT 'Разработчик',  
	system_requirements_id BIGINT UNSIGNED NOT NULL, 
	price FLOAT UNSIGNED NOT NULL, 
	FOREIGN KEY (games_genres_id) REFERENCES games_genres(id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (developer_id) REFERENCES developer(id) ON UPDATE CASCADE ON DELETE RESTRICT, 
	FOREIGN KEY (system_requirements_id) REFERENCES system_requirements(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT = 'Каталог игр'; 

DROP TABLE IF EXISTS payment; 
CREATE TABLE payment ( 
	id SERIAL,
	card_number BIGINT UNSIGNED, 
	holder_name VARCHAR (255), 
	validity TIMESTAMP(4), 
	CVV INT(3)
) COMMENT = 'Оплата';

-- Корзина для покупок
DROP TABLE IF EXISTS basket;
CREATE TABlE basket(
	id BIGINT UNSIGNED NOT NULL, 
	payment_id BIGINT UNSIGNED NOT NULL, 
	users_id BIGINT UNSIGNED NOT NULL,
	game_catalog_id BIGINT UNSIGNED NOT NULL,
	purchase_date DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id, payment_id), 
	FOREIGN KEY (users_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (game_catalog_id) REFERENCES game_catalog(id) ON UPDATE CASCADE ON DELETE RESTRICT, 
	FOREIGN KEY (payment_id) REFERENCES payment(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT = 'Корзина'; 

DROP TABLE IF EXISTS users_games;
CREATE TABLE users_games (
	id SERIAL PRIMARY KEY,
	users_id BIGINT UNSIGNED NOT NULL,
	game_catalog_id BIGINT UNSIGNED NOT NULL,
	date_buy DATETIME DEFAULT NOW(),
	FOREIGN KEY (users_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (game_catalog_id) REFERENCES game_catalog(id) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT = 'Игры пользователя';
















