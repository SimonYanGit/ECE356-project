required:
    vin
    listing_color
    listing_id
    listed_date
    daysonmarket
    price
    city
    sp_id

optional:
    main_picture_url
    mileage
    is_certified
    is_cpo
    is_oemcpo
    savings_amount
    owner_count
    is_new
    description
    major_options
    sp_name
    dealer_zip
    franchise_dealer
    latitude
    longitude
    seller_rating



INSERT INTO car (vin, listing_color) VALUES ('TEST', 'BLACK');

insert into listing(listing_id, listed_date, daysonmarket, price)
insert into list_relation(vin, listing_id)

insert into city(city)
insert into seller(sp_id)
insert into has_relation(sp_id, city)
insert into list1_relation(listing_id, sp_id)    



INSERT INTO listing(listing_id, listed_date, daysonmarket, price) VALUES ()
INSERT INTO list_relation(vin, listing_id) VALUES ()

INSERT INTO city(city) VALUES ()
INSERT INTO seller(sp_id) VALUES ()
INSERT INTO has_relation(sp_id, city) VALUES ()
INSERT INTO list1_relation(listing_id, sp_id) VALUES ()