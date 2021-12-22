drop view if exists search_view;
drop table if exists manufactures_relation;
drop table if exists specifies_relation;
drop table if exists has_relation;
drop table if exists list1_relation;
drop table if exists list_relation;
drop table if exists make;
drop table if exists model;
drop table if exists car;
drop table if exists truck;
drop table if exists caborfleet;
drop table if exists city;
drop table if exists seller;
drop table if exists listing;
drop table if exists accidentandtheftreports;
drop table if exists fullcsv;

create table fullcsv(
    vin varchar(255),
    back_legroom varchar(255),
    bed varchar(255),
    bed_height varchar(255),
    bed_length varchar(255),
    body_type varchar(255),
    cabin varchar(255),
    city varchar(255),
    city_fuel_economy varchar(255),
    combine_fuel_economy varchar(255),
    daysonmarket varchar(255),
    dealer_zip varchar(255),
    description TEXT,
    engine_cylinders varchar(255),
    engine_displacement varchar(255),
    engine_type varchar(255),
    exterior_color varchar(255),
    fleet varchar(255),
    frame_damaged varchar(255),
    franchise_dealer varchar(255),
    franchise_make varchar(255),
    front_legroom varchar(255),
    fuel_tank_volume varchar(255),
    fuel_type varchar(255),
    has_accidents varchar(255),
    height varchar(255),
    highway_fuel_economy varchar(255),
    horsepower varchar(255),
    interior_color varchar(255),
    isCab varchar(255),
    is_certified varchar(255),
    is_cpo varchar(255),
    is_new varchar(255),
    is_oemcpo varchar(255),
    latitude varchar(255),
    length varchar(255),
    listed_date varchar(255),
    listing_color varchar(255),
    listing_id varchar(255),
    longitude varchar(255),
    main_picture_url TEXT,
    major_options TEXT,
    make_name varchar(255),
    maximum_seating varchar(255),
    mileage varchar(255),
    model_name varchar(255),
    owner_count varchar(255),
    power varchar(255),
    price varchar(255),
    salvage varchar(255),
    savings_amount varchar(255),
    seller_rating varchar(255),
    sp_id varchar(255),
    sp_name varchar(255),
    theft_title varchar(255),
    torque varchar(255),
    transmission varchar(255),
    transmission_display varchar(255),
    trimId varchar(255),
    trim_name varchar(255),
    vehicle_damage_category varchar(255),
    wheel_system varchar(255),
    wheel_system_display varchar(255),
    wheelbase varchar(255),
    width varchar(255),
    year varchar(255)
);

-- run this on command line:
-- LOAD DATA LOCAL INFILE '/Program Files/MySQL/MySQL Server 8.0/uploads/used_cars_data_500k.csv' INTO TABLE fullcsv FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

