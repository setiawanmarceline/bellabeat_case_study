# Bellabeat Case Study: How Can a Wellness Technology Company Improve Its Marketing Strategy?

**Author:** Marceline Setiawan  
**Project Completion Date:** September 2026 
**Tools Used:** Google BigQuery, SQL  
**Dataset:** Fitbit Fitness Tracker Data  
**Project Type:** Google Data Analytics Capstone Project

---

## 1. Project Overview

This project analyzes Fitbit fitness tracker data to identify trends in users’ activity patterns and translate the findings into actionable marketing recommendations for Bellabeat, a wellness technology company.

## 1. Project Overview

This project analyzes Fitbit fitness tracker data to identify patterns in users' daily activity and translate the findings into marketing recommendations for Bellabeat, a wellness technology company focused on products for women.

The project covers the data analytics workflow, including data integrity checks, data cleaning, data transformation, data validation, SQL analysis, and data visualization.

Google BigQuery was used to process and analyze the data using SQL. The analysis focused on daily steps, activity distance, activity duration, sedentary activity, and differences in activity patterns across participants. Sleep and weight-log data were also explored and integrated where appropriate.

The final objective was to translate the analytical findings into a practical, evidence-informed marketing recommendation for Bellabeat, using Bellabeat Leaf as the selected product.

**Project type:** Data Analytics Case Study  
**Industry:** Wellness Technology  
**Primary tool:** Google BigQuery  
**Query language:** SQL  
**Selected product:** Bellabeat Leaf  
**Campaign concept:** Move More, Little by Little

## 2. Business Task

### Business question

How can Bellabeat use smart device usage trends to develop relevant marketing strategies that encourage everyday movement and support healthier routines?

The project aims to understand how users interact with fitness tracking devices and identify behavioral patterns that could inform Bellabeat's marketing strategy.

The analysis addresses the following questions:

1. How is recorded daily activity distributed across different activity-intensity categories?
2. Which activity-distance categories represent the largest recorded distances?
3. How are daily steps associated with different activity-distance measures?
4. What relationship exists between sedentary activity minutes and daily steps?
5. How do average daily steps and activity patterns vary across individual participants?
6. How can these findings inform a marketing recommendation for Bellabeat?

## 3. Business Context

Bellabeat develops wellness products and digital experiences intended to support women's well-being.

For this case study, Fitbit fitness tracker data serves as a source of behavioral insights. By examining recorded activity patterns, Bellabeat can explore potential opportunities for wellness communication and product marketing.

The Fitbit dataset does not directly represent Bellabeat customers. Therefore, its findings should be treated as a starting point for developing and testing marketing ideas, rather than definitive evidence of Bellabeat customer behavior.

## 4. Data Sources and Structure

The project used datasets stored in Google BigQuery under the project `casestudy-bellabeat-509507`.

The data was organized into source datasets and a combined analytical dataset.

### 4.1 Daily Activity Data

The daily activity tables contained measurements such as:

- `Id`
- `ActivityDate`
- `TotalSteps`
- `TotalDistance`
- `TrackerDistance`
- `LoggedActivitiesDistance`
- `VeryActiveDistance`
- `ModeratelyActiveDistance`
- `LightActiveDistance`
- `SedentaryActiveDistance`
- `VeryActiveMinutes`
- `FairlyActiveMinutes`
- `LightlyActiveMinutes`
- `SedentaryMinutes`
- `Calories`

These variables were the primary source for the activity analysis.

### 4.2 Weight-Log Data

The weight-log tables included:

- `Id`
- `Date`
- `WeightKg`
- `WeightPounds`
- `Fat`
- `BMI`
- `IsManualReport`
- `LogId`

Weight-log data was examined, standardized, combined, and joined to daily activity data. Weight and BMI were retained in the cleaned dataset as supplementary variables.

### 4.3 Sleep Data

The sleep datasets contained daily sleep measurements and minute-level sleep records.

Relevant fields included:

- `Id`
- `SleepDate`
- `TotalSleepRecords`
- `TotalMinutesAsleep`
- `TotalTimeInBed`

The project transformed minute-level sleep data into daily measurements and combined it with existing daily sleep records.

### 4.4 Dataset Coverage

The initial unique-participant checks returned different counts across the source datasets:

| Dataset | Source dataset 1 | Source dataset 2 |
|---|---:|---:|
| Daily activity | 35 | 33 |
| Weight log | 11 | 8 |
| Daily sleep | 23 | 24 |

