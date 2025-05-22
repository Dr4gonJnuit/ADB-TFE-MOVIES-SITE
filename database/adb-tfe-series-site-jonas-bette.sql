CREATE DATABASE IF NOT EXISTS `adb_tfe_movies_site` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE `adb_tfe_movies_site`;

-- The following tables are used for the website functionality.
-- The tables Series, Seasons, Episodes, Genres, Series_Genres, Actors, Serie_Cast, Episodes_Cast, Production_Companies and Series_Production_Companies
-- will be filled with data from the TMDB API.

CREATE TABLE IF NOT EXISTS `Series` (
    `serie_id` int(32) PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `status` VARCHAR(255),
    `nbr_of_seasons` int(32),
    `nbr_of_episodes` int(32),
    `release_date` DATE,
    `description` TEXT,
    `image_url` VARCHAR(255),
    `homepage` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `Seasons` (
    `season_id` int(32) PRIMARY KEY,
    `serie_id` int(32) NOT NULL,
    `season_number` int(32),
    `description` TEXT,
    `image_url` VARCHAR(255),
    FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`)
);

CREATE TABLE IF NOT EXISTS `Episodes` (
    `episode_id` int(32) PRIMARY KEY,
    `season_id` int(32) NOT NULL,
    `episode_number` int(32),
    `title` VARCHAR(255),
    `description` TEXT,
    `image_url` VARCHAR(255),
    FOREIGN KEY (`season_id`) REFERENCES `Seasons` (`season_id`)
);

CREATE TABLE IF NOT EXISTS `Genres` (
    `genre_id` int(32) PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Series_Genres` (
    `serie_id` int(32) NOT NULL,
    `genre_id` int(32) NOT NULL,
    PRIMARY KEY (`serie_id`, `genre_id`),
    FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`),
    FOREIGN KEY (`genre_id`) REFERENCES `Genres` (`genre_id`)
);

CREATE TABLE IF NOT EXISTS `Actors` (
    `actor_id` int(32) PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `image_url` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `Serie_Cast` (
    `serie_id` int(32) NOT NULL,
    `actor_id` int(32) NOT NULL,
    `character_name` VARCHAR(255),
    PRIMARY KEY (`serie_id`, `actor_id`),
    FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`),
    FOREIGN KEY (`actor_id`) REFERENCES `Actors` (`actor_id`)
);

CREATE TABLE IF NOT EXISTS `Episodes_Cast` (
    `episode_id` int(32) NOT NULL,
    `actor_id` int(32) NOT NULL,
    PRIMARY KEY (`episode_id`, `actor_id`),
    FOREIGN KEY (`episode_id`) REFERENCES `Episodes` (`episode_id`),
    FOREIGN KEY (`actor_id`) REFERENCES `Actors` (`actor_id`)
);

CREATE TABLE IF NOT EXISTS `Production_Companies` (
    `id` int(32) PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `logo_path` VARCHAR(255),
    `origin_country` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `Series_Production_Companies` (
    `serie_id` int(32) NOT NULL,
    `company_id` int(32) NOT NULL,
    PRIMARY KEY (`serie_id`, `company_id`),
    FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`),
    FOREIGN KEY (`company_id`) REFERENCES `Production_Companies` (`id`)
);

CREATE TABLE IF NOT EXISTS `Users` (
    `user_id` bigint(20) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `first_name` varchar(255) DEFAULT NULL,
    `last_name` varchar(255) DEFAULT NULL,
    `gender` ENUM('Homme', 'Femme', 'Autre') DEFAULT NULL,
    `birthdate` DATE,
    `country` varchar(50),
    `email` varchar(255) UNIQUE NOT NULL,
    `email_verified_at` TIMESTAMP DEFAULT NULL,
    `password` varchar(255) NOT NULL,
    `remember_token` varchar(100) DEFAULT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT(CURRENT_TIMESTAMP),
    `updated_at` TIMESTAMP DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `Comments` (
    `id` bigint(20) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `user_id` bigint(20) UNSIGNED NOT NULL,
    `serie_id` int(10) NOT NULL,
    `comment` text NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT(CURRENT_TIMESTAMP),
    `updated_at` TIMESTAMP DEFAULT NULL,
    `deleted_at` TIMESTAMP DEFAULT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
    FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`),
    UNIQUE INDEX `Comments_index_0` (`user_id`, `serie_id`)
);

CREATE TABLE IF NOT EXISTS `Statistiques` (
    `id` int(10) PRIMARY KEY AUTO_INCREMENT,
    `user_id` bigint(20) UNSIGNED NOT NULL,
    `nbr_of_favorites` int(10) NOT NULL DEFAULT 0,
    `nbr_of_watchlist` int(10) NOT NULL DEFAULT 0,
    `nbr_of_watched` int(10) NOT NULL DEFAULT 0,
    `nbr_of_comments` int(10) NOT NULL DEFAULT 0,
    `nbr_of_ratings` int(10) NOT NULL DEFAULT 0,
    FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`)
);

CREATE TABLE IF NOT EXISTS `Favorites` (
    `user_id` bigint(20) UNSIGNED NOT NULL,
    `serie_id` int(10) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT(CURRENT_TIMESTAMP),
    `deleted_at` TIMESTAMP DEFAULT NULL,
    PRIMARY KEY (`user_id`, `serie_id`),
    FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
    FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`)
);

