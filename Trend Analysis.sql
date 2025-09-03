USE bellabeat;
SELECT 
    d.Id,
    d.ActivityDate,
    d.VeryActiveMinutes,
    d.TotalMinutesAsleep,
    AVG(h.Value) AS avg_hr
FROM day_level d
JOIN heartrate_seconds h
    ON d.Id = h.Id 
   AND d.ActivityDate = DATE(h.Time)

GROUP BY d.Id, d.ActivityDate, d.VeryActiveMinutes, d.TotalMinutesAsleep;

SELECT 
    d.Id,
    d.ActivityDate,
    d.TotalSteps,
    d.Calories,
    d.TotalMinutesAsleep
FROM day_level d
WHERE d.TotalMinutesAsleep < 360;
SELECT 
    d.Id,
    d.ActivityDate,
    d.TotalMinutesAsleep,
    d.Calories,
    AVG(h.Value) AS avg_heart_rate
FROM day_level d
JOIN heartrate_seconds h
    ON d.Id = h.Id
   AND d.ActivityDate = DATE(h.Time)
WHERE d.TotalMinutesAsleep < 360   -- less than 6 hours sleep
GROUP BY d.Id, d.ActivityDate, d.TotalMinutesAsleep, d.Calories
ORDER BY d.ActivityDate;

-- SQL: summarize average calories by sleep duration bins (optional)
SELECT 
    ROUND(TotalMinutesAsleep/60) AS sleep_hours,
    AVG(Calories) AS avg_calories
FROM day_level
GROUP BY sleep_hours
ORDER BY sleep_hours;

SELECT 
    CASE 
        WHEN DAYOFWEEK(ActivityDate) IN (1,7) THEN 'Weekend'  -- Sunday=1, Saturday=7
        ELSE 'Weekday'
    END AS day_type,
    AVG(Calories) AS avg_calories,
    COUNT(*) AS num_records
FROM day_level
GROUP BY day_type;
SELECT Id,
       MIN(ActivityDate) AS first_record,
       MAX(ActivityDate) AS last_record,
       COUNT(*) AS total_days
FROM day_level
GROUP BY Id
HAVING DATEDIFF(MAX(ActivityDate), MIN(ActivityDate)) + 1 > total_days;
SELECT 
    da.Id,
    da.ActivityDate,
    da.SedentaryMinutes,
    sd.TotalMinutesAsleep,
    sd.TotalTimeInBed,
    ROUND(CAST(sd.TotalMinutesAsleep AS FLOAT) / NULLIF(sd.TotalTimeInBed,0), 2) AS sleep_efficiency
FROM daily_activity da
JOIN sleep_day sd
    ON da.Id = sd.Id
   AND da.ActivityDate = sd.SleepDay
WHERE sd.TotalTimeInBed > 0
ORDER BY da.SedentaryMinutes DESC;
SELECT 
    HOUR(hs.Time) AS hour_of_day,
    ROUND(AVG(hs.Value), 2) AS avg_heart_rate,
    MAX(hs.Value) AS max_heart_rate,
    COUNT(*) AS readings
FROM heartrate_seconds hs
GROUP BY HOUR(hs.Time)
ORDER BY avg_heart_rate DESC;

SELECT Id, ActivityDate, Calories
FROM (
    SELECT Id,
           ActivityDate,
           Calories,
           ROW_NUMBER() OVER (ORDER BY Calories DESC) AS rn,
           COUNT(*) OVER () AS total_rows
    FROM day_level
) t
WHERE rn <= 0.05 * total_rows
ORDER BY Calories DESC;

SELECT 
    CASE 
        WHEN dl.TotalMinutesAsleep > 420 THEN 'More than 7 hrs'
        ELSE '7 hrs or less'
    END AS sleep_group,
    ROUND(AVG(dl.Calories), 2) AS avg_calories,
    ROUND(AVG(hr.HeartRate), 2) AS avg_heartrate,
    COUNT(DISTINCT dl.Id) AS num_users,
    COUNT(*) AS total_days
FROM day_level dl
JOIN (
    SELECT Id, DATE(Time) AS hr_date, AVG(Value) AS HeartRate
    FROM heartrate_seconds
    GROUP BY Id, DATE(Time)
) hr
  ON dl.Id = hr.Id AND dl.ActivityDate = hr.hr_date
WHERE dl.TotalMinutesAsleep IS NOT NULL
GROUP BY sleep_group
ORDER BY avg_calories DESC;
