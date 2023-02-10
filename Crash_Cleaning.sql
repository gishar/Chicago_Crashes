use chicago;
##################################################################################################################
/* 
Let's see if some of the features will make it to the analysis dataset by first looking how many of each are there - 
The followings stay in the model but need some aggregation of levels or cleaning. Those in the Dropping section will drop with the reason in front of it
- CRASH_DATE
- POSTED_SPEED_LIMIT
- TRAFFIC_CONTROL_DEVICE
- DEVICE_CONDITION
- WEATHER_CONDITION
- LIGHTING_CONDITION
- FIRST_CRASH_TYPE (a ton of crashes, about 20% of all records are just those with parked motor vehicles! That's what happens dealing with Chcago city crashes!)
- TRAFFICWAY_TYPE (seems to be a useful feature that can help filter out by certain locations or facilities, e.g. only those in parking lots, or TWLTL, or roundabouts.)
- REPORT_TYPE (not so important but I'm curious if I can see any relationship between this and any feature)
- CRASH_TYPE (This is a binary feature for if parties drove away or were injured/towed/taken)
- INTERSECTION_RELATED_I (similar to trafficway type - although there is 77% missing values!
- HIT_AND_RUN_I
- DAMAGE
- PRIM_CONTRIBUTORY_CAUSE
- SEC_CONTRIBUTORY_CAUSE
- BEAT_OF_OCCURRENCE (seems there are 276 distinct of these areas Chicago police uses - can come handy when making judgements)
- DOORING_I (may come handy when looking at bike crashes only)
- NUM_UNITS (this will require some good categorization)
- INJURIES_TOTAL (injuries in a crash - needs some categorization)
- INJURIES_FATAL (fatality in a crash - there are some 2, 3 fatalities in the same crash)
- LATITUDE ( <1% missing)
- LONGITUDE

Dropping
- RD_NO - This is the police report number which does not matter to me
- CRASH_DATE_EST_I - I don't care if the crash date was estimated by reporting a couple days later. Not useful. it's not like it was a year ago!
- ROAD_DEFECT - 98% of data has Unknown or No Deffect - I also know police wouldn't probably care much to truly document this in their report
- LANE_CNT - about 70% of the records are missing a value for lane counts and there is way too many junk in there; based on these I can't rely on the rest either.
- NOT_RIGHT_OF_WAY_I - would have stayed in if 95% were not missing!
- DATE_POLICE_NOTIFIED - this won't really matter to my analysis
- STREET_NO - Part of an address of the crash police 
- STREET_DIRECTION - Part of an address of the crash police 
- STREET_NAME - Part of an address of the crash police 
- PHOTOS_TAKEN_I - 99% missing!
- STATEMENTS_TAKEN_I - 98% missing
- WORK_ZONE_I - 99% missing and those not can't rely on those missing. Also, since I want to look at those crashes with normal conditions, this is used to remove crashes inside WZ
- WORK_ZONE_TYPE - after the above decision
- WORKERS_PRESENT_I - after the above decision
- INJURIES_INCAPACITATING - Unnecessary detail (can be found from Severity)
- INJURIES_NON_INCAPACITATING - Unnecessary detail
- INJURIES_REPORTED_NOT_EVIDENT - Unnecessary detail
- INJURIES_NO_INDICATION - Unnecessary detail 
- INJURIES_UNKNOWN - Unnecessary detail 
- CRASH_HOUR - Unnecessary detail (can be found from Date)
- CRASH_DAY_OF_WEEK - Unnecessary detail
- CRASH_MONTH - Unnecessary detail
*/

