use chicago;
################################################################################################################## Crash Table
# Creating a crash table from the csv file. The fields are based on the available columns and some data types.
DROP TABLE crashes; 
CREATE TABLE crashes (
	CRASH_RECORD_ID 				VARCHAR(255), 
	RD_NO 							VARCHAR(255), 
	CRASH_DATE_EST_I 				VARCHAR(255), 
	CRASH_DATE 						VARCHAR(255), 
	POSTED_SPEED_LIMIT 				INTEGER, 
	TRAFFIC_CONTROL_DEVICE 			VARCHAR(255), 
	DEVICE_CONDITION 				VARCHAR(255), 
	WEATHER_CONDITION 				VARCHAR(255), 
	LIGHTING_CONDITION 				VARCHAR(255), 
	FIRST_CRASH_TYPE 				VARCHAR(255), 
	TRAFFICWAY_TYPE 				VARCHAR(255), 
	LANE_CNT 						VARCHAR(255), 
	ALIGNMENT 						VARCHAR(255), 
	ROADWAY_SURFACE_COND 			VARCHAR(255), 
	ROAD_DEFECT 					VARCHAR(255), 
	REPORT_TYPE 					VARCHAR(255), 
	CRASH_TYPE 						VARCHAR(255), 
	INTERSECTION_RELATED_I 			VARCHAR(255), 
	NOT_RIGHT_OF_WAY_I 				VARCHAR(255), 
	HIT_AND_RUN_I 				 	VARCHAR(255), 
	DAMAGE 							VARCHAR(255), 
	DATE_POLICE_NOTIFIED 			VARCHAR(255), 
	PRIM_CONTRIBUTORY_CAUSE 		VARCHAR(255), 
	SEC_CONTRIBUTORY_CAUSE 			VARCHAR(255), 
	STREET_NO 						INTEGER, 
	STREET_DIRECTION 				VARCHAR(255), 
	STREET_NAME 					VARCHAR(255), 
	BEAT_OF_OCCURRENCE 				INTEGER, 
	PHOTOS_TAKEN_I 					VARCHAR(255), 
	STATEMENTS_TAKEN_I 				VARCHAR(255), 
	DOORING_I 						VARCHAR(255), 
	WORK_ZONE_I 					VARCHAR(255), 
	WORK_ZONE_TYPE 					VARCHAR(255), 
	WORKERS_PRESENT_I 				VARCHAR(255), 
	NUM_UNITS 						INTEGER, 
	MOST_SEVERE_INJURY 				VARCHAR(255), 
	INJURIES_TOTAL 					INTEGER, 
	INJURIES_FATAL 					INTEGER, 
	INJURIES_INCAPACITATING 		INTEGER, 
	INJURIES_NON_INCAPACITATING 	INTEGER, 
	INJURIES_REPORTED_NOT_EVIDENT 	INTEGER, 
	INJURIES_NO_INDICATION 			INTEGER, 
	INJURIES_UNKNOWN 				INTEGER, 
	CRASH_HOUR 						INTEGER, 
	CRASH_DAY_OF_WEEK 				INTEGER, 
	CRASH_MONTH 					INTEGER, 
	LATITUDE 						FLOAT, 
	LONGITUDE 						FLOAT, 
	LOCATION 						VARCHAR(255)	
);

# Importing data from csv file into the created table 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ChicagoCrashes.csv'
	INTO TABLE crashes
	FIELDS TERMINATED BY ','
	IGNORE 1 ROWS;

# Testing if all went well, querying something
select * from crashes 
	where POSTED_SPEED_LIMIT = 55
	limit 5;

/* Assigning primary key to a variable. This was not done when table was being created because the importing phase took a long time if primary key was defined in the table creation phase.
After a few times trying different things, I landed on having a simple table with no indexes and then adding primary and foreign key to the variables - took a lot less time. */
ALTER TABLE crashes 
	ADD PRIMARY KEY (CRASH_RECORD_ID);

