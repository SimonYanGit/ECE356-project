-- open /program files/mysql/mysql 8.0/bin
-- run mysql.exe -uroot -p
-- set global local_infile=true;
-- set global innodb_buffer_pool_size=838860800;
-- exit
-- run mysql.exe --local_infile=1 -uroot -p
-- :

LOAD DATA LOCAL INFILE '/Program Files/MySQL/MySQL Server 8.0/uploads/used_cars_data_500k.csv' INTO TABLE fullcsv FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;