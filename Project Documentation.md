# Bellabeat Smart Device Usage Analysis
## A Data Analytics Case Study and Marketing Recommendation

**Project Type:** Google Data Analytics Professional Certificate Capstone  
**Role:** Data Analyst  
**Company:** Bellabeat  
**Primary Product:** Bellabeat Leaf  
**Author:** [Your name — optional]  
**Completion Date:** [Month Year — optional]  
**Primary Tools:** Google BigQuery and SQL  
**Visualization Tools:** [Enter the tool or tools actually used]

---

## 📌 1. Project Overview

This project analyzes Fitbit smart-device usage data to identify activity patterns and develop data-driven marketing recommendations for Bellabeat, a wellness technology company.

The analysis focuses on recorded activity minutes, daily steps, activity distance, relationships between activity measures, and differences in activity patterns between participants. Sleep and weight data were also incorporated into the data preparation process where matching records were available.

The objective was to translate observed user behavior into an actionable marketing recommendation for the Bellabeat Leaf, emphasizing everyday movement and sustainable wellness habits.

The project follows the main stages of the data analytics process: data inspection, preparation, validation, transformation, exploratory analysis, interpretation, and business recommendation development.

## 🎯 2. Business Task

Bellabeat wants to better understand how consumers use non-Bellabeat smart devices. Understanding these usage patterns may help the company develop marketing strategies that align with consumers' activity habits and wellness needs.

The business task was to analyze available Fitbit usage data and identify behavioral patterns that could inform Bellabeat's marketing strategy.

### Objectives

- Identify trends in recorded smart-device usage.
- Understand users' activity patterns.
- Examine the relationships between daily steps and activity measures.
- Explore variation in activity levels between participants.
- Apply the findings to a Bellabeat product.
- Develop a marketing recommendation supported by the analysis.

### Key Questions

1. What are the main activity patterns among Fitbit users?
2. How do activity levels vary between participants?
3. How are daily steps related to different activity measures?
4. What opportunities can these behavioral patterns provide for Bellabeat?
5. How can the findings inform Bellabeat's marketing strategy?

## 📊 3. Dataset and Data Sources

**Dataset:** Fitbit Fitness Tracker Data  
**Source:** [Kaggle — Fitbit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit)

The dataset contains smart-device usage records from Fitbit users. The tables examined in this project included daily activity, daily calories, weight logs, and sleep records.

### Relevant data fields

| Data category | Examples of fields | Purpose |
|---|---|---|
| Participant identification | Id | Identify participants and connect records |
| Dates | ActivityDate, sleep date, weight-log date | Align observations by date |
| Daily activity | TotalSteps, TotalDistance, Calories | Examine overall activity patterns |
| Activity distance | VeryActiveDistance, ModeratelyActiveDistance, LightActiveDistance, SedentaryActiveDistance | Compare distance across activity categories |
| Activity minutes | VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes | Examine the distribution of recorded activity time |
| Sleep | TotalMinutesAsleep, TotalTimeInBed | Incorporate available sleep information |
| Weight | WeightKg, BMI | Retain weight-related information where available |

Not every source table contained all fields, and the number of participants differed across datasets.

### Dataset coverage

The following counts were obtained from the SQL inspection of distinct participant IDs.

| Dataset | Distinct participant IDs |
|---|---:|
| Daily activity dataset 1 | 35 |
| Daily activity dataset 2 | 33 |
| Weight-log dataset 1 | 11 |
| Weight-log dataset 2 | 8 |
| Daily sleep dataset 1 | 23 |
| Daily sleep dataset 2 | 24 |
| Final cleaned dataset | 35 |

These figures represent distinct participant IDs, not the total number of records. The counts also do not indicate that every participant had observations for every date or every data category.

The weight and sleep datasets had more limited participant coverage than the daily activity data. Therefore, findings based on these sources would require additional consideration of data availability.

## 🧹 4. Data Preparation and Cleaning

Google BigQuery and SQL were used to inspect, validate, combine, and transform the source tables before analysis.

The purpose of these steps was to improve consistency, understand data coverage, and create datasets suitable for exploratory analysis.

### 4.1 Data inspection

