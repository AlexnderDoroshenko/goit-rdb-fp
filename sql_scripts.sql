#1)
CREATE SCHEMA IF NOT EXISTS pandemic;
USE pandemic;
#data imported from csv into infectious_cases table
SELECT * FROM infectious_cases LIMIT 10;

#2)
#Create tables
DROP TABLE IF EXISTS infectious_fact;
DROP TABLE IF EXISTS location;
CREATE TABLE location (
    id INT AUTO_INCREMENT PRIMARY KEY,
    entity VARCHAR(255),
    code VARCHAR(20),
    UNIQUE(entity, code)
);

CREATE TABLE infectious_fact (
    id INT AUTO_INCREMENT PRIMARY KEY,
    location_id INT,
    year INT,
    number_rabies        FLOAT,
    number_malaria       FLOAT,
    number_hiv           FLOAT,
    number_tuberculosis  FLOAT,
    number_yaws          FLOAT,
    polio_cases          FLOAT,
    cases_guinea_worm    FLOAT,
    number_smallpox      FLOAT,
    number_cholera_cases FLOAT,
    FOREIGN KEY (location_id) REFERENCES location(id)
);

#insert data into tables from infectious_cases
SELECT COUNT(*) as infectious_cases_count FROM infectious_cases;
INSERT INTO location (entity, code)
SELECT DISTINCT Entity, Code
FROM infectious_cases;
INSERT INTO infectious_fact (
    location_id, year,
    number_rabies, number_malaria, number_hiv,
    number_tuberculosis, number_yaws,
    polio_cases, cases_guinea_worm,
    number_smallpox, number_cholera_cases
)
SELECT
    l.id,
    ic.Year,
    NULLIF(ic.Number_rabies, ''),
    NULLIF(ic.Number_malaria, ''),
    NULLIF(ic.Number_hiv, ''),
    NULLIF(ic.Number_tuberculosis, ''),
    NULLIF(ic.Number_yaws, ''),
    NULLIF(ic.polio_cases, ''),
    NULLIF(ic.cases_guinea_worm, ''),
    NULLIF(ic.Number_smallpox, ''),
    NULLIF(ic.Number_cholera_cases, '')
FROM infectious_cases ic
JOIN location l
  ON ic.Entity = l.entity AND ic.Code = l.code;
SELECT COUNT(*)  as infectious_fact_count FROM infectious_fact;

#3)
SELECT
    l.entity,
    l.code,
    ROUND(AVG(f.number_rabies), 2) AS avg_rabies,
    MIN(f.number_rabies) AS min_rabies,
    MAX(f.number_rabies) AS max_rabies,
    SUM(f.number_rabies) AS sum_rabies
FROM infectious_fact f
JOIN location l ON f.location_id = l.id
WHERE f.number_rabies IS NOT NULL
GROUP BY l.entity, l.code
ORDER BY avg_rabies DESC
LIMIT 10;

#4)
use pandemic;
SELECT
    year,
    STR_TO_DATE(CONCAT(year, '-01-01'), '%Y-%m-%d') AS start_of_year,
    CURRENT_DATE() AS cur_date,
    TIMESTAMPDIFF(YEAR, STR_TO_DATE(CONCAT(year, '-01-01'), '%Y-%m-%d'), CURRENT_DATE()) AS year_diff
FROM infectious_fact;

#5)
# function creation
DROP FUNCTION IF EXISTS year_diff;

DELIMITER //

CREATE FUNCTION year_diff(input_year INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE start_date DATE;
    SET start_date = STR_TO_DATE(CONCAT(input_year, '-01-01'), '%Y-%m-%d');
    RETURN TIMESTAMPDIFF(YEAR, start_date, CURRENT_DATE());
END;
//

DELIMITER ;
# function usage example
SELECT
    year,
    year_diff(year) AS year_difference
FROM infectious_fact;
