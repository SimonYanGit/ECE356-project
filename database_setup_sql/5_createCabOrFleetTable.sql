CREATE TABLE `caborfleet` (
  `vin` VARCHAR(20) NOT NULL,
  `listing_color` VARCHAR(45) NOT NULL,
  `main_picture_url` TEXT NULL DEFAULT NULL,
  `mileage` INT NULL DEFAULT NULL,  
  `isCab` BOOLEAN NULL DEFAULT NULL,
  `fleet` BOOLEAN NULL DEFAULT NULL,
  PRIMARY KEY (`vin`),
  UNIQUE INDEX `vin_UNIQUE` (`vin` ASC) VISIBLE,
  INDEX `caborfleet_idx` (`listing_color` ASC, `mileage` ASC) VISIBLE);


insert into caborfleet
select distinct
    vin,
    listing_color,
    (case when main_picture_url='' then null else main_picture_url end) main_picture_url,
    (case when mileage='' then null else cast(mileage as unsigned) end) mileage,
    (case 
        when isCab='FALSE' then false
        when isCab='TRUE' then true
        else null
	end) isCab,
    (case 
        when fleet='FALSE' then false
        when fleet='TRUE' then true
        else null
	end) fleet
from fullcsv;