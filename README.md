**Business Task**
The goal of this project is to analyze Fitbit smart device data to identify trends in users’ daily activity, sleep, and health tracking behaviors.
These insights are then applied to Bellabeat, a wellness-focused smart device company, to recommend strategies that improve marketing and customer engagement.

**Dataset**
	• Source: Fitbit Fitness Tracker Data (Kaggle)
	• Duration: March–May 2016 (two months of user activity)
**Steps in Analysis**
A. Data Import
Loaded 18 CSVs into MySQL database bellabeat.
Created tables (daily_activity, sleep_day, weight_log).

B. Data Cleaning
Removed duplicate records.
Standardized date formats (converted to DATE).
Merged the two monthly folders into single tables.

C. Data Integration
Built a day_level table by joining activity + sleep + weight data.
Added calculated fields such as sleep efficiency (MinutesAsleep / TimeInBed).

D. Trend Analysis
Identified various insightful questions such as:

**1.** Do people with more active minutes also sleep better and show lower heart rates?
To explore whether being more active leads to better sleep or lower heart rates, I merged the daily activity, sleep, and heart rate datasets.
Observation 1: Users with higher active minutes often had a higher daily average heart rate. This is expected since more activity elevates overall heart rate averages.
Observation 2: Sleep data coverage was limited and inconsistent. In the few cases with both activity and sleep data, there wasn’t a clear pattern linking more activity to longer or better sleep.
Conclusion: From this dataset, higher activity correlates with higher heart rate averages (due to exertion), but the link between activity and sleep quality is inconclusive due to missing or sparse sleep records.
<img width="490" height="380" alt="image" src="https://github.com/user-attachments/assets/3fcb959e-f452-4a13-bd2a-8016a02c71f9" />

The scatter plot shows the relationship between very active minutes and average heart rate.
People with higher very active minutes often show higher average heart rates (e.g., IDs 4020332650 and 4558609924 show spikes in HR on days with workouts).
On days with little or no activity, the average heart rate tends to be lower and more stable.
However, higher activity does not always correlate with better sleep (your dataset has missing TotalMinutesAsleep, so that part can’t be confirmed yet).

**2**. Does high sedentary time affect sleep efficiency?
Many rows show very high sedentary minutes (close to 1200–1400 mins, i.e. ~20–24 hours sedentary). These are probably people wearing the tracker all day, with very little active movement recorded. Despite high sedentary time, sleep efficiency often remains high (0.9–0.98).
Example: Id 4702921684 on 2016-04-12, Sedentary = 1440 (full day inactive), Sleep efficiency = 0.97 (excellent).
Some outliers exist like Id 3977333714 on 2016-04-20, Sedentary = 845 minutes (~14 hours inactive), Sleep efficiency = 0.50 (very poor) and Id 3977333714 on 2016-04-25, efficiency = 0.56 (also poor).
These suggest inactivity doesn’t always guarantee good sleep — some users still had restless sleep. General pattern: High sedentary time (≥1000 mins) usually coincides with moderately high sleep efficiency (0.9+).
    
**3.** Do people who sleep less than 6 hours still walk as much and burn as many calories?
Many users who slept less than 6 hours still achieved high step counts and calorie burns. For example: User 1503960366 walked 15,506 steps and burned 2,035 calories on April 19 despite only ~5 hours of sleep. But the user 8053475328 walked 22,359 steps and burned 3,554 calories with short sleep on April 23.
However, there are also days with low steps and low calories after short sleep (e.g., User 2026352035 with only 254 steps and 1,141 calories on May 10).
This suggests short sleep does not automatically reduce activity/calories: some people remain highly active, while others show drops.

**4.** Do weekends vs weekdays affect calories burned?
Calories burned on weekends are slightly higher than weekdays (~30 kcal more on average). Weekdays have 1319 records and Weekends have 506 records
This shows you have more data points on weekdays (makes sense), but the trend is still clear: weekends slightly higher.
On average, people burn slightly more calories on weekends than weekdays. The difference is small (~1–2%), so it’s not huge, but it could be due to:
People having more leisure or active time on weekends. Weekday routines might include more sedentary work hours.

