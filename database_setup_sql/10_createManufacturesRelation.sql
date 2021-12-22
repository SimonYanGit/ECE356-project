CREATE TABLE `manufactures_relation` (
  `make_name` VARCHAR(255) NULL DEFAULT NULL,
  `model_id` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`model_id`),
  UNIQUE INDEX `model_id_UNIQUE` (`model_id` ASC) VISIBLE,
  CONSTRAINT `model_fk`
    FOREIGN KEY (`model_id`)
    REFERENCES `model` (`model_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


insert into manufactures_relation
select distinct make_name, md5(concat(`model_name`, `trimid`, `trim_name`, `body_type`, `transmission`, `transmission_display`, `wheel_system`, `wheel_system_display`, `back_legroom`, `front_legroom`, `highway_fuel_economy`, `city_fuel_economy`, `combine_fuel_economy`, `fuel_tank_volume`, `fuel_type`, `height`, `length`, `width`, `interior_color`, `exterior_color`, `wheelbase`, `power`, `franchise_make`, `year`, `maximum_seating`, `horsepower`, `engine_type`, `engine_cylinders`, `engine_displacement`, `torque`)) model_id from fullcsv;