The source tables were inspected to understand their structure, available fields, data types, and participant coverage.

This initial inspection helped establish which tables contained relevant activity, sleep, calorie, and weight information.

### 4.2 Duplicate checks

Duplicate checks were performed on the daily activity tables using grouping and record counts. Similar checks were also carried out on other relevant datasets.

The SQL comments recorded no duplicates in the daily activity tables examined.

A duplicate check identifies repeated records according to the fields used in the check. It does not automatically prove that all datasets have unique participant-date combinations after integration.

### 4.3 Missing-value checks

Null-value checks were performed on relevant fields, including daily activity and weight-log data.

The daily activity check was documented as having no null values in the inspected table. Weight-log data was checked separately because its coverage and available fields differed from the activity data.

These results should be interpreted at the table and field level rather than as evidence that every field across every source dataset was complete.

### 4.4 Date and data-type standardization

Date-related fields were converted into appropriate formats to support consistent date comparisons and joins.

For example, date strings in the weight-log and minute-level sleep data were parsed into datetime values and converted to dates where needed.

Standardizing dates was important because records from different sources could only be aligned reliably when their date values used compatible formats.

### 4.5 Participant ID checks

The participant IDs were inspected for consistency. The SQL check found that the inspected IDs contained 10 digits.

This check helped identify whether participant identifiers followed a consistent format across the records examined.

### 4.6 Data integrity: comparing calorie records

The SQL analysis compared the `Calories` values from `daily_activity_2` and `daily_calories2`, matching records by participant ID and activity date.

A full join was used to compare the corresponding records, including records that did not have a match on both sides.

This check supported the assessment of consistency between related data sources before selecting the main daily activity table for subsequent analysis.

### 4.7 Combining daily activity datasets

The two daily activity datasets were combined using `UNION ALL` to create a consolidated activity table.

`UNION ALL` retains all rows from both sources, including any overlapping records. It does not automatically remove duplicates.

The consolidated activity table was used as the main foundation for further data preparation and analysis.

### 4.8 Combining weight-log datasets

The weight-log datasets were combined into a single table using `UNION ALL`.

The resulting table retained available weight-related records for subsequent integration with daily activity data.

### 4.9 Integrating weight information

A left join was used to connect the consolidated daily activity table with weight-log information using participant ID and date.

The resulting table retained the activity records on the left side of the join while adding matching `WeightKg` and `BMI` values where available.

Because weight records covered fewer participants and dates, some activity records did not have corresponding weight information. Missing matches should not be interpreted as zero weight or zero BMI.

### 4.10 Validating distance measures

The SQL compared `TotalDistance` with the sum of the recorded distance categories:

- `VeryActiveDistance`
- `ModeratelyActiveDistance`
- `LightActiveDistance`
- `SedentaryActiveDistance`

The values were generally similar, with some small differences.

`TotalDistance` was retained as the primary overall distance measure for the analysis. The comparison was used as a consistency check, rather than as a reason to replace the original field with the sum of its components.

The SQL also inspected `TrackerDistance` and `LoggedActivitiesDistance` for records where `LoggedActivitiesDistance` was not zero.

### 4.11 Preparing sleep data

The sleep source data included minute-level records. These records were aggregated by participant and date to produce daily sleep-related measures.

The aggregation included:

- `TotalMinutesAsleep`, calculated by counting records with a value of 1.
- `TotalTimeInBed`, calculated by counting the minute-level records in the relevant grouped data.
- `TotalSleepRecords`, set to `NULL` in this aggregated table because that aggregation did not provide a comparable sleep-record count.

The aggregated sleep tables were combined using `UNION ALL`.

The resulting sleep data was then left-joined to the activity and weight table using participant ID and date.

This approach retained the activity records even when matching sleep information was unavailable.

**Data integration consideration:** `UNION ALL` preserves rows from both sleep sources. If the sources contain overlapping participant-date observations, the combined table may contain multiple records for the same participant and date. The join and aggregation logic should therefore be interpreted with that possibility in mind. The SQL workflow summarized here does not establish that every possible overlap was removed.

### 4.12 Creating the cleaned dataset

A cleaned dataset was created by selecting relevant fields from the integrated data.