################################################################################################################## People Table
/* Creating a people table from the csv file. The fields are based on the available columns and some data types. Due to too many rows in the original 
csv file, I broke the file into two separate ones and called them people1 and people 2 to import. Later on I combined them both into one table called peoples */
DROP TABLE IF EXISTS people1 ; 
CREATE TABLE people1 (
	PERSON_ID				VARCHAR(255)	NOT NULL,
	PERSON_TYPE				VARCHAR(255),
	CRASH_RECORD_ID			VARCHAR(255)	NOT NULL,
	RD_NO					VARCHAR(255),
	VEHICLE_ID				INTEGER,
	CRASH_DATE				VARCHAR(255),
	SEAT_NO					VARCHAR(255),
	CITY					VARCHAR(255),	
	STATE					VARCHAR(255),	
	ZIPCODE					VARCHAR(255),	
	SEX						VARCHAR(255),	
	AGE						INTEGER,	
	DRIVERS_LICENSE_STATE	VARCHAR(255),	
	DRIVERS_LICENSE_CLASS	VARCHAR(255),	
	SAFETY_EQUIPMENT		VARCHAR(255),	
	AIRBAG_DEPLOYED			VARCHAR(255),	
	EJECTION				VARCHAR(255),	
	INJURY_CLASSIFICATION	VARCHAR(255),	
	HOSPITAL				VARCHAR(255),	
	EMS_AGENCY				VARCHAR(255),	
	EMS_RUN_NO				VARCHAR(255),	
	DRIVER_ACTION			VARCHAR(255),	
	DRIVER_VISION			VARCHAR(255),	
	PHYSICAL_CONDITION		VARCHAR(255),	
	PEDPEDAL_ACTION			VARCHAR(255),	
	PEDPEDAL_VISIBILITY		VARCHAR(255),	
	PEDPEDAL_LOCATION		VARCHAR(255),	
	BAC_RESULT				VARCHAR(255),	
	BAC_RESULT_VALUE		VARCHAR(255),	
	CELL_PHONE_USE			VARCHAR(255)				
);

# Importing data from csv file into the created table 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ChicagoPeople1.csv'
INTO TABLE people1
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;
select * from people1 limit 5;

# Creating the second people table from the second piece of the raw csv file. The fields are based on the available columns and some data types.
DROP TABLE IF EXISTS people2 ; 
CREATE TABLE people2 (
	PERSON_ID				VARCHAR(255)	NOT NULL,
	PERSON_TYPE				VARCHAR(255),
	CRASH_RECORD_ID			VARCHAR(255)	NOT NULL,
	RD_NO					VARCHAR(255),
	VEHICLE_ID				INTEGER,
	CRASH_DATE				VARCHAR(255),
	SEAT_NO					VARCHAR(255),
	CITY					VARCHAR(255),	
	STATE					VARCHAR(255),	
	ZIPCODE					VARCHAR(255),	
	SEX						VARCHAR(255),	
	AGE						INTEGER,	
	DRIVERS_LICENSE_STATE	VARCHAR(255),	
	DRIVERS_LICENSE_CLASS	VARCHAR(255),	
	SAFETY_EQUIPMENT		VARCHAR(255),	
	AIRBAG_DEPLOYED			VARCHAR(255),	
	EJECTION				VARCHAR(255),	
	INJURY_CLASSIFICATION	VARCHAR(255),	
	HOSPITAL				VARCHAR(255),	
	EMS_AGENCY				VARCHAR(255),	
	EMS_RUN_NO				VARCHAR(255),	
	DRIVER_ACTION			VARCHAR(255),	
	DRIVER_VISION			VARCHAR(255),	
	PHYSICAL_CONDITION		VARCHAR(255),	
	PEDPEDAL_ACTION			VARCHAR(255),	
	PEDPEDAL_VISIBILITY		VARCHAR(255),	
	PEDPEDAL_LOCATION		VARCHAR(255),	
	BAC_RESULT				VARCHAR(255),	
	BAC_RESULT_VALUE		VARCHAR(255),	
	CELL_PHONE_USE			VARCHAR(255)
);

# Importing data from csv file into the created table 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ChicagoPeople2.csv'
	INTO TABLE people2
	FIELDS TERMINATED BY ',' 
	IGNORE 1 ROWS;

# testing if all went well
select * from people2 where Age > 105;

