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


