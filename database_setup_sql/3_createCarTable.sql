CREATE TABLE `car` (
  `vin` VARCHAR(20) NOT NULL,
  `listing_color` VARCHAR(45) NOT NULL,
  `main_picture_url` TEXT NULL DEFAULT NULL,
  `mileage` INT NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`vin`),
  UNIQUE INDEX `vin_UNIQUE` (`vin` ASC) VISIBLE,
  INDEX `car_idx` (`listing_color` ASC, `mileage` ASC) VISIBLE);


insert into car
select distinct
    vin,
    listing_color,
    (case when main_picture_url='' then null else main_picture_url end) main_picture_url,
    (case when mileage='' then null else cast(mileage as unsigned) end) mileage,
    (case when description='' then null else description end) description
from fullcsv;