# Creating the final people table as a union of the two separate tables created.
CREATE TABLE peoples as
	SELECT * from people
	UNION
	SELECT * from people2;

################################################################################################################## Vehicle Table
/* Vehicle csv file had a ton of fields, 72 to be exact. So at the beginning it gave me error that there is too much I'm dying and whatnot! so I tried various methods found online and 
a couple of those good methods needed admin rights, which I don't have here and don't feel like going after it. So I started dropping variables from the end and fortunately, 68 variables worked 
and MySQL bought it. Here now: similar to people table had to cut the original csv file into two files to be able to import them! creating the first one here */
# SET GLOBAL innodb_strict_mode = off;
DROP TABLE IF EXISTS vehicle1 ; 
CREATE TABLE vehicle1 (
	CRASH_UNIT_ID				INTEGER,
	CRASH_RECORD_ID				VARCHAR(255),
	RD_NO						VARCHAR(255),
	CRASH_DATE					VARCHAR(255),
	UNIT_NO						INTEGER	,
	UNIT_TYPE					VARCHAR(255),
	NUM_PASSENGERS				VARCHAR(255),
	VEHICLE_ID					INTEGER	,
	CMRC_VEH_I					VARCHAR(255),
	MAKE						VARCHAR(255),
	MODEL						VARCHAR(255),
	LIC_PLATE_STATE				VARCHAR(255),
	VEHICLE_YEAR				VARCHAR(255),
	VEHICLE_DEFECT				VARCHAR(255),
	VEHICLE_TYPE				VARCHAR(255),
	VEHICLE_USE					VARCHAR(255),
	TRAVEL_DIRECTION			VARCHAR(255),
	MANEUVER					VARCHAR(255),
	TOWED_I						VARCHAR(255),
	FIRE_I						VARCHAR(255),
	OCCUPANT_CNT				INTEGER	,
	EXCEED_SPEED_LIMIT_I		VARCHAR(255),
	TOWED_BY					VARCHAR(255),
	TOWED_TO					VARCHAR(255),
	AREA_00_I					VARCHAR(255),
	AREA_01_I					VARCHAR(255),
	AREA_02_I					VARCHAR(255),
	AREA_03_I					VARCHAR(255),
	AREA_04_I					VARCHAR(255),
	AREA_05_I					VARCHAR(255),
	AREA_06_I					VARCHAR(255),
	AREA_07_I					VARCHAR(255),
	AREA_08_I					VARCHAR(255),
	AREA_09_I					VARCHAR(255),
	AREA_10_I					VARCHAR(255),
	AREA_11_I					VARCHAR(255),
	AREA_12_I					VARCHAR(255),
	AREA_99_I					VARCHAR(255),
	FIRST_CONTACT_POINT			VARCHAR(255),
	CMV_ID						VARCHAR(255),
	USDOT_NO					VARCHAR(255),
	CCMC_NO						VARCHAR(255),
	ILCC_NO						VARCHAR(255),
	COMMERCIAL_SRC				VARCHAR(255),
	GVWR						VARCHAR(255),
	CARRIER_NAME				VARCHAR(255),
	CARRIER_STATE				VARCHAR(255),
	CARRIER_CITY				VARCHAR(255),
	HAZMAT_PLACARDS_I			VARCHAR(255),
	HAZMAT_NAME					VARCHAR(255),
	UN_NO						VARCHAR(255),
	HAZMAT_PRESENT_I			VARCHAR(255),
	HAZMAT_REPORT_I				VARCHAR(255),
	HAZMAT_REPORT_NO			VARCHAR(255),
	MCS_REPORT_I				VARCHAR(255),
	MCS_REPORT_NO				VARCHAR(255),
	HAZMAT_VIO_CAUSE_CRASH_I	VARCHAR(255),
	MCS_VIO_CAUSE_CRASH_I		VARCHAR(255),
	IDOT_PERMIT_NO				VARCHAR(255),
	WIDE_LOAD_I					VARCHAR(255),
	TRAILER1_WIDTH				VARCHAR(255),
	TRAILER2_WIDTH				VARCHAR(255),
	TRAILER1_LENGTH				VARCHAR(255),
	TRAILER2_LENGTH				VARCHAR(255),
	TOTAL_VEHICLE_LENGTH		VARCHAR(255),
	AXLE_CNT					VARCHAR(255),
	VEHICLE_CONFIG				VARCHAR(255),
	CARGO_BODY_TYPE				VARCHAR(255)
);

