1. Unfortunately the raw data has poor data quality. How can we handle data quality and integrity?
dbt tests are great tool for this. I have implemented tests in the staging layer that catch some of the data quality issues I have spotted while looking at the data. 
Since there are a lot of fields with poor data quality, we can downgrade these errors to warnings for the time being so that the pipeline can stil run when tests are executed in dbt build, but we still have record of the data quality issues. Example is the age column in the stg_patients table. We should then work with the data owners of these data sources on fixes (adding missing values, fixing invalid records) and overtime as the issues are resolved we can change the warning to errors. We can also filter out the compromised records based on criteria set (for example remove anyone where age is above 120 years and below 0 years etc.)
Another good idea is to visualise and track the errors in a dashboard or track them using a data observability tool (like Elementary, Synq or Monte Carlo). I worked a lot on improving data quality in my current role, happy to discuss in more detail in the session.

2. How many patients belong to each PCN?
If we exclude the records linked to 'Invalid Practice' PCN, there are 87 distinct patient IDs under Streamline Proactive Mindshare PCN and 97 distinct patient IDs under Visualize Virtual Niches. There are some duplicate IDs in the patients data which would require further digging into as well.

3. What's the average patient age per practice?
After removing the outliers of age below 0 and above 120, these are the averages: 

│ practice_id │           practice_name           │ round(avg(age)) │
│    int32    │              varchar              │     double      │
├─────────────┼───────────────────────────────────┼─────────────────┤
│           2 │ Foster, West and Miller Clinic    │            57.0 │
│           4 │ Meza-Smith Clinic                 │            55.0 │
│           1 │ Hayes, Walker and Williams Clinic │            58.0 │
│         999 │ Invalid Practice                  │            57.0 │
│           3 │ Dominguez Ltd Clinic              │            47.0 

I have removed the records where practice name is Null or 'Invalid Practice'. 


4. Categorize patients into age groups (0-18, 19-35, 36-50, 51+) and show the count per group per PCN
After removing the outliers of age below 0 and above 120,:
   primary_care_network_name      │ primary_care_network_id │ age_group │ patient_count │
│              varchar               │          int32          │  varchar  │     int64     │
├────────────────────────────────────┼─────────────────────────┼───────────┼───────────────┤
│ streamline proactive mindshare PCN │                       2 │ 0-18      │             6 │
│ streamline proactive mindshare PCN │                       2 │ 19-35     │            19 │
│ streamline proactive mindshare PCN │                       2 │ 36-50     │             9 │
│ streamline proactive mindshare PCN │                       2 │ 51+       │            41 │
│ visualize virtual niches PCN       │                       1 │ 0-18      │            17 │
│ visualize virtual niches PCN       │                       1 │ 19-35     │            16 │
│ visualize virtual niches PCN       │                       1 │ 36-50     │            20 │
│ visualize virtual niches PCN       │                       1 │ 51+       │            35 

5. What percentage of patients have Hypertension at each practice?

 practice_id │           practice_name           │ hypertension_percentage │
│    int32    │              varchar              │         double          │
├─────────────┼───────────────────────────────────┼─────────────────────────┤
│           2 │ Foster, West and Miller Clinic    │                    0.38 │
│           4 │ Meza-Smith Clinic                 │                    0.38 │
│           1 │ Hayes, Walker and Williams Clinic │                    0.27 │
│           3 │ Dominguez Ltd Clinic              │                    0.43

I have removed the records where practice name is Null or 'Invalid Practice'. 


6. For each patient, show their most recent activity date
Question_6 file.


7. Find Patients who had no activity for 3 months after their first activity
Question_7 file