CREATE TABLE IF NOT EXISTS `WatchList` (
    `user_id` bigint(20) UNSIGNED NOT NULL,
    `serie_id` int(10) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT(CURRENT_TIMESTAMP),
    `deleted_at` TIMESTAMP DEFAULT NULL,
    PRIMARY KEY (`user_id`, `serie_id`),
    FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
    FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`)
);

CREATE TABLE IF NOT EXISTS `Watched` (
    `id` int(10) PRIMARY KEY AUTO_INCREMENT,
    `user_id` bigint(20) UNSIGNED NOT NULL,
    `episode_id` int(10) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT(CURRENT_TIMESTAMP),
    `deleted_at` TIMESTAMP DEFAULT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
    FOREIGN KEY (`episode_id`) REFERENCES `Episodes` (`episode_id`)
);

CREATE TABLE IF NOT EXISTS `Ratings` (
    `user_id` bigint(20) UNSIGNED NOT NULL,
    `serie_id` int(10) NOT NULL,
    `rating` int(11) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT(CURRENT_TIMESTAMP),
    `updated_at` TIMESTAMP DEFAULT NULL,
    `deleted_at` TIMESTAMP DEFAULT NULL,
    PRIMARY KEY (`user_id`, `serie_id`),
    FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
    FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`)
);

CREATE TABLE IF NOT EXISTS `Sessions` (
    `id` varchar(255) PRIMARY KEY,
    `user_id` bigint(20) UNSIGNED DEFAULT NULL,
    `ip_address` varchar(45) DEFAULT NULL,
    `user_agent` text DEFAULT NULL,
    `payload` longtext NOT NULL,
    `last_activity` int(11) NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`)
);

--  The following tables are used for Laravel's built-in features
--  such as password resets, migrations, jobs, and cache.
--  These tables are not directly related to the website functionality.

CREATE TABLE IF NOT EXISTS `Password_Reset_Tokens` (
    `email` varchar(255) PRIMARY KEY,
    `token` varchar(255) NOT NULL,
    `created_at` TIMESTAMP DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `Migrations` (
    `id` int(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `migration` varchar(255) NOT NULL,
    `batch` int(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Jobs` (
    `id` bigint(20) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `queue` varchar(255) NOT NULL,
    `payload` longtext NOT NULL,
    `attempts` tinyint(3) UNSIGNED NOT NULL,
    `reserved_at` int(10) UNSIGNED DEFAULT NULL,
    `available_at` int(10) UNSIGNED NOT NULL,
    `created_at` int(10) UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS `Jobs_Batches` (
    `id` varchar(255) PRIMARY KEY,
    `name` varchar(255) NOT NULL,
    `total_jobs` int(11) NOT NULL,
    `pending_jobs` int(11) NOT NULL,
    `failed_jobs` int(11) NOT NULL,
    `failed_jobs_ids` longtext NOT NULL,
    `options` mediumtext DEFAULT NULL,
    `canceled_at` int(11) DEFAULT NULL,
    `created_at` int(11) NOT NULL,
    `finished_at` int(11) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `Failed_Jobs` (
    `id` bigint(20) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `uuid` varchar(255) UNIQUE NOT NULL,
    `connection` text NOT NULL,
    `queue` text NOT NULL,
    `payload` longtext NOT NULL,
    `exception` longtext NOT NULL,
    `failed_at` TIMESTAMP DEFAULT(CURRENT_TIMESTAMP)
);

CREATE TABLE IF NOT EXISTS `Cache_Locks` (
    `key` varchar(255) PRIMARY KEY,
    `owner` varchar(255) NOT NULL,
    `expiration` int(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Cache` (
    `key` varchar(255) PRIMARY KEY,
    `value` mediumtext NOT NULL,
    `expiration` int(11) NOT NULL
);