These differences indicate that the source tables did not contain identical participant coverage. In particular, weight-log data was available for fewer participants than daily activity data.

The combined analytical dataset contained 35 distinct participant IDs according to the final participant-count query.

The differences in coverage were considered when deciding which variables and tables were suitable for the analysis.

## 5. Data Preparation and Cleaning

Data preparation was performed in Google BigQuery using SQL. The objective was to understand the source data, assess data quality, standardize relevant fields, and create an analytical dataset suitable for subsequent analysis.

### 5.1 Data Integrity Checks

The first step was to inspect the source tables and compare relevant measurements across datasets.

A `FULL JOIN` was used to compare calorie values between `daily_activity_2` and `daily_calories2`, matching records by participant ID and activity date.

The comparison was intended to assess whether the calorie measurements were consistent across the two sources and to identify records that did not match.

The source tables were also queried to inspect their contents and understand their structure.

### 5.2 Duplicate Checks

Duplicate checks were performed on the daily activity tables using `GROUP BY ALL` and `HAVING COUNT(*) > 1`.

The queries returned no duplicate rows for the two daily activity tables examined.

Similar checks were reported for the other datasets.

This step helped establish whether identical records were present before combining the data.

### 5.3 Data Type Conversion

Some date fields were stored as strings rather than native date values.

To standardize these fields, `PARSE_DATETIME` was used to interpret the original date-time strings, followed by `DATE` to extract the date component.

This transformation was applied to the relevant weight-log and minute-level sleep tables using `CREATE OR REPLACE TABLE`.

Standardizing the date fields enabled consistent date-based filtering, grouping, and joining.

### 5.4 Missing-Value Checks

`COUNTIF` queries were used to count null values in the daily activity fields, including participant IDs, activity dates, distance measures, activity minutes, steps, and calories.

The recorded result for the examined `daily_activity` table indicated that these fields contained no null values.

A separate null-check query was also prepared for the weight-log fields.

The daily activity null-check result should not automatically be generalized to every other table, because missing-value patterns can differ between datasets.

### 5.5 Participant ID Checks

The number of distinct participant IDs was calculated for daily activity, weight-log, and sleep tables.

This helped assess dataset coverage and understand whether supplementary data was available for all participants.

A separate query checked the length of participant IDs in the combined activity and weight-log table. The IDs were expected to contain 10 digits, and the check was used to identify any records that did not meet this requirement.

### 5.6 Data Cleaning Outcome

These checks helped establish a clearer understanding of the source data before the transformation and analysis stages.

The process included duplicate checking, missing-value assessment, data type standardization, participant coverage checks, and inspection of the relationships between selected tables.

## 6. Data Transformation and Integration

Data transformation was a substantial part of this project. The original tables had different structures and levels of detail, so they needed to be prepared and organized before being used for analysis.

### 6.1 Combining Daily Activity Data

The two daily activity tables were combined using `UNION ALL` to create a consolidated activity table:

`daily_activity_combined`

`UNION ALL` appends records from both source tables and retains all rows, including any repeated rows. Duplicate checks were therefore important before the combined table was used.

The combined activity table provided a single source for subsequent processing.

### 6.2 Combining Weight-Log Data

The two weight-log tables were combined using `UNION ALL` to create:

`weightlog_combined`

This consolidated the available weight-log records into one table.

### 6.3 Joining Activity and Weight Data

A `LEFT JOIN` was used to combine daily activity data with weight-log measurements.

The join matched records using participant ID and date.

The query retained all records from the daily activity table while adding `WeightKg` and `BMI` where matching weight-log records were available.

A left join was appropriate because weight-log records were much less complete than activity records. It allowed the main activity dataset to remain available even when a participant did not have a corresponding weight entry for that day.

The resulting table was named:

`dailyactivity_weightlog_combined`

### 6.4 Transforming Minute-Level Sleep Data

The minute-level sleep table was transformed into daily sleep measurements.

The query grouped the records by participant ID and sleep date and calculated:

- `TotalMinutesAsleep`: the count of records where `value = 1`.
- `TotalTimeInBed`: the count of minute-level records for each participant and date.
- `TotalSleepRecords`: set to `NULL` because this aggregation did not calculate the original sleep-record count.

This produced daily sleep measurements from the minute-level data.

