-- ============================================================
-- base.sql - Script de creation et donnees de test
-- Base : db_test
-- ============================================================

CREATE DATABASE IF NOT EXISTS db_test
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE db_test;

-- ------------------------------------------------------------
-- Table personne (creee automatiquement par hibernate.hbm2ddl.auto=update,
-- mais on la cree ici explicitement pour un test independant du framework)
-- ------------------------------------------------------------
DROP TABLE IF EXISTS personne;

CREATE TABLE personne (
    id BIGINT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- Donnees de test
-- ------------------------------------------------------------
INSERT INTO personne (nom, prenom, email) VALUES
    ('Rakoto', 'Jean', 'jean.rakoto@example.mg'),
    ('Rasoa', 'Marie', 'marie.rasoa@example.mg'),
    ('Randria', 'Paul', 'paul.randria@example.mg'),
    ('Andria', 'Sophie', 'sophie.andria@example.mg'),
    ('Ravelo', 'Luc', 'luc.ravelo@example.mg');

    DROP TABLE IF EXISTS employee;

CREATE TABLE employee (
    id BIGINT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- Verification
-- ------------------------------------------------------------
SELECT * FROM personne;