select TRAFFIC_CONTROL_DEVICE, count(*) from crashes group by TRAFFIC_CONTROL_DEVICE;
select POSTED_SPEED_LIMIT, count(*) from crashes group by POSTED_SPEED_LIMIT;
select DEVICE_CONDITION, count(*) from crashes group by DEVICE_CONDITION;
select ROAD_DEFECT, count(*) from crashes group by ROAD_DEFECT;
select FIRST_CRASH_TYPE, count(*) from crashes group by 1 order by count(*) desc;
select TRAFFICWAY_TYPE, count(*) from crashes group by TRAFFICWAY_TYPE;
select LANE_CNT, count(*) from crashes group by LANE_CNT;
select REPORT_TYPE, count(*) from crashes group by REPORT_TYPE;
select CRASH_TYPE, count(*) from crashes group by CRASH_TYPE;
select INTERSECTION_RELATED_I, count(*) from crashes group by INTERSECTION_RELATED_I;
select NOT_RIGHT_OF_WAY_I, count(*) from crashes group by NOT_RIGHT_OF_WAY_I;
select HIT_AND_RUN_I, count(*) from crashes group by HIT_AND_RUN_I;
select DAMAGE, count(*) from crashes group by DAMAGE;
select PRIM_CONTRIBUTORY_CAUSE, count(*) from crashes group by PRIM_CONTRIBUTORY_CAUSE;
select SEC_CONTRIBUTORY_CAUSE, count(*) from crashes group by SEC_CONTRIBUTORY_CAUSE;
select count(distinct STREET_NO) from crashes;
select BEAT_OF_OCCURRENCE, count(*) from crashes group by BEAT_OF_OCCURRENCE;
select count(distinct BEAT_OF_OCCURRENCE) from crashes; -- how many beats are there?
select PHOTOS_TAKEN_I, count(*) from crashes group by PHOTOS_TAKEN_I;
select STATEMENTS_TAKEN_I, count(*) from crashes group by STATEMENTS_TAKEN_I;
select DOORING_I, FIRST_CRASH_TYPE, count(*) from crashes group by 1, 2; -- testing if those caused by opening car door are relevant to parked cars or bikes - can come handy
select WORK_ZONE_I, count(*) from crashes group by WORK_ZONE_I;
select count(*) from crashes where WORK_ZONE_I = "Y";
select NUM_UNITS, count(*) from crashes group by NUM_UNITS;
select MOST_SEVERE_INJURY, count(*) from crashes group by MOST_SEVERE_INJURY;
select INJURIES_TOTAL, count(*) from crashes group by INJURIES_TOTAL;
select INJURIES_FATAL, count(*) from crashes group by INJURIES_FATAL;
select count(*) from crashes where latitude = 0 and longitude = 0;

-- Create a clean table with the features of interest kept in the table
Create table CrashClean
	select CRASH_RECORD_ID as CrashID,
			CRASH_DATE as DateTime,
			POSTED_SPEED_LIMIT as SL,
			TRAFFIC_CONTROL_DEVICE as TrDevice,
			DEVICE_CONDITION as TrDevCondition,
			WEATHER_CONDITION as Weather, 
			LIGHTING_CONDITION as Light, 
			FIRST_CRASH_TYPE as Type,
			TRAFFICWAY_TYPE as FacilityType,
			ALIGNMENT as Alignment, 
			ROADWAY_SURFACE_COND as Surface, 
			ROAD_DEFECT as Defect,
			REPORT_TYPE as ReportType, 
			CRASH_TYPE as DriveAway,
			INTERSECTION_RELATED_I as IntRelated,
			HIT_AND_RUN_I as HitRun,
			DAMAGE as Damage,
			PRIM_CONTRIBUTORY_CAUSE as Cause1,
			SEC_CONTRIBUTORY_CAUSE as Cause2,
			BEAT_OF_OCCURRENCE as Beat,
			DOORING_I as Dooring,
			NUM_UNITS as UnitsInvolved,
			MOST_SEVERE_INJURY as Severity,
			INJURIES_TOTAL as Injuries,
			INJURIES_FATAL as Fatalities,
			LATITUDE as Lat,
			LONGITUDE as Lon
		from crashes
		where WORK_ZONE_I != "Y";

select * from crashclean limit 2;
select * from crashes limit 2;

update crashclean set DateTime = str_to_date(DateTime, '%c/%e/%Y %T:%i');	-- changing the format of DateTime to make parts known to database
alter table crashclean Modify DateTime DateTime; 							-- modifying datatime of DateTime to the type DateTime

-- The End