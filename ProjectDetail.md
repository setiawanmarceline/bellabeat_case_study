# Bellabeat Smart Device Usage Analysis

## 📌 Project Overview

This project analyzes Fitbit smart-device usage data to identify user activity patterns and develop data-driven marketing recommendations for Bellabeat.

The analysis focuses on activity levels, daily steps, activity distance, and differences in activity patterns between participants. The findings are then applied to a Bellabeat product to develop a marketing recommendation.

**Project type:** Google Data Analytics Capstone Project
**Role:** Data Analyst
**Client:** Bellabeat
**Tools:** SQL (BigQuery), Power BI / Tableau, Excel / Google Sheets

---

## 🎯 Business Task

Bellabeat wants to better understand how consumers use non-Bellabeat smart devices.

The objective of this analysis is to:

* Identify trends in smart-device usage
* Understand user activity patterns
* Examine relationships between steps and activity measures
* Explore variation in activity levels between participants
* Apply the findings to a Bellabeat product
* Develop a data-driven marketing recommendation

---

## ❓ Key Questions

1. What are the main activity patterns among Fitbit users?
2. How do activity levels vary between participants?
3. How are daily steps related to different activity measures?
4. What opportunities can these behavioral patterns provide for Bellabeat?
5. How can the findings inform Bellabeat's marketing strategy?

---

## 📊 Dataset
**Dataset Source:** https://www.kaggle.com/datasets/arashnic/fitbit

The analysis uses Fitbit/Fitabase smart-device usage data containing information such as:

* Daily steps
* Activity minutes
* Activity distance
* Calories
* Sleep
* User IDs and dates

The dataset represents a limited group of Fitbit users and may not be representative of the broader Bellabeat customer population.

---

## 🧹 Data Preparation & Cleaning

The data was prepared and validated before analysis.

Key steps included:

* Checking for duplicate records
* Checking for missing values
* Standardizing data types and date formats
* Checking user IDs and dates
* Comparing related datasets for consistency
* Combining relevant datasets
* Creating calculated fields needed for analysis

SQL was used to document the cleaning and validation process.

---

## 🔎 Analysis

The analysis focused on:

### Activity Minutes

Compared Very Active, Fairly/Moderately Active, Lightly Active, and Sedentary Minutes.

### Activity Distance

Compared Very Active, Moderately/Fairly Active, Light Active, and Sedentary Distance.

### Steps & Activity Relationships

Correlation analysis was used to examine relationships between Total Steps and activity-distance measures.

### Participant Variation

Average daily steps were compared across individual participants to determine whether activity levels varied substantially between users.

---

## 💡 Key Findings

### 1. Sedentary activity was prominent

Participants recorded substantially more sedentary activity time than other activity categories.

### 2. Light Active Distance was the largest recorded active-distance category

Light activity represented the largest recorded active-distance category in the dataset.

### 3. Active distance was positively associated with Total Steps

| Activity Distance                 | Correlation with Total Steps |
| --------------------------------- | ---------------------------: |
| Very Active Distance              |                    **0.738** |
| Light Active Distance             |                    **0.727** |
| Moderately/Fairly Active Distance |                    **0.519** |

Very Active Distance had the strongest correlation with Total Steps.

### 4. Sedentary Minutes had a weak negative relationship with Total Steps

The correlation between Sedentary Minutes and Total Steps was:

**r = -0.20**

This indicates a weak negative relationship rather than a strong association.

### 5. Activity levels varied between participants

Average daily steps differed across individual participants. This demonstrates that an overall average does not necessarily represent every user's activity pattern.

---

## 📈 Visualizations

### Sedentary Activity
<img width="887" height="1323" alt="image" src="https://github.com/user-attachments/assets/72e5faed-f52f-433e-ade3-6410ecd4ee64" />

### Activity Distance
<img width="1158" height="651" alt="image" src="https://github.com/user-attachments/assets/af6f4944-5734-45f8-89a0-235cd5edd952" />

### Steps vs. Activity Distance
<img width="1268" height="715" alt="{A99E3227-D40D-4ED9-8549-FD9BFA84E64B}" src="https://github.com/user-attachments/assets/6806bbda-42d8-4f08-af2a-dca4e5718555" />

### Average Daily Steps by Participant
<img width="477" height="604" alt="image" src="https://github.com/user-attachments/assets/f56ba3ce-9766-4bf0-abfb-5ca639f1a932" />

---

## 🏷️ Bellabeat Product Application

Based on the findings, the analysis is applied to the **Bellabeat Leaf**.

The findings suggest an opportunity to communicate the importance of everyday movement and sustainable activity habits rather than focusing only on intense exercise.

---

## 📣 Marketing Recommendation

### **Move More, Little by Little**

The recommended marketing direction emphasizes small, consistent movements throughout the day.

The campaign could encourage users to:

* Become more aware of sedentary periods
* Add small amounts of movement throughout the day
* Build consistent activity habits
* Focus on sustainable everyday movement

### Suggested message

> **“Your wellness isn't only your workout. Every movement throughout your day matters.”**

---

## 🚀 Recommended Next Steps

1. Develop an everyday-movement marketing campaign around **“Move More, Little by Little.”**
2. Consider different messaging approaches for users with different activity levels.
3. Use the selected Bellabeat product as the campaign touchpoint.
4. Test campaign engagement and customer response.
5. Measure results and refine the marketing approach based on the data.

The analysis does not establish that this strategy will increase sales; campaign performance would need to be tested and measured.

---

## 🛠️ Tools Used

* **SQL / Google BigQuery** — Data cleaning, validation, transformation, and analysis
* **Power BI / Tableau** — Data visualization
* **Excel / Google Sheets** — Data exploration and supporting analysis
* **GitHub** — Project documentation and portfolio presentation

---

## 📁 Project Structure

```text
bellabeat-case-study/
│
├── README.md
│
├── SQL/
│   ├── data_cleaning.sql
│   ├── data_validation.sql
│   └── data_analysis.sql
│
├── Presentation/
│   └── Bellabeat_Analysis.pdf
│
└── Visualizations/
    ├── sedentary_activity.png
    ├── activity_distance.png
    ├── steps_activity_distance.png
    └── participant_variation.png

```

---

## ⚠️ Limitations

* The dataset contains a limited number of Fitbit users.
* The participants may not represent Bellabeat's target customers.
* The data represents a specific period and may not reflect current behavior.
* Correlation analysis identifies relationships but does not establish causation.
* The dataset does not contain Bellabeat sales or marketing-performance data.

---

## 📚 Acknowledgment

This project was completed as part of the **Google Data Analytics Professional Certificate** capstone/case study.

The original case study asks analysts to analyze smart-device usage data and apply the findings to Bellabeat's marketing strategy.