The resulting dataset included:

- Participant ID and activity date.
- Day name and day number.
- Total steps and total distance.
- Distance by activity intensity.
- Activity minutes by category.
- Calories.
- Sleep measures.
- Weight and BMI where available.

A `day_name` field was derived from the activity date to support weekday comparisons.

A `TotalActiveMinutes` field was calculated by adding Very Active, Fairly Active, Lightly Active, and Sedentary Minutes.

**Important definition:** Because this calculation includes `SedentaryMinutes`, the resulting field represents the sum of the recorded minute categories. It should not be interpreted as exercise time alone.

### 4.13 Reshaping data with UNPIVOT

The distance and activity-minute measures were transformed from wide format into long format using SQL `UNPIVOT`.

For distance, the transformation created fields identifying the activity category and its corresponding distance value.

For activity minutes, a similar transformation created fields identifying the activity category and its corresponding minutes.

A numeric day-of-week field was also derived, with Monday represented as 1 and Sunday as 7.

These transformations made it easier to group, compare, and visualize the different activity categories and weekday patterns.

## 🔎 5. Exploratory Data Analysis

After preparing the data, SQL queries were used to examine activity patterns and relationships between recorded measures.

The analysis focused on the following areas.

### 5.1 Activity minutes by category

Average minutes were examined across Very Active, Fairly Active, Lightly Active, and Sedentary categories.

The objective was to understand how recorded time was distributed among the activity classifications.

### 5.2 Activity distance by category

Average distance was examined across the available activity-distance categories and days of the week.

This comparison helped identify which distance category represented the largest share of the recorded active-distance measures.

### 5.3 Daily steps and distance

Average Total Steps and Total Distance were examined across participants.

This analysis helped illustrate differences in recorded activity levels and provided context for the relationship between steps and distance.

### 5.4 Correlation analysis

SQL correlation calculations were used to examine the relationship between `TotalSteps` and:

- `TotalDistance`
- `VeryActiveDistance`
- `ModeratelyActiveDistance`
- `LightActiveDistance`
- `SedentaryActiveDistance`
- `SedentaryMinutes`

The results were organized into a format suitable for comparing the relationships across measures.

Correlation describes the direction and strength of a relationship between two variables. It does not establish causation.

### 5.5 Weekday comparisons

Average activity minutes and distance were compared by day of the week.

The objective was to explore whether the observed activity patterns differed consistently between weekdays and weekends.

## 💡 6. Key Findings

The following findings are the main results selected for the project README and marketing recommendation.

### Finding 1: Sedentary activity was prominent

Participants recorded substantially more Sedentary Minutes than minutes in the other activity categories.

**Interpretation:** The observed pattern suggests an opportunity to explore marketing messages that encourage everyday movement, rather than focusing exclusively on intense exercise.

Sedentary Minutes should be interpreted as a device-recorded activity classification. The data does not establish that participants continuously sat throughout every recorded sedentary minute.

**[INSERT IMAGE 1: Sedentary Activity visualization here]**

*Suggested image filename: `sedentary_activity.png`*

### Finding 2: Light Active Distance was the largest recorded active-distance category

Light Active Distance was the largest of the recorded active-distance categories.

**Interpretation:** Everyday movement is a relevant theme for a wellness campaign, alongside messages about more intense activity.

This finding concerns the relative size of the recorded distance categories. It does not mean that the dataset directly identified the intensity of every individual step.

**[INSERT IMAGE 2: Activity Distance visualization here]**

*Suggested image filename: `activity_distance.png`*

### Finding 3: Active-distance measures were positively associated with Total Steps

The correlation analysis found positive relationships between Total Steps and the three active-distance measures.

| Activity-distance measure | Correlation with Total Steps |
|---|---:|
| Very Active Distance | 0.738 |
| Light Active Distance | 0.727 |
| Moderately/Fairly Active Distance | 0.519 |

Very Active Distance showed the strongest correlation with Total Steps, followed closely by Light Active Distance.

**Interpretation:** Participants with higher recorded step counts tended to have higher values for these active-distance measures.

The strongest correlation does not mean that Very Active Distance was the largest distance category. Correlation strength and the amount recorded are different measures.

