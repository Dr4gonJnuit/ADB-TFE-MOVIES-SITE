CREATE TABLE `Series` (
  `serie_id` int(10) PRIMARY KEY,
  `title` varchar(255) NOT NULL COMMENT 'Titre de la série',
  `release_date` date,
  `description` text NOT NULL COMMENT 'Description de la série',
  `image` varchar(255) NOT NULL COMMENT 'URL de l\'image de la série, a besoin de la base de l\'URL de l\'API pour fct'
);

CREATE TABLE `Seasons` (
  `id` int(10) PRIMARY KEY AUTO_INCREMENT,
  `serie_id` int(10) NOT NULL,
  `season_number` int(10) NOT NULL COMMENT 'Numéro de la saison',
  `image` varchar(255) COMMENT 'URL de l\'image de la saison, a besoin de la base de l\'URL de l\'API pour fct'
);

CREATE TABLE `Episodes` (
  `id` int(10) PRIMARY KEY AUTO_INCREMENT,
  `season_id` int(10) NOT NULL,
  `episode_number` int(10) NOT NULL COMMENT 'Numéro de l\'épisode',
  `title` varchar(255) NOT NULL COMMENT 'Titre de l\'épisode',
  `description` text NOT NULL COMMENT 'Description de l\'épisode',
  `image` varchar(255) COMMENT 'URL de l\'image de l\'épisode, a besoin de la base de l\'URL de l\'API pour fct'
);

CREATE TABLE `Genders` (
  `gender_id` int(10) PRIMARY KEY,
  `name` varchar(255) NOT NULL COMMENT 'Nom du genre'
);

CREATE TABLE `SeriesGenders` (
  `serie_id` int(10) NOT NULL,
  `gender_id` int(10) NOT NULL
);

CREATE TABLE `Actors` (
  `actor_id` int(10) PRIMARY KEY,
  `name` varchar(255) NOT NULL COMMENT 'Nom de l\'acteur',
  `image` varchar(255) COMMENT 'URL de l\'image de l\'acteur, a besoin de la base de l\'URL de l\'API pour fct'
);

CREATE TABLE `SeriesActors` (
  `serie_id` int(10) NOT NULL,
  `actor_id` int(10) NOT NULL
);

CREATE TABLE `Users` (
  `user_id` bigint(20) PRIMARY KEY AUTO_INCREMENT COMMENT 'unsigned',
  `name` varchar(255) NOT NULL COMMENT 'Nom d\'utilisateur',
  `first_name` varchar(255) DEFAULT null COMMENT 'Prénom de l\'utilisateur',
  `last_name` varchar(255) DEFAULT null COMMENT 'Nom de famille de l\'utilisateur',
  `gender` ENUM ('Homme', 'Femme', 'Autre') DEFAULT null COMMENT 'Genre de l\'utilisateur',
  `birthdate` date COMMENT 'Date de naissance au format YYYY-MM-DD',
  `country` varchar(50) COMMENT 'Pays d\'origine de l\'utilisateur',
  `email` varchar(255) UNIQUE NOT NULL,
  `email_verified_at` timestamp DEFAULT null,
  `password` varchar(255) NOT NULL COMMENT 'hashed password',
  `remember_token` varchar(100) DEFAULT null,
  `created_at` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` timestamp DEFAULT null
);

CREATE TABLE `Comments` (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT COMMENT 'unsigned',
  `user_id` bigint(20) NOT NULL COMMENT 'unsigned',
  `serie_id` int(10) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` timestamp DEFAULT null,
  `deleted_at` timestamp DEFAULT null
);

CREATE TABLE `Statistiques` (
  `id` int(10) PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT 'unsigned'
);

CREATE TABLE `Favorites` (
  `user_id` bigint(20) NOT NULL COMMENT 'unsigned',
  `serie_id` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `deleted_at` timestamp DEFAULT null,
  PRIMARY KEY (`user_id`, `serie_id`)
);

CREATE TABLE `WatchList` (
  `user_id` bigint(20) NOT NULL COMMENT 'unsigned',
  `serie_id` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `deleted_at` timestamp DEFAULT null,
  PRIMARY KEY (`user_id`, `serie_id`)
);

CREATE TABLE `Watched` (
  `id` int(10) PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT 'unsigned',
  `episode_id` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `deleted_at` timestamp DEFAULT null
);

CREATE TABLE `Ratings` (
  `user_id` bigint(20) NOT NULL COMMENT 'unsigned',
  `serie_id` int(10) NOT NULL,
  `rating` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` timestamp DEFAULT null,
  `deleted_at` timestamp DEFAULT null,
  PRIMARY KEY (`user_id`, `serie_id`)
);

CREATE TABLE `Sessions` (
  `id` varchar(255) PRIMARY KEY,
  `user_id` bigint(20) DEFAULT null COMMENT 'unsigned',
  `ip_address` varchar(45) DEFAULT null,
  `user_agent` text DEFAULT null,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
);

CREATE TABLE `Password_Reset_Tokens` (
  `email` varchar(255) PRIMARY KEY,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp DEFAULT null
);

CREATE TABLE `Migrations` (
  `id` int(10) PRIMARY KEY AUTO_INCREMENT COMMENT 'unsigned',
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
);

CREATE TABLE `Jobs` (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT COMMENT 'unsigned',
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) NOT NULL COMMENT 'unsigned',
  `reserved_at` int(10) DEFAULT null COMMENT 'unsigned',
  `available_at` int(10) NOT NULL COMMENT 'unsigned',
  `created_at` int(10) NOT NULL COMMENT 'unsigned'
);

CREATE TABLE `Jobs_Batches` (
  `id` varchar(255) PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_jobs_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT null,
  `canceled_at` int(11) DEFAULT null,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT null
);

CREATE TABLE `Failed_Jobs` (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT COMMENT 'unsigned',
  `uuid` varchar(255) UNIQUE NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `Cache_Locks` (
  `key` varchar(255) PRIMARY KEY,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
);

CREATE TABLE `Cache` (
  `key` varchar(255) PRIMARY KEY,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
);

ALTER TABLE `Seasons` ADD FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`);

ALTER TABLE `Episodes` ADD FOREIGN KEY (`season_id`) REFERENCES `Seasons` (`id`);

ALTER TABLE `SeriesGenders` ADD FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`);

ALTER TABLE `SeriesGenders` ADD FOREIGN KEY (`gender_id`) REFERENCES `Genders` (`gender_id`);

ALTER TABLE `SeriesActors` ADD FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`);

ALTER TABLE `SeriesActors` ADD FOREIGN KEY (`actor_id`) REFERENCES `Actors` (`actor_id`);

ALTER TABLE `Comments` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

ALTER TABLE `Comments` ADD FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`);

ALTER TABLE `Statistiques` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

ALTER TABLE `Favorites` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

ALTER TABLE `Favorites` ADD FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`);

ALTER TABLE `WatchList` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

ALTER TABLE `WatchList` ADD FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`);

ALTER TABLE `Watched` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

ALTER TABLE `Watched` ADD FOREIGN KEY (`episode_id`) REFERENCES `Episodes` (`id`);

ALTER TABLE `Ratings` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

ALTER TABLE `Ratings` ADD FOREIGN KEY (`serie_id`) REFERENCES `Series` (`serie_id`);

ALTER TABLE `Sessions` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

CREATE UNIQUE INDEX `Comments_index_0` ON `Comments` (`user_id`, `serie_id`);