**5.** Do users who sleep more then 7 hours burn more calories and have lower average heart rate compared to those who sleep less?
One of the key questions we explored was whether users who sleep longer demonstrate different health outcomes compared to those who sleep less. To answer this, we joined daily activity, sleep logs, and heart rate data. After cleaning for duplicates and ensuring alignment between datasets, we identified 21 unique users who had overlapping records for sleep, calories, and average heart rate.
We then segmented users into two groups:
Group A: ≤ 7 hours of sleep per night
Group B: > 7 hours of sleep per night
Key Findings:-
Higher calorie burn with shorter sleep:
Users sleeping ≤7 hours burned about 223 more calories per day compared to those sleeping longer.
This suggests that shorter-sleeping users tend to have higher activity levels, possibly due to being awake and active for longer periods.
Heart rate is lower with longer sleep:
Users who slept >7 hours recorded an average heart rate of 72.8 bpm, compared to 74.85 bpm for shorter sleepers.
This implies that longer sleep is associated with better cardiovascular recovery and reduced strain.
Trade-off between activity and recovery:
Shorter sleepers appear more active (higher calorie expenditure), but their higher resting heart rate suggests greater physical stress or lower recovery quality.
Longer sleepers may burn slightly fewer calories but gain the benefit of improved heart health and recovery.

📈 Business Implications for Bellabeat

a. Promote sleep as recovery, not just rest: Bellabeat could design campaigns highlighting that adequate sleep supports long-term heart health, balancing activity and wellness.
b. Personalized nudges: For users logging high calorie burn but short sleep, Bellabeat can send reminders emphasizing the importance of sleep quality in sustaining energy and recovery.
c. Wellness coaching opportunities: This insight could inform Bellabeat’s wellness programs, encouraging users to find their optimal balance of activity and rest rather than focusing solely on calorie burn.

**6.** Detect users who have missing activity days in a month.
   Let’s calculate expected vs. actual:
Id = 3372868164 FOR Period: Apr 1 → May 1 = 31 days expected
Logged days = 30
➝ Missing 1 day of activity
Id = 6290855005 FOR Period: Apr 1 → May 10 = 40 days expected
Logged days = 39
➝ Missing 1 day of activity
Id = 8583815059 FOR Period: Apr 1 → May 12 = 42 days expected
Logged days = 39
➝ Missing 3 days of activity
These users had gaps in tracking, which may mean:
Device not worn
App sync failure
Data missing due to user behavior (forgot, skipped, battery dead, etc.)

**7.** What time of the day ususally average heart rate spike occurs the most?
Heart rate peaks in the late afternoon/evening (16:00–19:00), avg HR is 86–84 bpm between 4pm and 7pm, the highest of the day. Max spikes reach 203 bpm, consistent with intense physical activity (exercise sessions, commuting, evening sports).This suggests users are most active during this window.

Daytime hours (10:00–15:00) show moderate activity, avg HR stays in the 80–83 bpm range. Indicates light movement, work-related stress, or low-intensity activities.

Morning ramp-up (7:00–9:00) avg HR rises from 73 bpm at 6am to 81 bpm at 9–10am, likely linked to waking up, commuting, or morning workouts.

Lowest heart rates occur late night/early morning (0:00–5:00), avg HR drops to 61–67 bpm, reflecting resting or sleep state. Even during sleep, occasional spikes (up to ~177–157 bpm at night) could be due to REM cycles or brief awakenings.

Interesting Outlier: Even at 2–3am, max HR spikes to ~139–142 bpm — suggesting some users either had disrupted sleep, stress episodes, or possibly late-night exercise.

The analysis of hourly heart rate patterns across Bellabeat users reveals clear behavioral rhythms. Heart rates are lowest between midnight and 5am (avg 61–67 bpm), reflecting restful sleep phases. As the day begins, heart rates gradually rise, peaking in the late afternoon (4–7pm) where averages reach 86 bpm and maximums exceed 200 bpm. This period likely aligns with after-work exercise routines, sports, or physically demanding activities.
During mid-day hours, heart rates stabilize at moderate levels (~80 bpm), suggesting light movement or work-related stress. Interestingly, even during sleep hours, occasional spikes are visible (max 140+ bpm), which may indicate REM cycles or disruptions. Overall, the data strongly suggests that users experience the most intense cardiovascular activity in the evening, while the body rests and recovers during the early morning hours.

