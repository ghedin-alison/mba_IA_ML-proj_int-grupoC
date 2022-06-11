-- alterar schema professor para o schema do grupo
-- Credit to http://www.dwhworld.com/2010/08/date-dimension-sql-scripts-mysql/
SET SQL_SAFE_UPDATES=0;

-- Small-grupoc.numbers table
DROP TABLE IF EXISTS grupoc.z_numbers_small;
CREATE TABLE grupoc.z_numbers_small (number INT);
INSERT INTO grupoc.z_numbers_small VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);

-- Main-grupoc.numbers table
DROP TABLE IF EXISTS grupoc.z_numbers;
CREATE TABLE grupoc.z_numbers (number BIGINT);
INSERT INTO grupoc.z_numbers
SELECT thousands.number * 1000 + hundreds.number * 100 + tens.number * 10 + ones.number
FROM grupoc.z_numbers_small thousands, grupoc.z_numbers_small hundreds, grupoc.z_numbers_small tens, grupoc.z_numbers_small ones
LIMIT 1000000;

-- Create Date Dimension table
DROP TABLE IF EXISTS grupoc.dw_dm_data;
CREATE TABLE grupoc.dw_dm_data (
  sk_dm_data int DEFAULT NULL,
  dia date DEFAULT NULL,
  mes int DEFAULT NULL,
  semestre int DEFAULT NULL,
  trimestre int DEFAULT NULL,
  ano int DEFAULT NULL,
  feriado tinyint DEFAULT NULL,
  dia_util tinyint DEFAULT NULL,
  dia_semana varchar(20) DEFAULT NULL,
  quinto_dia_util tinyint DEFAULT NULL,
UNIQUE KEY dia (dia));

-- First populate with ids and Date
-- Change year start and end to match your needs. The above sql creates records for year 2010.
INSERT INTO grupoc.dw_dm_data (sk_dm_data, dia)
SELECT number, DATE_ADD( '2014-01-01', INTERVAL number DAY )
FROM grupoc.z_numbers
WHERE DATE_ADD( '2014-01-01', INTERVAL number DAY ) BETWEEN '2014-01-01' AND '2024-12-31'
ORDER BY number;

-- Update other columns based on the date.
UPDATE grupoc.dw_dm_data SET
mes   	       = DATE_FORMAT( dia, "%m"),
semestre	   = IF( DATE_FORMAT( dia, "%m") > 6 , 2, 1),
trimestre      = QUARTER(dia),
ano            = DATE_FORMAT( dia, "%Y" ),
dia_semana     = DAYOFWEEK(dia),
dia_util       = IF( DATE_FORMAT( dia, "%W" ) IN ('Saturday','Sunday'), 0, 1)
;