The resulting daily sleep table was then combined with the existing daily sleep table using `UNION ALL`.

The consolidated table was named:

`daysleep_combined`

### 6.5 Integrating Sleep and Activity Data

The consolidated daily sleep table was joined to the activity-and-weight table using participant ID and date.

A `LEFT JOIN` was used to retain the activity records while adding `TotalMinutesAsleep` and `TotalTimeInBed` when a matching sleep record existed.

This created:

`combined_data_raw`

The join allowed activity, weight, and sleep measurements to be examined within a common daily dataset, while retaining the possibility of missing supplementary measurements.

### 6.6 Creating the Cleaned Analytical Dataset

A cleaned analytical table was created from `combined_data_raw`:

`fitabase_cleaned_data`

The table selected the variables needed for the analysis and introduced a derived weekday field.

The transformations included:

- Retaining participant IDs and activity dates.
- Generating `day_name` using `FORMAT_DATE('%A', ActivityDate)`.
- Retaining daily steps and total distance.
- Retaining the available activity-distance measures.
- Retaining activity-duration measures.
- Calculating `TotalActiveMinutes` as the sum of very active, fairly active, lightly active, and sedentary minutes.
- Retaining daily sleep measures where available.
- Retaining calories, weight, and BMI where available.

The derived weekday field supported comparisons across days of the week. The calculated total-minutes field provided a combined duration measure for further exploration.

Because `TotalActiveMinutes` includes `SedentaryMinutes`, it represents the sum of the recorded activity-minute categories rather than active exercise time alone.

### 6.7 Reshaping Data Using UNPIVOT

The cleaned dataset stored activity measures in separate columns. For some visualizations, a long-format structure was more suitable.

SQL `UNPIVOT` queries were used to reshape distance and duration measures.

**Distance transformation**

The distance fields were converted into two columns:

- `activity_level`
- `distance_km`

The activity levels were labeled as Very Active, Moderately Active, Light Active, and Sedentary Active.

**Activity-duration transformation**

The minute fields were converted into:

- `activity_level`
- `minutes`

The activity levels were labeled as Very Active, Moderately Active, Light Active, and Sedentary Active.

The queries also derived `day_number` from the activity date, using Monday as 1 and Sunday as 7.

These transformations changed the structure of the data without changing the underlying meaning of the individual activity measures. The resulting long-format data was more convenient for comparing activity categories in visualizations.

## 7. Data Validation

Data validation was used to assess the consistency and suitability of the prepared dataset for analysis.

### 7.1 Distance Consistency Check

The project compared `TotalDistance` with the sum of the four recorded activity-intensity distance measures:

- `VeryActiveDistance`
- `ModeratelyActiveDistance`
- `LightActiveDistance`
- `SedentaryActiveDistance`

The comparison also included `TrackerDistance` and `LoggedActivitiesDistance`.

The query examined records where `LoggedActivitiesDistance` was not zero.

The recorded observation was that the distance values were generally similar, with small differences.

Based on this check, `TotalDistance` was retained as the primary overall distance measure.

The comparison was a consistency check rather than proof that the distance fields were identical or interchangeable.

### 7.2 Validation Considerations

The preparation and validation work supported the use of the consolidated activity data for the main analysis.

However, some supplementary tables had different participant coverage, and the left joins could produce missing sleep or weight values where no matching record existed.

These differences were considered when interpreting the dataset and determining which measures could support the main business questions.

## 8. Exploratory Data Analysis

The exploratory analysis used the cleaned analytical dataset to examine daily activity patterns, differences across activity categories, participant-level variation, and relationships between steps and other activity measures.

### 8.1 Number of Participants

The final cleaned analytical dataset contained 35 distinct participant IDs according to the participant-count query.

This established the number of distinct participants represented in the analytical table, although the amount of data available for individual variables could vary.

### 8.2 Average Distance by Activity Intensity and Day

The analysis calculated average distances for each activity-intensity category by day of the week.

The query used weekday numbering and calculated average distance for Very Active, Moderately Active, Light Active, and Sedentary Active Distance.

**Finding:** Light Active Distance was generally the largest among the recorded active-distance categories.

The weekday comparison did not show a strong pattern of differences between weekend and weekday distances.

**Interpretation:** Light-intensity movement represented a substantial portion of recorded active distance, while the weekday comparison did not suggest a strong recurring weekend-versus-weekday pattern.

### 8.3 Average Activity Minutes by Day

