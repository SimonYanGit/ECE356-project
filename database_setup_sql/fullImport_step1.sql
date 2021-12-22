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
LOAD DATA INFILE '/var/lib/mysql-files/Group31/used_cars_data_500k.csv' INTO TABLE fullcsv FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;