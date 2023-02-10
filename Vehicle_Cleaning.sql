use chicago;
##################################################################################################################
/*
Let's see if some of the features will make it to the analysis dataset by first looking how many of each are there - 
The followings stay in the model but need some aggregation of levels or cleaning. Those in the Dropping section will drop with the reason in front of it
- CRASH_UNIT_ID (unit ID for the parties involved in each crash, can be vehicle, ped, bike, etc.)
- CRASH_RECORD_ID
- UNIT_TYPE (driver vs driverless vs parked mainly - may become useful) 
- NUM_PASSENGERS (excluding driver. Only used for when record is a vehicle - Varchar(255) on this one should change to 
- MAKE (needs some cleaning)
- MODEL (needs some cleaning)
- LIC_PLATE_STATE (The state issuing the license plate - many missing and many from other than IL)
- VEHICLE_YEAR (some good cleaning is due on this one)
- VEHICLE_TYPE (e.g. is it a pickup or sedan or truck, etc.)
- VEHICLE_USE (There are some interesting values in this that may be fun to look at, e.g. ambulance, police, tow truck, etc.)
- MANEUVER (just curious if this can give me any insight on the why and how of the crashes)
- OCCUPANT_CNT (number of people in the nuit. Curious how this is different from NUM_PASSENGERS)
- FIRST_CONTACT_POINT (this is good one, can be useful)




Dropping
- RD_NO - This is the police report number which does not matter to me
- CRASH_DATE - can get this from crash table
- UNIT_NO - this is the unit id within each crash - does not help much since the general CRASH_UNIT_ID is already unique
- NUM_PASSENGERS - does not matter in my potential analyses
- VEHICLE_ID - already a CRASH_UNIT_ID that does the job - this is only when the unit is a vehicle
- CMRC_VEH_I - I am guessing this is the index that shows if the vehicle is commercial vehicle or not but 98% of the data is missing!
- VEHICLE_DEFECT - there is way too many unknown and a lot of No Deffect. I can't trust the rest of them either knowing how police reports work
- TRAVEL_DIRECTION - this does not matter to me, I am not making collision diagrams by any chance and the crash manners are in another column
- TOWED_I - too many missing and this info was in another column too
- FIRE_I - too many missing
- EXCEED_SPEED_LIMIT_I - too many missing
- TOWED_BY - Not important
- TOWED_TO - Not important
- AREA_XX_I - This seems to be an index to show if the vehicle (or maybe crash) has something to do with a certin area but there is way too many missing values and not important to me either
- Rest of the variables do not seem to be much useful and many of them have a ton of missing values
*/

select CRASH_UNIT_ID from vehicles where CRASH_UNIT_ID is null;
select CRASH_UNIT_ID, count(*) from vehicles group by CRASH_UNIT_ID having CRASH_UNIT_ID is null;
select count(distinct CRASH_UNIT_ID), count(*) from vehicles;
select UNIT_TYPE, count(*) from vehicles group by UNIT_TYPE;
select NUM_PASSENGERS, unit_type, count(*) from vehicles group by NUM_PASSENGERS order by 3 asc, 1 desc;
select * from vehicles where NUM_PASSENGERS = 59;
select count(distinct VEHICLE_ID), count(*) from vehicles;
select CMRC_VEH_I, count(*) from vehicles group by CMRC_VEH_I;
select MAKE, MODEL, count(*) from vehicles group by MAKE, MODEL order by MAKE, MODEL;
select LIC_PLATE_STATE, count(*) from vehicles group by LIC_PLATE_STATE;
select VEHICLE_YEAR, count(*) from vehicles group by VEHICLE_YEAR order by 1;
select VEHICLE_DEFECT, count(*) from vehicles group by VEHICLE_DEFECT;
select VEHICLE_TYPE, count(*) from vehicles group by VEHICLE_TYPE;
select VEHICLE_USE, count(*) from vehicles group by VEHICLE_USE;
select TRAVEL_DIRECTION, count(*) from vehicles group by TRAVEL_DIRECTION;
select MANEUVER, count(*) from vehicles group by MANEUVER;
select FIRE_I, count(*) from vehicles group by FIRE_I;
select OCCUPANT_CNT, count(*) from vehicles group by OCCUPANT_CNT;
select EXCEED_SPEED_LIMIT_I, count(*) from vehicles group by EXCEED_SPEED_LIMIT_I;
select FIRST_CONTACT_POINT, count(*) from vehicles group by FIRST_CONTACT_POINT;
select USDOT_NO, count(*) from vehicles group by USDOT_NO order by 2 desc; -- some of these USDOT IDs seems to be involved in multiple crashes!
select CCMC_NO, count(*) from vehicles group by CCMC_NO;
select NUM_PASSENGERS, OCCUPANT_CNT from vehicles limit 50;
-- Create table VehicleClean

create table vehicleclean
	select CRASH_UNIT_ID as UnitID,
			CRASH_RECORD_ID as CrashID,
			UNIT_TYPE as UnitType,
			NUM_PASSENGERS as Passengers,
			MAKE as VMake,
			MODEL as VModel,
			VEHICLE_YEAR as VYear,
			VEHICLE_TYPE as VType,
			VEHICLE_USE as VUsage,
			LIC_PLATE_STATE as VState,
			MANEUVER as Maneuver,
			OCCUPANT_CNT as Occupants,
			FIRST_CONTACT_POINT as FirstContact
		from vehicles;

select * from vehicleclean limit 2;
select * from vehicles limit 2;

-- The End