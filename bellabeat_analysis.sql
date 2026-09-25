-- Upload the dataset used for analysis

--====================================================================
--1.CHECK DATA INTEGRITY 
--====================================================================
-- Compare Calories data between daily_activity_2 and daily_calories2
-- to verify data completeness
SELECT 
  da.Id, da.Calories, dc.Calories
FROM 
  `casestudy-bellabeat-509507.fitabase_data_2.daily_activity_2` as da
FULL JOIN 
  `casestudy-bellabeat-509507.fitabase_data_2.daily_calories2` as dc
ON 
  da.Id=dc.Id AND da.ActivityDate= dc.ActivityDay;

-- CHECK TABLE 
SELECT 
  *
FROM 
  `casestudy-bellabeat-509507.fitabase_data_1.daily_activity` ;
--had done the same for all tables

--====================================================================
--2.CHECK FOR DUPLICATE
--====================================================================
SELECT 
  *, 
  count(*) AS duplicate_count
FROM `casestudy-bellabeat-509507.fitabase_data_1.daily_activity`
GROUP BY ALL 
HAVING COUNT(*)>1;
--Data has no duplicate.


SELECT 
  *, 
  count(*) AS duplicate_count
FROM `casestudy-bellabeat-509507.fitabase_data_2.daily_activity_2`
GROUP BY ALL 
HAVING COUNT(*)>1;
--Data has no duplicate.

--had done the same with all of other dataset.

--====================================================================
--3.CHECK FOR DATA TYPE
--====================================================================

--Change Data Type String to Date using create or replace table.

CREATE OR REPLACE TABLE `casestudy-bellabeat-509507.fitabase_data_1.weight_log1` AS