**[INSERT IMAGE 3: Steps vs. Activity Distance visualization here]**

*Suggested image filename: `steps_activity_distance.png`*

### Finding 4: Sedentary Minutes had a weak negative relationship with Total Steps

The correlation between Total Steps and Sedentary Minutes was:

**r = -0.20**

This indicates a weak negative relationship between the two measures.

**Interpretation:** Higher step counts tended to be associated with somewhat lower sedentary-minute values in the examined records, but the relationship was weak.

This result does not establish that reducing sedentary time will automatically increase step counts, or that one measure causes changes in the other.

### Finding 5: Activity levels varied between participants

Average daily steps differed across individual participants.

**Interpretation:** An overall average does not necessarily represent every user's activity pattern. The variation suggests that different users may have different activity habits.

A future marketing campaign could test whether different messages resonate with audiences exhibiting different recorded activity patterns.

**[INSERT IMAGE 4: Average Daily Steps by Participant visualization here]**

*Suggested image filename: `participant_variation.png`*

### Additional observation: Weekday patterns

The weekday comparisons did not reveal a strong, consistent overall weekday-versus-weekend difference in the activity measures examined.

This observation should be interpreted within the limitations of the available participants and recorded dates. It does not establish that all Fitbit users have the same activity patterns throughout the week.

## 🏷️ 7. Applying the Findings to Bellabeat

The findings were applied to the Bellabeat Leaf as a potential marketing touchpoint.

The analysis suggests an opportunity to communicate the importance of everyday movement and sustainable activity habits rather than focusing only on intense exercise.

This application is a marketing recommendation based on observed Fitbit usage patterns. It does not establish that Bellabeat Leaf users behave in the same way as the Fitbit participants, or that the product itself caused the observed patterns.

The data informs a proposed marketing direction; it does not directly measure Bellabeat product performance or consumer demand.

## 📣 8. Marketing Recommendation

### Campaign concept: Move More, Little by Little

**Core message:**

> “Your wellness isn't only your workout. Every movement throughout your day matters.”

The proposed campaign emphasizes small, consistent movements throughout the day and encourages consumers to consider everyday movement as part of their broader wellness habits.

### Why this recommendation fits the findings

The campaign is informed by three main observations:

1. Sedentary Minutes were prominent in the recorded activity data.
2. Light Active Distance was the largest recorded active-distance category.
3. Activity levels varied between participants.

Together, these observations support exploring a message that makes everyday movement feel relevant and achievable, rather than presenting wellness as dependent only on intense exercise.

The correlation findings provide additional context about the relationship between steps and activity-distance measures. They do not prove that the proposed campaign will change user behavior.

### Suggested campaign messages

The campaign could encourage consumers to:

- Become more aware of sedentary periods.
- Add small amounts of movement throughout the day.
- Build consistent activity habits.
- Recognize that everyday movement is part of a broader wellness routine.

### Proposed use of the Bellabeat Leaf

The Bellabeat Leaf could serve as the product focus for communicating this wellness message.

Any specific claims about product features or tracking capabilities should be checked against official Bellabeat product information before being used in campaign materials. The Fitbit dataset itself does not validate the Leaf's capabilities or performance.

### Campaign evaluation

The campaign should be tested rather than assumed to be successful.

Potential measures include:

- Campaign reach and engagement.
- Click-throughs or other relevant response measures.
- Product-page visits or inquiries.
- Changes in engagement over time, where suitable data is available.

Where practical, results could be compared with a baseline or comparison group. Bellabeat could then use the evidence to refine the campaign.

The analysis does not establish that the recommendation will increase sales, engagement, or physical activity. Those outcomes require separate measurement.

## 🚀 9. Recommended Next Steps

Based on the findings, the following actions are proposed:

1. Develop the “Move More, Little by Little” campaign concept.
2. Test different messages for audiences with different activity patterns.
3. Use the selected Bellabeat product as the campaign touchpoint.
4. Define measurable campaign objectives before launch.
5. Measure engagement and customer response.
6. Refine the marketing approach based on observed results.

The proposed process is:

**Test → Measure → Learn → Refine**

These are recommendations for future action, not outcomes already demonstrated by the Fitbit analysis.

