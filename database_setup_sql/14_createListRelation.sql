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