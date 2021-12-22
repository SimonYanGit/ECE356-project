CREATE TABLE `accidentandtheftreports` (
  `vin` VARCHAR(20) NOT NULL,
  `frame_damaged` BOOLEAN NULL DEFAULT NULL,
  `salvage` BOOLEAN NULL DEFAULT NULL,
  `theft_title` BOOLEAN NULL DEFAULT NULL,
  `vehicle_damage_category` VARCHAR(45) NULL DEFAULT NULL,
  `has_accidents` BOOLEAN NULL DEFAULT NULL,
  PRIMARY KEY (`vin`),
  UNIQUE INDEX `vin_UNIQUE` (`vin` ASC) VISIBLE);

insert into accidentandtheftreports
select distinct
	vin,
	(case 
		when frame_damaged='FALSE' then false
		when frame_damaged='TRUE' then true
		else null
	end) frame_damaged,
	(case 
		when salvage='FALSE' then false
		when salvage='TRUE' then true
		else null
	end) salvage,
	(case 
		when theft_title='FALSE' then false
		when theft_title='TRUE' then true
		else null
	end) theft_title,
	(case 
		when vehicle_damage_category='' then null    
	end) vehicle_damage_category,
	(case 
		when has_accidents='FALSE' then false
		when has_accidents='TRUE' then true
		else null
	end) has_accidents
from fullcsv;