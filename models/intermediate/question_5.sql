--What percentage of patients have Hypertension at each practice?

WITH patients AS (
    SELECT *
    FROM {{ ref('int_patients_master')}}
),

conditions AS (
    SELECT *
    FROM {{ ref('int_patient_conditions')}}
),

base AS (

SELECT patients.patient_id,
patients.practice_id,
patients.practice_name,
conditions.condition 
FROM patients
Left join conditions on conditions.patient_id = patients.patient_id

)

SELECT practice_id, practice_name, round(count(distinct case when condition = 'hypertension' THEN patient_id END) / COUNT(distinct patient_id), 2) AS hypertension_percentage
FROM base
Where practice_name is not null and practice_name <> 'Invalid Practice'
group by 1,2