CREATE TABLE `make` (
  `make_name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`make_name`)
);

INSERT INTO make
SELECT DISTINCT make_name
FROM fullcsv;


-- every model has a make
-- every model has a trimid
-- but they do not identify every row in this table (eg. same model, same trim, but auto vs.manual)
-- created model_id field - hash of the other fields

CREATE TABLE `model` (
  `model_id` VARCHAR(255) NOT NULL,
  `model_name` VARCHAR(255) NOT NULL,
  `trimid` VARCHAR(45) NOT NULL DEFAULT 't0',
  `trim_name` VARCHAR(255) NULL DEFAULT NULL,
  `body_type` VARCHAR(45) NOT NULL DEFAULT 'Other',
  `transmission` VARCHAR(45) NULL DEFAULT NULL,
  `transmission_display` VARCHAR(45) NULL DEFAULT NULL,
  `wheel_system` VARCHAR(45) NULL DEFAULT NULL,
  `wheel_system_display` VARCHAR(45) NULL DEFAULT NULL,
  `back_legroom` FLOAT(2) NULL DEFAULT NULL,
  `front_legroom` FLOAT(2) NULL DEFAULT NULL,
  `highway_fuel_economy` INT NULL DEFAULT NULL,  
  `city_fuel_economy` INT NULL DEFAULT NULL,
  `combine_fuel_economy` INT NULL DEFAULT NULL,
  `fuel_tank_volume` FLOAT(2) NULL DEFAULT NULL,
  `fuel_type` VARCHAR(45) NULL DEFAULT NULL,
  `height` FLOAT(2) NULL DEFAULT NULL,
  `length` FLOAT(2) NULL DEFAULT NULL,
  `width` FLOAT(2) NULL DEFAULT NULL,
  `interior_color` VARCHAR(255) NULL DEFAULT NULL,
  `exterior_color` VARCHAR(255) NULL DEFAULT NULL,
  `wheelbase` FLOAT(2) NULL DEFAULT NULL,
  `power` VARCHAR(45) NULL DEFAULT NULL,
  `franchise_make` VARCHAR(45) NULL DEFAULT NULL,
  `year` INT NOT NULL,
  `maximum_seating` INT NULL DEFAULT NULL,
  `horsepower` INT NULL DEFAULT NULL,
  `engine_type` VARCHAR(45) NULL DEFAULT NULL,
  `engine_cylinders` VARCHAR(45) NULL DEFAULT NULL,
  `engine_displacement` INT NULL DEFAULT NULL,
  `torque` VARCHAR(45) NULL DEFAULT NULL,
PRIMARY KEY (`model_id`),
UNIQUE INDEX `model_id_UNIQUE` (`model_id` ASC) VISIBLE,
INDEX `model_idx` (`body_type` ASC, `year` ASC, `maximum_seating` ASC, `engine_type` ASC) VISIBLE);


INSERT INTO model
SELECT DISTINCT
  md5(concat(`model_name`, `trimid`, `trim_name`, `body_type`, `transmission`, `transmission_display`, `wheel_system`, `wheel_system_display`, `back_legroom`, `front_legroom`, `highway_fuel_economy`, `city_fuel_economy`, `combine_fuel_economy`, `fuel_tank_volume`, `fuel_type`, `height`, `length`, `width`, `interior_color`, `exterior_color`, `wheelbase`, `power`, `franchise_make`, `year`, `maximum_seating`, `horsepower`, `engine_type`, `engine_cylinders`, `engine_displacement`, `torque`)) model_id,
  model_name,
  (case when trimid='' then 't0' else trimid end) trimid,
  (case when trim_name='' then 't0' else trim_name end) trim_name,
  (case when body_type='' then 'Other' else body_type end) body_type,
  (case when transmission='' then null else transmission end) transmission,
  (case when transmission_display='' then null else transmission_display end) transmission_display,
  (case when wheel_system='' then null else wheel_system end) wheel_system,
  (case when wheel_system_display='' then null else wheel_system_display end) wheel_system_display,
  (case when back_legroom='' then null else cast(substring_index(back_legroom,' ',1) as float) end) back_legroom,
  (case when front_legroom='' then null else cast(substring_index(front_legroom,' ',1) as float) end) front_legroom,
  (case when highway_fuel_economy='' then null else cast(highway_fuel_economy as unsigned) end) highway_fuel_economy, 
  (case when city_fuel_economy='' then null else cast(city_fuel_economy as unsigned) end) city_fuel_economy, 
  (case when combine_fuel_economy='' then null else combine_fuel_economy end)combine_fuel_economy,
  (case when fuel_tank_volume='' then null else cast(substring_index(fuel_tank_volume,' ',1) as float) end) fuel_tank_volume,
  (case when fuel_type='' then null else fuel_type end) fuel_type,
  (case when height='' then null else cast(substring_index(height,' ',1) as float) end) height,
  (case when length='' then null else cast(substring_index(length,' ',1) as float) end) length,
  (case when width='' then null else cast(substring_index(width,' ',1) as float) end) width,
  (case when interior_color='?' then null else interior_color end) interior_color,
  exterior_color,
  (case when wheelbase='' then null else cast(substring_index(wheelbase,' ',1) as float) end) wheelbase,
  (case when power='' then null else replace(power,';','') end) power,
  (case when franchise_make='' then null else franchise_make end) franchise_make,
  cast(`year` as unsigned) `year`,
  (case when maximum_seating='' then null else cast(substring_index(maximum_seating,' ',1) as float) end) maximum_seating,
  (case when horsepower='' then null else cast(horsepower as unsigned) end) horsepower,
  (case when engine_type='' then null else engine_type end) engine_type,
  (case when engine_cylinders='' then null else engine_cylinders end) engine_cylinders,
  (case when engine_displacement='' then null else cast(engine_displacement as unsigned) end) engine_displacement,
  (case when torque='' then null else replace(torque,';','') end) torque
FROM fullcsv;


CREATE TABLE `car` (
  `vin` VARCHAR(20) NOT NULL,
  `listing_color` VARCHAR(45) NOT NULL,
  `main_picture_url` TEXT NULL DEFAULT NULL,
  `mileage` INT NULL DEFAULT NULL,  
  PRIMARY KEY (`vin`),
  UNIQUE INDEX `vin_UNIQUE` (`vin` ASC) VISIBLE,
  INDEX `car_idx` (`listing_color` ASC, `mileage` ASC) VISIBLE);


insert into car
select distinct
    vin,
    listing_color,
    (case when main_picture_url='' then null else main_picture_url end) main_picture_url,
    (case when mileage='' then null else cast(mileage as unsigned) end) mileage    
from fullcsv;


CREATE TABLE `truck` (
  `vin` VARCHAR(20) NOT NULL,
  `listing_color` VARCHAR(45) NOT NULL,
  `main_picture_url` TEXT NULL DEFAULT NULL,
  `mileage` INT NULL DEFAULT NULL,
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
    (case when bed='' then null else bed end) bed,
    (case when bed_height='' then null else cast(substring_index(bed_height,' ',1) as float) end) bed_height,
    (case when bed_length='' then null else cast(substring_index(bed_length,' ',1) as float) end) bed_length,
    (case when cabin='' then null else cabin end) bed
from fullcsv
where body_type='Pickup Truck';


CREATE TABLE `caborfleet` (
  `vin` VARCHAR(20) NOT NULL,
  `listing_color` VARCHAR(45) NOT NULL,
  `main_picture_url` TEXT NULL DEFAULT NULL,
  `mileage` INT NULL DEFAULT NULL , 
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


CREATE TABLE `city` (
  `city` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`city`),
  UNIQUE INDEX `city_UNIQUE` (`city` ASC) VISIBLE);

insert into city
select distinct city from fullcsv;


-- sp_id cannot be used as a PK because there are records where 
-- 1. there are sp_names with no sp_id
-- 2. there are sp_ids with >1 different sp_names (specifically id='285330')

-- delete/update the rows that are causing errors
update fullcsv
set sp_id='285331'
where sp_id='285330' and sp_name='Atlantic Volkswagen';

-- 2 diff seller ratings for the same sp
-- take the average of the seller ratings



CREATE TABLE `seller` (
  `sp_id` varchar(255) NOT NULL,
  `sp_name` VARCHAR(255) NULL DEFAULT NULL,
  `dealer_zip` VARCHAR(15) NULL DEFAULT NULL,
  `franchise_dealer` BOOLEAN NULL DEFAULT NULL,
  `latitude` FLOAT(10) NULL DEFAULT NULL,
  `longitude` FLOAT(10) NULL DEFAULT NULL,
  `seller_rating` FLOAT(10) NULL DEFAULT NULL,
  PRIMARY KEY (`sp_id`),
  UNIQUE INDEX `sp_id_UNIQUE` (`sp_id` ASC) VISIBLE);

-- if no sp_id available - hash the rest of the attributes to create it  
insert into seller
SELECT DISTINCT
	(case when sp_id='' then md5(concat(sp_id, sp_name, dealer_zip, franchise_dealer, latitude, longitude)) else sp_id end) sp_id,
	(case when sp_name='' then null else sp_name end) sp_name,
	(case when dealer_zip='' then null else dealer_zip end) dealer_zip,
	(case 
		when franchise_dealer='TRUE' then true 
        when franchise_dealer='FALSE' then false
        else null 
	end) franchise_dealer,
	(case when latitude='' then null else cast(latitude as float) end) latitude,
	(case when longitude='' then null else cast(longitude as float) end) longitude,
	AVG((case when seller_rating='' then null else cast(seller_rating as float) end)) seller_rating
FROM fullcsv
group by sp_id, sp_name, dealer_zip, franchise_dealer, latitude, longitude;



CREATE TABLE `listing` (
  `listing_id` INT NOT NULL,
  `listed_date` DATE NOT NULL,
  `is_certified` BOOLEAN NULL DEFAULT NULL,
  `is_cpo` BOOLEAN NULL DEFAULT NULL,
  `is_oemcpo` BOOLEAN NULL DEFAULT NULL,
  `daysonmarket` INT NOT NULL DEFAULT 0,
  `savings_amount` FLOAT(2) NULL DEFAULT NULL,
  `price` FLOAT(2) NOT NULL,
  `owner_count` INT NULL DEFAULT NULL,
  `is_new` BOOLEAN NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `major_options` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`listing_id`),
  UNIQUE INDEX `listing_id_UNIQUE` (`listing_id` ASC) VISIBLE,
  INDEX `listing_idx` (`listed_date` ASC, `price` ASC) VISIBLE);

insert into listing
select
	(case when listing_id='' then null else CAST(listing_id as unsigned) end) listing_id,
	(DATE_FORMAT(STR_TO_DATE(listed_date,'%m/%d/%Y'), '%Y-%m-%d')) listed_date,
	(case 
		when is_certified='FALSE' then false
		when is_certified='TRUE' then true
		else NULL
	end) is_certified,
	(case 
		when is_cpo='FALSE' then false
		when is_cpo='TRUE' then true
		else NULL
	end) is_cpo,
	(case 
		when is_oemcpo='FALSE' then false
		when is_oemcpo='TRUE' then true
		else NULL
	end) is_oemcpo,
	(case when daysonmarket='' then null else CAST(daysonmarket as unsigned) end) daysonmarket,
	(case when savings_amount='' then null else cast(savings_amount as float) end) savings_amount,
	(case when price='' then null else cast(price as float) end) price,
	(case when owner_count='' then null else cast(owner_count as unsigned) end) owner_count,
	(case
		when is_new='FALSE' then false
		when is_new='TRUE' then true
        else null
    end) is_new,
	(case when description='' then null else description end) description,
	(case when major_options='' then null else major_options end) major_options
FROM fullcsv;


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


CREATE TABLE `has_relation` (
  `city` VARCHAR(255) NULL,
  `sp_id` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`sp_id`),
  INDEX `city_has_fk_idx` (`city` ASC) VISIBLE,
  CONSTRAINT `city_has_fk`
    FOREIGN KEY (`city`)
    REFERENCES `city` (`city`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `seller_has_fk`
    FOREIGN KEY (`sp_id`)
    REFERENCES `seller` (`sp_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


insert into has_relation
select city, sp_id from (
select distinct 
city, 
(case when sp_id='' then md5(concat(sp_id, sp_name, dealer_zip, franchise_dealer, latitude, longitude)) else sp_id end) sp_id
from fullcsv) tmp;



CREATE TABLE `list1_relation` (
  `listing_id` INT NOT NULL,
  `sp_id` VARCHAR(255) NULL,
  PRIMARY KEY (`listing_id`),
  UNIQUE INDEX `listing_id_UNIQUE` (`listing_id` ASC) VISIBLE,
  INDEX `list1_seller_fk_idx` (`sp_id` ASC) VISIBLE,
  CONSTRAINT `list1_listing_fk`
    FOREIGN KEY (`listing_id`)
    REFERENCES `listing` (`listing_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `list1_seller_fk`
    FOREIGN KEY (`sp_id`)
    REFERENCES `seller` (`sp_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

insert into list1_relation
select distinct listing_id, (case when sp_id='' then md5(concat(sp_id, sp_name, dealer_zip, franchise_dealer, latitude, longitude)) else sp_id end) sp_id
from fullcsv;


CREATE TABLE `list_relation` (
  `vin` VARCHAR(20) NOT NULL,
  `listing_id` INT NOT NULL,
  PRIMARY KEY (`vin`, `listing_id`),
  INDEX `list_listing_fk_idx` (`listing_id` ASC) VISIBLE,
  CONSTRAINT `list_car_fk`
    FOREIGN KEY (`vin`)
    REFERENCES `car` (`vin`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `list_listing_fk`
    FOREIGN KEY (`listing_id`)
    REFERENCES `listing` (`listing_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


insert into list_relation
select distinct vin, listing_id
from fullcsv;


CREATE VIEW `search_view` AS
select 
	city,
	listing_id,
	vin,
	make_name,
	model_name,
	year,
	body_type,
	engine_type,
	listing_color,
	price,
	mileage,
	wheel_system_display,
	transmission_display,
	maximum_seating,
	listed_date,
	trim_name,
	highway_fuel_economy,
	city_fuel_economy,
	combine_fuel_economy,
	interior_color,
	power,
	torque
FROM model
INNER JOIN specifies_relation USING(model_id)
INNER JOIN car USING(vin)
INNER JOIN manufactures_relation USING(model_id)
INNER JOIN list_relation USING(vin)
INNER JOIN listing USING(listing_id)
INNER JOIN list1_relation USING(listing_id)
INNER JOIN seller USING(sp_id)
INNER JOIN has_relation USING(sp_id);