Average minutes were calculated for each activity-intensity category by day of the week.

The comparison included Very Active, Fairly Active, Lightly Active, and Sedentary Minutes.

**Finding:** Users recorded substantially more sedentary activity time than time in the other activity categories.

**Interpretation:** Recorded sedentary activity time was a prominent feature of the observed daily activity patterns.

This finding suggests an opportunity to explore messaging that encourages awareness of movement throughout daily routines. Sedentary minutes should not automatically be interpreted as continuous sitting time.

### 8.4 Average Activity Minutes by Participant

Average minutes for each activity category were calculated for individual participant IDs.

This analysis allowed the distribution of activity time to be examined at the participant level rather than relying solely on an overall average.

It provided supplementary context for understanding how recorded activity patterns could differ across users.

### 8.5 Average Steps and Distance by Participant

The analysis calculated average daily steps and average daily distance for each participant.

The results were ordered by average daily steps.

This made it possible to compare participants and identify differences in their recorded activity levels.

**Interpretation:** Average daily steps varied across participants, showing that an overall average does not fully describe every individual's activity pattern.

### 8.6 Correlation Between Steps and Activity Distance

The SQL `CORR` function was used to calculate Pearson correlation coefficients between Total Steps and selected distance measures.

The analysis examined:

- Total Distance.
- Very Active Distance.
- Moderately Active Distance.
- Light Active Distance.
- Sedentary Active Distance.

The correlation output was also reshaped using `UNPIVOT` to produce a relationship-and-correlation structure suitable for visualization.

The established results for the principal active-distance comparisons were:

| Relationship | Pearson correlation |
|---|---:|
| Total Steps vs Very Active Distance | 0.738 |
| Total Steps vs Light Active Distance | 0.727 |
| Total Steps vs Moderately/Fairly Active Distance | 0.519 |

All three relationships were positive. Very Active Distance had the strongest correlation with Total Steps, followed closely by Light Active Distance.

**Interpretation:** Higher recorded active-distance values tended to be associated with higher step counts.

The size of an activity-distance category and its correlation with steps are different measures. Light Active Distance could be the largest recorded active-distance category even though Very Active Distance had a slightly stronger correlation with Total Steps.

### 8.7 Correlation Between Steps and Sedentary Minutes

A separate correlation query examined Total Steps and Sedentary Minutes.

The established correlation was **-0.20**.

**Interpretation:** Sedentary Minutes had a weak negative relationship with Total Steps. Higher recorded sedentary minutes tended to be associated with slightly lower step counts, but the relationship was weak.

This association does not prove that sedentary activity causes lower step counts.

## 9. Key Findings

The main findings can be summarized as follows.

**Finding 1 — Sedentary activity was prominent.**

Users recorded substantially more sedentary activity time than very active, fairly active, or lightly active minutes.

**Finding 2 — Light Active Distance was the largest recorded active-distance category.**

Light Active Distance represented the largest category among the recorded active-distance measures in the distance comparison.

**Finding 3 — Active-distance measures were positively associated with steps.**

Very Active Distance had the strongest established correlation with Total Steps at 0.738, followed by Light Active Distance at 0.727 and Moderately/Fairly Active Distance at 0.519.

**Finding 4 — Sedentary Minutes had a weak negative relationship with steps.**

The correlation was -0.20, indicating a weak inverse association.

**Finding 5 — Activity patterns varied across participants.**

Average daily step counts differed between participants, suggesting that activity behavior was not uniform across the observed group.

### Overall analytical insight

The findings suggest that recorded sedentary activity was prominent, light activity represented a substantial share of recorded active distance, and step counts were positively associated with active-distance measures.

At the same time, participant-level differences indicate that a single activity profile may not adequately describe all users.

These findings can inform a marketing hypothesis focused on everyday movement, awareness, and achievable activity habits.

## 10. Marketing Recommendation

### Selected Product: Bellabeat Leaf

Bellabeat Leaf was selected as the product focus for the final marketing recommendation.

The recommendation connects the observed activity patterns to an opportunity for wellness messaging. It does not assume that Fitbit users are identical to Bellabeat customers or that the data proves a specific product or campaign will change user behavior.

### Campaign Concept: Move More, Little by Little

**Core message:** “Your wellness isn't only your workout. Every movement throughout your day matters.”

The campaign concept emphasizes awareness of everyday movement and the value of consistent, manageable habits.