**8.** Do people who sleep longer burn more or fewer calories?
No simple linear relationship: Calories burned do not consistently increase or decrease as sleep duration increases.
Moderate sleep (3–5 units) shows lower calories burned, whereas some mid-range sleep durations (6–10) show higher calories burned.
Very long sleep (>11 units) corresponds to fewer calories burned, which might indicate reduced activity on days with very long sleep.
Conclusion:
People who sleep very little or very much tend to burn fewer calories than those with moderate sleep (with some exceptions).
Overall, longer sleep does not always mean more calories burned. Activity levels during waking hours likely have a stronger influence.

**9.** On days with poor sleep (<6 hrs), do users burn fewer calories even if heart rate stays high?”
Calories vs Sleep (Poor Sleep < 6 Hours): Looking across the dataset, many users who slept less than 6 hours (≈ 350 minutes or less) still burned a fairly high number of calories (e.g., Id 5553957443 on 2016-04-14 burned 2324 calories with only 357 minutes of sleep). This suggests that activity level and energy expenditure are not always directly tied to sleep duration—users may still engage in intense activity despite poor sleep.

Heart Rate Response: Average heart rate values remain in a moderate-to-high range (60–105 bpm) even on low-sleep days. For example, Id 4558609924 on 2016-05-08 had only 123 minutes of sleep, yet their heart rate averaged ~105 bpm. This points to a physiological stress response: even though calories burned weren’t drastically lower, the heart worked harder with insufficient recovery.
Balanced Sleep Days: On days with more balanced sleep (closer to 6 hours), users like Id 8792009665 (2016-04-30) showed 343 minutes of sleep, 2896 calories, and avg HR ~81 bpm. These numbers indicate a healthier balance—sufficient calories burned without excessive strain on the heart.

Key Insight : The data highlights a critical wellness trade-off. Poor sleep doesn’t always mean fewer calories burned. However, sustained high heart rates with low sleep may reflect fatigue, stress, or reduced recovery. For Bellabeat, this can translate into product recommendations such as sending alerts when a user shows high activity + high heart rate + poor sleep, nudging them toward rest and recovery guidance.

**10.** Find days where users burned more calories than the 95th percentile of all users.
After cleaning the dataset by removing duplicate entries, we are left with 62 unique daily records of user calorie expenditure. The analysis reveals that the 95th percentile of calories burned is approximately 4547 calories. This value acts as a statistical benchmark—days that exceed this threshold represent the top 5% of calorie-burning activity levels across all users.
Key Observations:
a. Rarity of Extreme Activity:
Out of 62 days, only 4 days surpassed the 95th percentile, which is just about 6% of the dataset. This highlights that exceptionally high-calorie burns are rare events rather than part of the normal activity pattern.

b. Possible Lifestyle Factors:
These spikes could correspond to:
Intense exercise routines (e.g., long runs, gym sessions, or sports).
Special events such as marathons, tournaments, or outdoor adventures.
Unique user lifestyle differences, where certain individuals consistently show higher physical engagement.

c. User-Specific Behavior:
The recurrence of some user IDs among the top-calorie-burning days suggests that a small group of highly active users drives these outliers. This points to the presence of distinct clusters within the user base—average users versus highly active ones.

d. Business Implications (for wellness device companies like Bellabeat):
Targeting power users: Marketing campaigns can highlight advanced features (performance tracking, detailed workout logs) for highly active individuals.
Encouraging moderate users: Average users may benefit from challenges or reminders that gradually push them toward higher engagement.
Behavior segmentation: Recognizing that only a small fraction of users engage in extreme activity can help in designing personalized insights and recommendations.

📈 Insight Summary: The cleaned dataset emphasizes that while the majority of users fall within typical daily calorie expenditure, there exists a small segment that consistently achieves exceptional activity levels. These high-calorie-burning days stand out as outliers but valuable signals—they reveal not just rare performance but also opportunities for personalization, motivation, and user retention strategies in wellness tracking applications.


GENERALIZED RECOMMENDATIONS:

**Encourage weekend activity → push notifications or challenges for Saturday/Sunday.**
**Highlight link between exercise & sleep quality in Bellabeat app/marketing.**
**Gamify self-tracking (badges/rewards for consistent weight and sleep logging).**

**Personalized insights dashboards in Bellabeat products to show users progress against health guidelines (10,000 steps/day, 7–8 hrs sleep, etc).**
