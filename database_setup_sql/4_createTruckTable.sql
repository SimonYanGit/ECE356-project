CREATE TABLE `truck` (
  `vin` VARCHAR(20) NOT NULL,
  `listing_color` VARCHAR(45) NOT NULL,
  `main_picture_url` TEXT NULL DEFAULT NULL,
  `mileage` INT NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `bed` VARCHAR(45) NULL DEFAULT NULL,
  `bed_height` FLOAT(2) NULL DEFAULT NULL,
  `bed_length` FLOAT(2) NULL DEFAULT NULL,
  `cabin` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`vin`),
  UNIQUE INDEX `vin_UNIQUE` (`vin` ASC) VISIBLE,
  INDEX `truck_idx` (`listing_color` ASC, `mileage` ASC) VISIBLE);


insert into truck
select distinct
    vin,
    listing_color,
    (case when main_picture_url='' then null else main_picture_url end) main_picture_url,
    (case when mileage='' then null else cast(mileage as unsigned) end) mileage,
    (case when description='' then null else description end) description,
    (case when bed='' then null else bed end) bed,
    (case when bed_height='' then null else cast(substring_index(bed_height,' ',1) as float) end) bed_height,
    (case when bed_length='' then null else cast(substring_index(bed_length,' ',1) as float) end) bed_length,
    (case when cabin='' then null else cabin end) bed
from fullcsv
where body_type='Pickup Truck';