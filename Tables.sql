CREATE DATABASE bellabeat;
USE bellabeat;
DROP TABLE IF EXISTS daily_activity;
DROP TABLE IF EXISTS sleep_day;
CREATE TABLE sleep_day (
    Id BIGINT,
    SleepDay DATETIME,
    TotalSleepRecords INT,
    TotalMinutesAsleep INT,
    TotalTimeInBed INT
);
DROP TABLE IF EXISTS heartrate_seconds;
CREATE TABLE heartrate_seconds (
    Id BIGINT,
    Time DATETIME,
    Value INT
);
DROP TABLE IF EXISTS weight_log;
CREATE TABLE weight_log (
    Id BIGINT,
    Date DATETIME,
    WeightKg FLOAT,
    WeightPounds FLOAT,
    Fat FLOAT,
    BMI FLOAT,
    IsManualReport BOOLEAN,
    LogId BIGINT
);
DROP TABLE IF EXISTS weight_log;
CREATE TABLE weight_log (
    Id BIGINT,
    Date DATETIME,
    WeightKg FLOAT,
    WeightPounds FLOAT,
    Fat FLOAT,
    BMI FLOAT,
    IsManualReport BOOLEAN,
    LogId BIGINT
);
LOAD DATA LOCAL INFILE 'C:/Users/mishi/Downloads/archive (3).zip/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/dailyActivity_merged.csv'
INTO TABLE daily_activity
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/mishi/Downloads/archive (3).zip/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv'
INTO TABLE daily_activity
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;


LOAD DATA LOCAL INFILE 'C:\Users\mishi\Documents\dailyActivity_2.csv'
INTO TABLE daily_activity
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '"C:\Users\mishi\Documents\dailyActivity_merged.csv"'
INTO TABLE daily_activity
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dailyActivity_2.csv'
INTO TABLE daily_activity
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dailyActivity_merged.csv'
INTO TABLE daily_activity
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
DESCRIBE daily_activity;


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dailyActivity_2.csv'
INTO TABLE daily_activity
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Id, @ActivityDate, TotalSteps, TotalDistance, TrackerDistance, LoggedActivitiesDistance, VeryActiveDistance, ModeratelyActiveDistance, LightActiveDistance, SedentaryActiveDistance, VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes, Calories)
SET ActivityDate = STR_TO_DATE(@ActivityDate, '%m/%d/%Y');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dailyActivity_merged.csv'
INTO TABLE daily_activity
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Id, @ActivityDate, TotalSteps, TotalDistance, TrackerDistance, LoggedActivitiesDistance, VeryActiveDistance, ModeratelyActiveDistance, LightActiveDistance, SedentaryActiveDistance, VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes, Calories)
SET ActivityDate = STR_TO_DATE(@ActivityDate, '%m/%d/%Y');


-- Load weightLogInfo_merged.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/weightLogInfo_merged.csv'
INTO TABLE weight_log
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Id, @Date, WeightKg, WeightPounds, @Fat, BMI, @IsManualReport, LogId)
SET Date = STR_TO_DATE(@Date, '%m/%d/%Y %h:%i:%s %p'),
    Fat = CASE WHEN @Fat = '' OR @Fat IS NULL THEN NULL ELSE @Fat END,
    IsManualReport = CASE WHEN @IsManualReport = 'True' THEN 1 ELSE 0 END;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/weightLogInfo_2.csv'
INTO TABLE weight_log
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Id, @Date, WeightKg, WeightPounds, @Fat, BMI, @IsManualReport, LogId)
SET Date = STR_TO_DATE(@Date, '%m/%d/%Y %h:%i:%s %p'),
    Fat = CASE WHEN @Fat = '' OR @Fat IS NULL THEN NULL ELSE @Fat END,
    IsManualReport = CASE WHEN @IsManualReport = 'True' THEN 1 ELSE 0 END;
    -- Load heartrate_seconds_merged.csv
-- Load sleepDay_merged.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sleepDay_merged.csv'
INTO TABLE sleep_day
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Id, @SleepDay, TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed)
SET SleepDay = STR_TO_DATE(@SleepDay, '%m/%d/%Y %h:%i:%s %p');

-- Load sleepDay_2.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sleepDay_2.csv'
INTO TABLE sleep_day
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Id, @SleepDay, TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed)
SET SleepDay = STR_TO_DATE(@SleepDay, '%m/%d/%Y %h:%i:%s %p');
-- Check weight log data
SELECT COUNT(*) as weight_records FROM weight_log;
SELECT * FROM weight_log LIMIT 5;

-- Check heart rate data
SELECT COUNT(*) as heartrate_records FROM heartrate_seconds;
SELECT * FROM heartrate_seconds LIMIT 5;

-- Check sleep data
SELECT COUNT(*) as sleep_records FROM sleep_day;
SELECT * FROM sleep_day LIMIT 5;

SHOW TABLES
