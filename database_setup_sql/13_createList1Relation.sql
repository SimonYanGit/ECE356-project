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