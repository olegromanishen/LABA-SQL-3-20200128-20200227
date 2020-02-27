select * from db_laba.dbo.countries;


select * from db_laba.dbo.countries_02_mbelko;

delete from db_laba.dbo.countries_02_mbelko;
insert into db_laba.dbo.countries_02_mbelko select * from db_laba.dbo.countries;


DROP TABLE IF EXISTS  db_laba.dbo.warehouses_mbelko;

CREATE TABLE db_laba.dbo.warehouses_mbelko (
	warehouse_id int PRIMARY KEY,
	warehouse_name varchar(255) NULL,
	country_id char(2) NOT NULL,
	CONSTRAINT fk_warehouses_mbelko FOREIGN KEY(country_id) 
REFERENCES db_laba.dbo.countries_02_mbelko(country_id)	
);


select * from db_laba.dbo.countries_test_03_mbelko;
--err The UPDATE permission was denied on the column 'country_id' of the object
--'countries_02_mbelko', database 'db_laba', schema 'dbo'.

update db_laba.dbo.countries_02_mbelko
set country_name = country_name + '_new';


-- Drop table

-- DROP TABLE db_laba.dbo.countries_test_03_mbelko GO

CREATE TABLE db_laba.dbo.countries_test_03_mbelko (id int, name varchar(128));

REVOKE INSERT ON OBJECT :: "dbo"."countries_test_03_mbelko" FROM "lector" ;



GRANT INSERT ON OBJECT :: "dbo"."countries_test_03_mbelko" TO "lector";



SELECT * from db_laba.dbo.customers_ny
