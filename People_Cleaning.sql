use chicago;
##################################################################################################################
/* 
Let's see if some of the features will make it to the analysis dataset by first looking how many of each are there - 
The followings stay in the model but need some aggregation of levels or cleaning. Those in the Dropping section will drop with the reason in front of it
- PERSON_ID (a unique ID for the persons involved in crashes. if it starts with p then it's a passenger in a vehicle otherwise, not, e.g. driver or cyclist)
- PERSON_TYPE (type of person involved, e.g. driver, passenger, ciclist, ped, etc.)
- CRASH_RECORD_ID
- VEHICLE_ID (This is the UnitID from the vehicles table)
- SEAT_NO
- CITY (of residence for the person in the crash) - these will need some good cleaning
- STATE (of residence for the person in the crash)
- ZIPCODE (of residence for the person in the crash)
- SEX 
- AGE 
- SAFETY_EQUIPMENT (this could come handy in some data analytics but there are too many missing values)
- AIRBAG_DEPLOYED (may come handy as a surrogate for severity)
- EJECTION (this may come handy in some data analytics)
- INJURY_CLASSIFICATION (excellent source for verifying and validating the severity level of the crash with few missing)
- DRIVER_ACTION (this is good with types of action - some good info in this one)
- PEDPEDAL_ACTION - this is similar to driver action but for peds or cyclists - can be useful

Dropping
- RD_NO - This is the police report number which does not matter to me
- CRASH_DATE - can get this from crash table
- DRIVERS_LICENSE_STATE - I don't feel this to be much useful in the analysis
- DRIVERS_LICENSE_CLASS - not useful to me!
- SEAT_NO - too many missing values
- HOSPITAL - I don't care much on the name of the location the injured person was taken
- EMS_AGENCY - nor which EMS took the person
- EMS_RUN_NO - or what was their call number
- DRIVER_VISION - too many missing or unknown and those known are not so much catching my attention
- PHYSICAL_CONDITION - based on the distinct values, does not seem to be much helpful
- PEDPEDAL_VISIBILITY - simialr to those for drivers but for peds and cyclists
- PEDPEDAL_LOCATION
- BAC_RESULT - not solid values to be useful
- BAC_RESULT_VALUE - not useful values
- CELL_PHONE_USE - this is garbage with way too many missing
*/

select count(PERSON_ID), count(distinct PERSON_ID) from peoples;
select PERSON_TYPE, count(*) from peoples group by PERSON_TYPE;
select count(CRASH_RECORD_ID), count(distinct CRASH_RECORD_ID), count(PERSON_ID), count(distinct PERSON_ID) from peoples; -- results: 1493819, 679718, 1493819, 1493819
select RD_NO, count(*) from peoples group by RD_NO;
select VEHICLE_ID, count(*) from peoples group by VEHICLE_ID order by 2 desc;
select count(distinct VEHICLE_ID) from peoples; select count(distinct CRASH_UNIT_ID) from vehicles; -- these two are the same and equal to 1,356,701
select CRASH_DATE, count(*) from peoples group by CRASH_DATE;
select SEAT_NO, count(*) from peoples group by SEAT_NO;
select CITY, count(*) from peoples group by CITY;
select STATE, count(*) from peoples group by STATE;
select ZIPCODE, count(*) from peoples group by ZIPCODE;
select SEX, count(*) from peoples group by SEX;
select AGE, count(*) from peoples group by AGE;
select DRIVERS_LICENSE_STATE, count(*) from peoples group by DRIVERS_LICENSE_STATE;
select DRIVERS_LICENSE_CLASS, count(*) from peoples group by DRIVERS_LICENSE_CLASS;
select SAFETY_EQUIPMENT, count(*) from peoples group by SAFETY_EQUIPMENT;
select AIRBAG_DEPLOYED, count(*) from peoples group by AIRBAG_DEPLOYED;
select EJECTION, count(*) from peoples group by EJECTION;
select INJURY_CLASSIFICATION, count(*) from peoples group by INJURY_CLASSIFICATION;
select HOSPITAL, count(*) from peoples group by HOSPITAL;
select EMS_AGENCY, count(*) from peoples group by EMS_AGENCY;
select EMS_RUN_NO, count(*) from peoples group by EMS_RUN_NO;
select DRIVER_ACTION, count(*) from peoples group by DRIVER_ACTION;
select DRIVER_VISION, count(*) from peoples group by DRIVER_VISION;
select PHYSICAL_CONDITION, count(*) from peoples group by PHYSICAL_CONDITION;
select PEDPEDAL_ACTION, count(*) from peoples group by PEDPEDAL_ACTION;
select PEDPEDAL_VISIBILITY, count(*) from peoples group by PEDPEDAL_VISIBILITY;
select PEDPEDAL_LOCATION, count(*) from peoples group by PEDPEDAL_LOCATION;
select BAC_RESULT, count(*) from peoples group by BAC_RESULT;
select BAC_RESULT_VALUE, count(*) from peoples group by BAC_RESULT_VALUE;
select CELL_PHONE_USE, count(*) from peoples group by CELL_PHONE_USE;


-- Create a clean table with the features of interest kept in the table
Create table PeopleClean
    select PERSON_ID as PersonID,
			PERSON_TYPE as PersonType,
            CRASH_RECORD_ID as CrashID,
            VEHICLE_ID as VehicleID,
            SEAT_NO as Seat,
            CITY as City,
            STATE as State,
            ZIPCODE as Zip,
            SEX as Sex,
            AGE as Age,
            SAFETY_EQUIPMENT as SafetyEquipment,
            AIRBAG_DEPLOYED as Airbag,
            EJECTION as Eject,
            INJURY_CLASSIFICATION as Severity,
            DRIVER_ACTION as DriverAction,
            PEDPEDAL_ACTION as PedAction    
		from peoples;

select * from PeopleClean limit 2;
select * from peoples limit 2;

-- The End