It is informed by the prominence of recorded sedentary activity time, the substantial recorded light active distance, and the differences in activity levels across participants.

### Recommended Actions

**1. Promote everyday movement.**

Develop marketing content that encourages users to pay attention to movement throughout their daily routines, rather than focusing exclusively on formal exercise.

**2. Consider different activity levels.**

Develop alternative messages for people with different activity habits. For example, one message could emphasize getting started with small amounts of movement, while another could emphasize maintaining consistent habits.

These are proposed audience approaches, not customer segments directly established by the dataset.

**3. Use Bellabeat Leaf as the product touchpoint.**

Connect the campaign to Leaf where its actual capabilities support the message. Product claims should be checked against official product information.

**4. Test the campaign.**

Test the proposed messages with an appropriate audience before expanding the campaign.

**5. Measure and refine.**

Evaluate relevant measures such as content engagement, click-through rates, product or app engagement where applicable, and customer conversion or purchase behavior where measurable.

Use the results to determine which messages deserve further investment.

## 11. Project Limitations

The following limitations should be considered when interpreting the analysis.

- **Limited participant coverage:** The dataset contains a limited group of Fitbit users and may not represent the broader population or Bellabeat's intended customer base.
- **Different table coverage:** Activity, sleep, and weight-log tables contain different numbers of participants. Supplementary data may be missing for some users or dates.
- **Observed behavior:** The dataset describes recorded device measurements but does not explain the motivations behind user behavior.
- **Correlation is not causation:** The correlation results do not establish that one activity measure causes changes in another.
- **Limited business data:** Bellabeat sales, revenue, customer acquisition, and campaign performance data were not part of this analysis.
- **No campaign experiment:** The proposed marketing campaign has not been tested through this analysis, so its impact on engagement or sales remains unknown.
- **Measurement limitations:** Device-recorded activity measures reflect the available tracker data and should be interpreted according to their definitions.

These limitations mean that the findings should be used to develop and test marketing ideas rather than to claim guaranteed business results.

## 12. Recommended Next Steps for Bellabeat

The recommended next steps are:

1. Develop the “Move More, Little by Little” campaign.
2. Prepare messaging suitable for different activity patterns.
3. Incorporate Bellabeat Leaf where its actual capabilities support the campaign.
4. Test the messages with an appropriate target audience.
5. Measure campaign engagement and relevant customer outcomes.
6. Refine the strategy based on the results.

The proposed process follows a continuous improvement cycle:

**Test → Measure → Learn → Refine**

## 13. Conclusion

This project used SQL in Google BigQuery to prepare, clean, transform, validate, and analyze Fitbit smart device usage data.

The data preparation work included integrity checks, duplicate checks, null checks, data type conversion, participant-count comparisons, table combination, joins, distance consistency checks, sleep-data aggregation, creation of a cleaned analytical dataset, and reshaping activity measures using `UNPIVOT`.

The analysis identified a prominent recorded sedentary activity pattern, found that Light Active Distance was the largest recorded active-distance category, and established positive relationships between Total Steps and active-distance measures. Sedentary Minutes showed a weak negative relationship with Total Steps, while average daily steps varied across participants.

Based on these observations, the project proposed “Move More, Little by Little” as a marketing campaign concept for Bellabeat Leaf.

The recommendation is intended to be tested and evaluated rather than treated as a guaranteed business outcome. Measuring the campaign's performance would allow Bellabeat to determine whether the proposed messaging resonates with its target audience.

Overall, the project demonstrates the application of SQL-based data preparation, transformation, validation, exploratory analysis, and visualization to turn observed data patterns into a practical business recommendation.

## 14. Project Deliverables

The project deliverables include:

- SQL code for data integrity checks and data preparation.
- SQL code for data cleaning and transformation.
- SQL code for data validation and exploratory analysis.
- A cleaned analytical dataset.
- Supporting query results and visualizations.
- A summary of key findings and project limitations.
- A marketing recommendation for Bellabeat Leaf.
- A final presentation of the analysis and recommendations.

## 15. Acknowledgment

This project was completed as a data analytics case study inspired by the Google Data Analytics Professional Certificate capstone framework. It uses Fitbit fitness tracker data from the Fitabase dataset to explore smart device usage trends and develop a proposed marketing recommendation for Bellabeat.

The findings and recommendations reflect the analysis performed for this project and should be interpreted within the limitations of the available data and methodology.
