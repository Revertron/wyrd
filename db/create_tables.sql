SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE TABLE domains (
  domain varchar(100) NOT NULL,
  owner varchar(40) NOT NULL,
  fallback varchar(40) DEFAULT NULL,
  legacy tinyint(1) NOT NULL DEFAULT 0,
  seen_first bigint(12) NOT NULL,
  seen_down_since bigint(12) NOT NULL DEFAULT 0,
  tags varchar(100) DEFAULT NULL,
  records text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE domains
  ADD UNIQUE KEY domain (domain);
