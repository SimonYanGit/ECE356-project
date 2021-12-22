CREATE TABLE `city` (
  `city` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`city`),
  UNIQUE INDEX `city_UNIQUE` (`city` ASC) VISIBLE);

insert into city
select distinct city from fullcsv;
