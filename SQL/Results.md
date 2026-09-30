-- Upload the dataset used for analysis


##1.CHECK DATA INTEGRITY 

-- Compare Calories data between daily_activity_2 and daily_calories2
-- to verify data completeness
<img width="758" height="396" alt="{A67D3A0A-CEF9-4EAA-8ECE-C72CA838C82E}" src="https://github.com/user-attachments/assets/c9535fb2-63b8-406e-9006-5f5cc20c3c39" />


-- CHECK TABLE 
<img width="1092" height="500" alt="{0FB4081C-238F-4387-92EC-6D73F98B0E0A}" src="https://github.com/user-attachments/assets/1fd32517-36ba-42b5-bdf8-fd9950e56ffd" />
--had done the same for all tables


##2.CHECK FOR DUPLICATE

<img width="1088" height="303" alt="{4C07B9F7-C53E-4E62-B540-F802E5B2C038}" src="https://github.com/user-attachments/assets/ad905355-d880-4b5d-8999-f4decd1b8508" />
--Data has no duplicate.
--had done the same with all of other dataset.


##3.CHECK FOR DATA TYPE

--Change Data Type String to Date using create or replace table.
<img width="969" height="490" alt="{4A95D676-B105-44AD-B80B-890C3B9FB018}" src="https://github.com/user-attachments/assets/63d2ac54-edd3-4c71-a4c9-9e2f9a40fb62" />

-- Another table
<img width="973" height="470" alt="{C2931D79-C5A9-4E12-8D59-56E88D44ED8E}" src="https://github.com/user-attachments/assets/2bff3007-1033-4177-83be-d34fea042996" />



##4.CHECK FOR NULL VALUES

<img width="1093" height="306" alt="{1B811E10-D3D3-4926-B7EF-8DEB60221877}" src="https://github.com/user-attachments/assets/33ac4af2-50df-4c10-b75d-17c6922ebd40" />
--Data has no null-values


##5.CHECK NUMBER OF UNIQUE USER

<img width="1087" height="307" alt="{4D057F76-3E67-442D-B859-23EE0D2492F7}" src="https://github.com/user-attachments/assets/251b32ca-098b-4d41-a595-dcf9808ac3d5" />
--35 unique data for dataset1 and 33 unique Id for dataset2

--CHECKING WEIGHTLOG DATA
<img width="1088" height="314" alt="{173C9D60-A2E3-43B5-B485-34E91211F980}" src="https://github.com/user-attachments/assets/bd99aa56-4952-4c69-8a96-e87c6311fa6c" />
--11 unique data for dataset1 and 8 unique Id for dataset2

--CHECKING SLEEPING DATA
<img width="1092" height="307" alt="{5E13EDEB-3A44-48C3-B415-5C5B8862B1B8}" src="https://github.com/user-attachments/assets/42b92e06-7774-4f1e-9994-02d3259fec7c" />
--23 unique data for dataset1 and 24 unique Id for dataset2


##6.MERGE THE DATA 

--MERGE DAILY ACTIVITY DATA 
<img width="1348" height="593" alt="{68D69904-E07A-4DA2-A508-5E09F2869791}" src="https://github.com/user-attachments/assets/639c7779-321d-4723-8a1e-9247a364a107" />


--MERGE WEIGHT LOG DATA
<img width="1357" height="586" alt="{BEAB77DF-04B9-42C3-B0A3-E0B734BAB2F4}" src="https://github.com/user-attachments/assets/d0d03bd3-20d5-4f7b-8ba0-423478b74a9d" />


##7.JOIN DATA 

Join daily_activity1 with weightlog data
<img width="1084" height="501" alt="{EBE7E6FE-0468-49B1-ABFC-3B6ABB70D8A3}" src="https://github.com/user-attachments/assets/ab517d7d-9deb-4cd8-9f2f-4fc16f0ff83a" />



##8.CHECKING ID NUMBER

<img width="931" height="497" alt="{59782399-B7A4-44DB-A720-2DB372A25BC6}" src="https://github.com/user-attachments/assets/621013af-bbee-4f1f-9a87-deab136353c4" />
--Checked all ID number, each Id has 10 numbers long. 



##9.DATA VALIDATION 
 
--Compared TotalDistance with the sum of activity-intensity distance fields.
<img width="925" height="493" alt="{08AE8D8A-9F50-4167-9029-C4D255B1E3A3}" src="https://github.com/user-attachments/assets/87f0f790-c082-4d08-8485-b8da9f3c3646" />
--The values were generally similar, with small differences observed. TotalDistance was therefore retained as the primary overall distance measure.