SELECT
  Id,
  DATE(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', Date)) AS Date,
  WeightKg,
  WeightPounds,
  Fat,
  BMI, 
  IsManualReport,
  LogId
FROM `casestudy-bellabeat-509507.fitabase_data_1.weight_log1`;

-- Another table
CREATE OR REPLACE TABLE `casestudy-bellabeat-509507.fitabase_data_1.minute_sleep1` AS

SELECT 
  Id,
  DATE(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', date)) AS date,
  value,
  logID
FROM `casestudy-bellabeat-509507.fitabase_data_1.minute_sleep1`

--====================================================================
--4.CHECK FOR NULL VALUES
--====================================================================

SELECT 
  COUNTIF (Id is Null), 
  COUNTIF (ActivityDate is Null), 
  COUNTIF (TotalSteps is Null), 
  COUNTIF (TotalDistance is Null), 
  COUNTIF (TrackerDistance is Null),
  COUNTIF (LoggedActivitiesDistance is Null),
  COUNTIF (VeryActiveDistance is Null),
  COUNTIF (ModeratelyActiveDistance is Null),
  COUNTIF (LightActiveDistance is Null),
  COUNTIF (SedentaryActiveDistance is Null),
  COUNTIF (VeryActiveMinutes is Null),
  COUNTIF (FairlyActiveMinutes is Null),
  COUNTIF (LightlyActiveMinutes is Null),
  COUNTIF (SedentaryMinutes is Null),
  COUNTIF (Calories is Null) 
FROM 
  `casestudy-bellabeat-509507.fitabase_data_1.daily_activity` ;
--Data has no null-values

--CHECKING WEIGHTLOG DATA
SELECT 
  COUNTIF (Id is Null), 
  COUNTIF (`Date` is Null), 
  COUNTIF (WeightKg is Null), 
  COUNTIF (WeightPounds is Null), 
  COUNTIF (Fat is Null),
  COUNTIF (BMI is Null),
  COUNTIF (IsManualReport is Null),
  COUNTIF (LogId is Null),
   
FROM `casestudy-bellabeat-509507.fitabase_data_1.weight_log1` ;

--====================================================================
--5.CHECK NUMBER OF UNIQUE USER
--====================================================================

SELECT   
  COUNT(DISTINCT Id)
FROM 
  `casestudy-bellabeat-509507.fitabase_data_1.daily_activity` 

UNION ALL 

SELECT   
  COUNT(DISTINCT Id)
FROM 
  `casestudy-bellabeat-509507.fitabase_data_2.daily_activity_2`; 
--35 unique data for dataset1 and 33 unique Id for dataset2

--CHECKING WEIGHTLOG DATA
SELECT   
  COUNT(DISTINCT Id)
FROM `casestudy-bellabeat-509507.fitabase_data_1.weight_log1`

UNION ALL 

SELECT   
  COUNT(DISTINCT Id)
FROM `casestudy-bellabeat-509507.fitabase_data_2.weight_log2`;
--11 unique data for dataset1 and 8 unique Id for dataset2

--CHECKING SLEEPING DATA
SELECT   
  COUNT(DISTINCT Id)
FROM 
  `casestudy-bellabeat-509507.fitabase_data_1.day_sleep1` 

UNION ALL 

SELECT   
  COUNT(DISTINCT Id)
FROM 
  `casestudy-bellabeat-509507.fitabase_data_2.day_sleep2`; 
--23 unique data for dataset1 and 24 unique Id for dataset2

--====================================================================
--6.MERGE THE DATA 
--====================================================================
--MERGE DAILY ACTIVITY DATA 
CREATE TABLE `casestudy-bellabeat-509507.fitabase_data_combined.daily_activity_combined` AS
SELECT   
  *
FROM 
  `casestudy-bellabeat-509507.fitabase_data_1.daily_activity` 

UNION ALL 

SELECT   
  *
FROM 
  `casestudy-bellabeat-509507.fitabase_data_2.daily_activity2`; 


--MERGE WEIGHT LOG DATA
CREATE TABLE `casestudy-bellabeat-509507.fitabase_data_combined.weightlog_combined` AS
SELECT   
  *
FROM 
  `casestudy-bellabeat-509507.fitabase_data_1.weight_log1` 

UNION ALL 

SELECT   
  *
FROM 
  `casestudy-bellabeat-509507.fitabase_data_2.weight_log2`; 


--====================================================================
--7.JOIN DATA 
--====================================================================
SELECT da.*, wl.WeightKg,wl.BMI
FROM 
  `casestudy-bellabeat-509507.fitabase_data_combined.daily_activity_combined` AS da 
LEFT JOIN 
  `casestudy-bellabeat-509507.fitabase_data_combined.weightlog_combined` AS wl
ON CAST(da.Id AS string)=wl.Id AND da.ActivityDate=wl.Date

ORDER BY da.Id, da.ActivityDate

--====================================================================
--7.CHECKING ID NUMBER
--====================================================================
SELECT 
  Id,
  LENGTH(CAST(Id AS STRING)) as len
FROM `casestudy-bellabeat-509507.fitabase_data_combined.dailyactivity_weightlog_combined`
WHERE LENGTH(CAST(Id AS STRING)) != 10

--Checked all ID number, each Id has 10 numbers long. 


--====================================================================
--8.DATA VALIDATION 
--==================================================================== 
--Compared TotalDistance with the sum of activity-intensity distance fields.

SELECT 
  TotalDistance, 
  (VeryActiveDistance+ModeratelyActiveDistance+LightActiveDistance+SedentaryActiveDistance) AS sum_of_activeintensity_distance,
  TrackerDistance,
  LoggedActivitiesDistance

FROM `casestudy-bellabeat-509507.fitabase_data_combined.dailyactivity_weightlog_combined` 
WHERE LoggedActivitiesDistance != 0
--The values were generally similar, with small differences observed. TotalDistance was therefore retained as the primary overall distance measure.


--====================================================================
--9.INTEGRATING SLEEP DATA 
--==================================================================== 
--Aggregating minute-level sleep data into daily sleep metric.

CREATE TABLE `casestudy-bellabeat-509507.fitabase_data_1.day_sleep1` AS

SELECT 
  Id,
  sleepdate AS SleepDate,
  NULL as TotalSleepRecords,
  COUNTIF(value=1) AS TotalMinutesAsleep,
  COUNT(*) AS TotalTimeInBed
FROM `casestudy-bellabeat-509507.fitabase_data_1.minute_sleep1`
GROUP BY Id, sleepdate
ORDER BY Id, sleepdate;

--MERGE SLEEP DATA 
CREATE TABLE `casestudy-bellabeat-509507.fitabase_data_combined.daysleep_combined` AS
SELECT   
  Id, 
  SleepDate,
  TotalSleepRecords, 
  TotalMinutesAsleep,
  TotalTimeInBed
FROM 
  `casestudy-bellabeat-509507.fitabase_data_1.day_sleep1`

UNION ALL 

SELECT   
  CAST(Id AS STRING) AS Id,
  SleepDate,
  TotalSleepRecords, 
  TotalMinutesAsleep,
  TotalTimeInBed
FROM 
  `casestudy-bellabeat-509507.fitabase_data_2.day_sleep2`; 

--JOIN THE SLEEP DATA TO MAIN TABLE 
CREATE TABLE `casestudy-bellabeat-509507.fitabase_data_combined.combined_data_raw` AS

SELECT dwc.*, ds.TotalMinutesAsleep,ds.TotalTimeInBed
FROM 
  `casestudy-bellabeat-509507.fitabase_data_combined.dailyactivity_weightlog_combined` AS dwc 
LEFT JOIN 
  `casestudy-bellabeat-509507.fitabase_data_combined.daysleep_combined` AS ds
ON CAST(dwc.Id AS string)=ds.Id AND dwc.ActivityDate=ds.SleepDate

ORDER BY dwc.Id, dwc.ActivityDate

--====================================================================
--9.CREATE CLEANED DATASET
--==================================================================== 
CREATE TABLE `casestudy-bellabeat-509507.fitabase_data_combined.fitabase_cleaned_data` AS

SELECT 
  Id, 
  ActivityDate, 
  FORMAT_DATE('%A', ActivityDate) AS day_name,
  TotalSteps,
  TotalDistance,
  VeryActiveDistance,
  ModeratelyActiveDistance,
  LightActiveDistance,
  SedentaryActiveDistance, 
  (VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes+SedentaryMinutes) AS TotalActiveMinutes,
  VeryActiveMinutes,
  FairlyActiveMinutes,
  LightlyActiveMinutes,
  SedentaryMinutes,
  TotalMinutesAsleep,
  TotalTimeInBed,
  Calories,
  WeightKg,
  BMI
  
FROM `casestudy-bellabeat-509507.fitabase_data_combined.combined_data_raw`



