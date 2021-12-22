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