# Importing data from csv file into the created table 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ChicagoVehicles1.csv'
	INTO TABLE vehicle1
	FIELDS TERMINATED BY ',' 
	IGNORE 1 ROWS;

# Creating the second vehicle table
DROP TABLE IF EXISTS vehicle2 ; 
CREATE TABLE vehicle2 (
	CRASH_UNIT_ID					INTEGER	,
	CRASH_RECORD_ID					VARCHAR(255)	,
	RD_NO							VARCHAR(255)	,
	CRASH_DATE						VARCHAR(255)	,
	UNIT_NO							INTEGER	,
	UNIT_TYPE						VARCHAR(255)	,
	NUM_PASSENGERS					VARCHAR(255)	,
	VEHICLE_ID						INTEGER	,
	CMRC_VEH_I						VARCHAR(255)	,
	MAKE							VARCHAR(255)	,
	MODEL							VARCHAR(255)	,
	LIC_PLATE_STATE					VARCHAR(255)	,
	VEHICLE_YEAR					VARCHAR(255)	,
	VEHICLE_DEFECT					VARCHAR(255)	,
	VEHICLE_TYPE					VARCHAR(255)	,
	VEHICLE_USE						VARCHAR(255)	,
	TRAVEL_DIRECTION				VARCHAR(255)	,
	MANEUVER						VARCHAR(255)	,
	TOWED_I							VARCHAR(255)	,
	FIRE_I							VARCHAR(255)	,
	OCCUPANT_CNT					INTEGER	,
	EXCEED_SPEED_LIMIT_I			VARCHAR(255)	,
	TOWED_BY						VARCHAR(255)	,
	TOWED_TO						VARCHAR(255)	,
	AREA_00_I						VARCHAR(255)	,
	AREA_01_I						VARCHAR(255)	,
	AREA_02_I						VARCHAR(255)	,
	AREA_03_I						VARCHAR(255)	,
	AREA_04_I						VARCHAR(255)	,
	AREA_05_I						VARCHAR(255)	,
	AREA_06_I						VARCHAR(255)	,
	AREA_07_I						VARCHAR(255)	,
	AREA_08_I						VARCHAR(255)	,
	AREA_09_I						VARCHAR(255)	,
	AREA_10_I						VARCHAR(255)	,
	AREA_11_I						VARCHAR(255)	,
	AREA_12_I						VARCHAR(255)	,
	AREA_99_I						VARCHAR(255)	,
	FIRST_CONTACT_POINT				VARCHAR(255)	,
	CMV_ID							VARCHAR(255)	,
	USDOT_NO						VARCHAR(255)	,
	CCMC_NO							VARCHAR(255)	,
	ILCC_NO							VARCHAR(255)	,
	COMMERCIAL_SRC					VARCHAR(255)	,
	GVWR							VARCHAR(255)	,
	CARRIER_NAME					VARCHAR(255)	,
	CARRIER_STATE					VARCHAR(255)	,
	CARRIER_CITY					VARCHAR(255)	,
	HAZMAT_PLACARDS_I				VARCHAR(255)	,
	HAZMAT_NAME						VARCHAR(255)	,
	UN_NO							VARCHAR(255)	,
	HAZMAT_PRESENT_I				VARCHAR(255)	,
	HAZMAT_REPORT_I					VARCHAR(255)	,
	HAZMAT_REPORT_NO				VARCHAR(255)	,
	MCS_REPORT_I					VARCHAR(255)	,
	MCS_REPORT_NO					VARCHAR(255)	,
	HAZMAT_VIO_CAUSE_CRASH_I		VARCHAR(255)	,
	MCS_VIO_CAUSE_CRASH_I			VARCHAR(255)	,
	IDOT_PERMIT_NO					VARCHAR(255)	,
	WIDE_LOAD_I						VARCHAR(255)	,
	TRAILER1_WIDTH					VARCHAR(255)	,
	TRAILER2_WIDTH					VARCHAR(255)	,
	TRAILER1_LENGTH					VARCHAR(255)	,
	TRAILER2_LENGTH					VARCHAR(255)	,
	TOTAL_VEHICLE_LENGTH			VARCHAR(255)	,
	AXLE_CNT						VARCHAR(255)	,
	VEHICLE_CONFIG					VARCHAR(255)	,
	CARGO_BODY_TYPE					VARCHAR(255)
);

