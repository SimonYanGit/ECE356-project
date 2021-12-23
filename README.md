# ECE356-project

cleaned + shortened csv: https://drive.google.com/file/d/14CMkE3muDxPAYXDPv0ulLjbxTj5jYsKm/view?usp=sharing

How to replicate on marmoset server:
1. run the database_setup_sql/fullImport_step1.sql file on the database you chose
2. run the following command on the mysql CLI:
`LOAD DATA INFILE '/var/lib/mysql-files/Group31/used_cars_data_500k.csv' INTO TABLE fullcsv FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;`
4. run the database_setup_sql/fullImport_step2.sql file on the database chosen
5. this should create the 15 tables and 1 view needed for the project