##10.INTEGRATING SLEEP DATA 

--Aggregating minute-level sleep data into daily sleep metric.
<img width="966" height="482" alt="{A313EE73-1742-4313-AC9B-0574683C5804}" src="https://github.com/user-attachments/assets/2a68457f-dff9-411f-b10e-0c637ff4384e" />

--MERGE SLEEP DATA 
<img width="961" height="484" alt="{CFA9CDC1-E468-46ED-B39A-8BBA3F79A105}" src="https://github.com/user-attachments/assets/a3e147db-1aed-4ece-b12c-40bc255b6060" />

--JOIN THE SLEEP DATA TO MAIN TABLE 
<img width="975" height="491" alt="{37E75DA4-F4F3-4339-B35C-DD5E92007B49}" src="https://github.com/user-attachments/assets/fba9e5e1-4786-4ff0-86aa-d97832defde4" />



##11.CREATE CLEANED DATASET

<img width="1358" height="591" alt="{55B376AE-5D65-48CC-ABE0-3B34FC76088F}" src="https://github.com/user-attachments/assets/cb104c21-78d1-40c8-9a7d-6a7e979e56aa" />



##12.UNPIVOT DATA

-- Transform Data to Long Data (distance level)
<img width="1314" height="595" alt="{AD54F077-4B32-4576-A3C8-BDC9FD7C7E26}" src="https://github.com/user-attachments/assets/5c72df0b-0781-4dd1-a6e4-66c961fca035" />


-- Transform Data to Long Data (minutes level)
<img width="1318" height="593" alt="{2EDD64BB-DA2C-4014-B0A3-165FEC02EF61}" src="https://github.com/user-attachments/assets/4b10f7e7-c405-4edc-84a2-6f2d0836f521" />


##13.DATA ANALYSIS 


-- Count how many samples are in analysis 
<img width="1309" height="592" alt="{2BC9E799-8B93-4AA2-875C-F86C17354C5C}" src="https://github.com/user-attachments/assets/f9235367-3399-4a7c-9cc4-2e1d7483dd80" />
--35 Id Recorded


-- Find the avarage of Distance by each Intensities in Each Day 
<img width="1307" height="588" alt="{0A22AC8A-2017-4BB7-A39E-2AF714F7CF02}" src="https://github.com/user-attachments/assets/fb8e97de-6ff9-4a68-a516-a7c065958df7" />
--Light Active Distance was generally the largest among the Active Distance 
--There was no strong trend showing the difference of the distance between weekend and weekday 


-- Find the avarage of time spend for each activity's intensity in Each Day 
<img width="1318" height="597" alt="{BDBA3278-14C8-4450-8074-B4B919F202A0}" src="https://github.com/user-attachments/assets/76f90905-c570-4b1c-be2b-fedb3a694885" />
-- People doing most of their time doing sedentary activity every day. 


-- Find the avarage of time spend for each activity's intensity for each users 
<img width="1316" height="634" alt="{E256C3A5-322A-4DAC-9CD3-A849E6E29EFC}" src="https://github.com/user-attachments/assets/ea97f2a9-9843-4793-a4d7-a3efd0dea762" />


-- Find the avarage of Total Steps and Distance for each users 
<img width="1320" height="598" alt="{BBD1C100-9ADF-47E5-9AC2-9F1966443197}" src="https://github.com/user-attachments/assets/c5672ce7-4ec3-4ebd-9c5d-9c1218420864" />


-- Find the correlation factor between steps and distance 
<img width="1319" height="593" alt="{6620E974-A082-4EB4-B481-D9AA253910F1}" src="https://github.com/user-attachments/assets/fb5a5b62-994d-47aa-8950-5ed2f8e338ef" />
--Found from the data that light activity distance have the strongest positive relationship with the total step compare with other intensity. 


##14.CREATE TEMPORARY TABLE 

-- for unpivot correlation data to be used in visualization 
<img width="1315" height="629" alt="{4C0F1992-9CBB-4D9C-B23E-84810EA20342}" src="https://github.com/user-attachments/assets/cd27a9f3-d661-4f47-aca3-e368ac0c8416" />

-- steps vs sedentary minutes
<img width="1315" height="594" alt="{2AC5D258-9C5D-4FF7-A71B-834194A5310B}" src="https://github.com/user-attachments/assets/9e9b411b-f08a-4403-b2a9-e510095875b1" />