# Importing data from csv file into the created table 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ChicagoVehicles2.csv'
	INTO TABLE vehicle2
	FIELDS TERMINATED BY ',' 
	IGNORE 1 ROWS;

# Combining the two vehicles table into one large final table
CREATE TABLE vehicles as
	SELECT * from vehicle1
	UNION
	SELECT * from vehicle2;

################################################################################################################## Dropping Extra Tables
# Dropping the extra tables (e.g. vehicles and peoples tables) made to combine into 1 due to too many number of rows in the csv file
DROP TABLE IF EXISTS test, people1, people2, vehicle1, vehicle2; 

################################################################################################################## Assigning Primary and Foreign Keys
/* To assign primary and foreign key, those fields have to be unique - 
Let's check if there are duplicates in the person_id in peoples table and why! If it returns 0, we're all set */
SELECT person_id, COUNT(person_id)					
	FROM peoples
	GROUP BY person_id
	HAVING COUNT(person_id) > 1;
    
# Making person_id primary key on the peoples table
ALTER TABLE peoples ADD PRIMARY KEY (person_id);

/* To assign primary and foreign key, those fields have to be unique - 
for the vehicles table, vehicle_id is not unique. There is a lot of 0 which I assigned to those missing values before import when rows referred to the non-motorized party in the crash 
I first checked what those rows with missing (now have a value of 0) vehicle_id look like. Then I checked how many of them I have. There were 31519 rows. 
These are rows for the non-motorized party in the crash and I did not need them in vehicles table - they show up in peoples and crashes). Next I removed those rows from the table. 
Then, I checked if there is any duplicates in vehicle_id; that would be an alarm, because I wanted it to be the primary key for this table. There was no duplicate. Life is good. */
select * from vehicles where vehicle_id = 0; 			# see how they look like where there is no vehicle_id present (is equal to 0 - originally missing)
select count(*) from vehicles where vehicle_id = 0; 	# how many rows with no vehicle_id
DELETE from vehicles where vehicle_id = 0; 				# removing all the rows for non-motorized party involved in the crash.
SELECT vehicle_id, COUNT(vehicle_id)					# Let's check if there are duplicates in the vehicle_id and why!
	FROM vehicles
	GROUP BY vehicle_id
	HAVING COUNT(vehicle_id) > 1;

# Making vehicle_id primary key on the vehicles table
ALTER TABLE vehicles ADD PRIMARY KEY (vehicle_id);

# Making crash_id foreign key on both vehicles and peoples table, referencing that in crashes table.
ALTER TABLE peoples ADD CONSTRAINT FK_PeoplesCrashes 
					FOREIGN KEY (CRASH_RECORD_ID) 
					REFERENCES crashes(CRASH_RECORD_ID)
					ON UPDATE cascade
					ON DELETE cascade;

ALTER TABLE vehicles ADD CONSTRAINT FK_VehiclesCrashes 
					FOREIGN KEY (CRASH_RECORD_ID) 
					REFERENCES crashes(CRASH_RECORD_ID)
					ON UPDATE cascade
					ON DELETE cascade;

# Since the foreign key assignment code above game an Error Code: 1826. Duplicate foreign key constraint name 'FK_VehiclesCrashes', checking if it works!
SELECT c.crash_record_id, count(vehicle_id) as "No Vehicles"
    FROM crashes C JOIN vehicles V -- this is explicit join 
        on C.crash_record_id = V.crash_record_id
    GROUP BY crash_record_id
    having count(vehicle_id) > 10
    Order By 2 desc;

-- Also to check on the structure of the vehicles table and how the keys are defined, I could use this line
show create table vehicles;
##################################################################################################################