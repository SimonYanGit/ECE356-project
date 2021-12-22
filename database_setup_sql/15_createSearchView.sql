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
	torque,
	description
FROM model
INNER JOIN specifies_relation USING(model_id)
INNER JOIN car USING(vin)
INNER JOIN manufactures_relation USING(model_id)
INNER JOIN list_relation USING(vin)
INNER JOIN listing USING(listing_id)
INNER JOIN list1_relation USING(listing_id)
INNER JOIN seller USING(sp_id)
INNER JOIN has_relation USING(sp_id);