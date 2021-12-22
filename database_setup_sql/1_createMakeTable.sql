CREATE TABLE `make` (
  `make_name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`make_name`)
);

INSERT INTO make
SELECT DISTINCT make_name
FROM fullcsv;