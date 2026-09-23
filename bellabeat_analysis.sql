-- Upload the dataset used for analysis

-- Compare Calories data between daily_activity_2 and daily_calories2
-- to verify data completeness
SELECT da.Id, da.Calories, dc.Calories

FROM `casestudy-bellabeat-509507.fitabase_data_2.daily_activity_2` as da
FULL JOIN `casestudy-bellabeat-509507.fitabase_data_2.daily_calories2` as dc
ON da.Id=dc.Id AND da.ActivityDate= dc.ActivityDay;