## 🛠️ 10. Tools and Technical Skills

### Google BigQuery and SQL

Used for:

- Inspecting source tables and their structure.
- Checking duplicate records and missing values.
- Standardizing date formats.
- Comparing related datasets for consistency.
- Combining activity, weight, and sleep data.
- Joining records using participant IDs and dates.
- Aggregating minute-level sleep records.
- Creating calculated fields and a cleaned dataset.
- Reshaping data using `UNPIVOT`.
- Calculating averages and correlations.
- Preparing results for interpretation and visualization.

### Visualization and spreadsheet tools

**[Complete this section with the tools you actually used for this project.]**

- Visualization tool: [Tool name and purpose, if used]
- Spreadsheet tool: [Tool name and purpose, if used]

### GitHub

Used to document and present the project, including the README, SQL scripts, visualizations, and presentation materials.

## 📁 11. Project Deliverables

The project repository is intended to contain the following deliverables, subject to the files actually uploaded:

- **README.md:** Project overview, methodology, findings, and recommendations.
- **SQL scripts:** Data preparation, validation, transformation, and analysis queries.
- **Visualizations:** Charts supporting the selected findings.
- **Presentation PDF:** A summary of the analysis and results.

**Repository:** [Bellabeat Case Study on GitHub](https://github.com/setiawanmarceline/bellabeat_case_study)

### Project file structure

**[Update this section if your actual filenames or folders differ.]**

```text
bellabeat_case_study/
├── README.md
├── SQL/
│   ├── [actual SQL script filename]
│   ├── [actual SQL script filename]
│   └── [actual SQL script filename]
├── Presentation/
│   └── Fitabase_Analysis_Result_Presentation.pdf
└── Visualizations/
    ├── sedentary_activity.png
    ├── activity_distance.png
    ├── steps_activity_distance.png
    └── participant_variation.png
```

## ⚠️ 12. Limitations

Several limitations should be considered when interpreting the results.

### Limited participant coverage

The dataset contains a limited group of Fitbit users. Their behavior may not represent Bellabeat's broader target customer population.

### Differences in data availability

The activity, sleep, and weight tables contain different numbers of participants and records. Weight and sleep information was not available for every participant or date.

### Potential record overlap

`UNION ALL` retains records from both source tables. If overlapping observations remain, they can affect subsequent joins and aggregations. Results should be interpreted with this integration consideration in mind.

### Device-recorded classifications

Activity and sedentary minutes reflect the classifications available in the source data. They do not provide a complete account of every user's behavior or prove that a participant was continuously sitting during every sedentary minute.

### Correlation does not establish causation

The correlation results identify associations between recorded measures. They do not prove that changing one measure will cause a change in another.

### No direct Bellabeat business outcomes

The dataset does not contain Bellabeat sales, campaign performance, or customer conversion data. Consequently, the analysis cannot demonstrate that the proposed campaign will increase sales or engagement.

### Time-period limitations

The dataset represents a specific collection period and may not reflect current consumer behavior.

## 📚 13. Conclusion

This project used SQL in Google BigQuery to prepare, integrate, validate, and analyze Fitbit smart-device usage data.

The selected findings showed that Sedentary Minutes were prominent, Light Active Distance was the largest recorded active-distance category, active-distance measures were positively associated with Total Steps, and Sedentary Minutes had a weak negative relationship with Total Steps. Average daily steps also varied between participants.

These observations informed the proposed “Move More, Little by Little” campaign for the Bellabeat Leaf, emphasizing everyday movement and sustainable wellness habits.

The recommendation is a proposed marketing direction grounded in the observed data, not a proven business outcome. Further testing and measurement would be needed to determine whether the campaign resonates with Bellabeat's target audience and delivers meaningful results.

## 🙏 14. Acknowledgment

This project was completed as part of the Google Data Analytics Professional Certificate capstone/case study.

The analysis uses the publicly available [Fitbit Fitness Tracker Data on Kaggle](https://www.kaggle.com/datasets/arashnic/fitbit).

The purpose of the project was to apply data analytics techniques to a business question, interpret the results responsibly, and translate the findings into a practical marketing recommendation.
