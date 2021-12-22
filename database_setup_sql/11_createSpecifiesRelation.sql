CREATE TABLE `specifies_relation` (
  `vin` VARCHAR(20) NOT NULL,
  `model_id` VARCHAR(255) NULL,
  PRIMARY KEY (`vin`),
  UNIQUE INDEX `vin_UNIQUE` (`vin` ASC) VISIBLE,
  INDEX `model_fk_idx` (`model_id` ASC) VISIBLE,
  CONSTRAINT `car_specifies_fk`
    FOREIGN KEY (`vin`)
    REFERENCES `car` (`vin`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `model_specifies_fk`
    FOREIGN KEY (`model_id`)
    REFERENCES `model` (`model_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

insert into specifies_relation
select vin, md5(concat(`model_name`, `trimid`, `trim_name`, `body_type`, `transmission`, `transmission_display`, `wheel_system`, `wheel_system_display`, `back_legroom`, `front_legroom`, `highway_fuel_economy`, `city_fuel_economy`, `combine_fuel_economy`, `fuel_tank_volume`, `fuel_type`, `height`, `length`, `width`, `interior_color`, `exterior_color`, `wheelbase`, `power`, `franchise_make`, `year`, `maximum_seating`, `horsepower`, `engine_type`, `engine_cylinders`, `engine_displacement`, `torque`)) model_id from fullcsv;