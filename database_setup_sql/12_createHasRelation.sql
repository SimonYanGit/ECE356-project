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
