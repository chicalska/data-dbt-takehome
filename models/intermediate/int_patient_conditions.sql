WITH patients AS (
    SELECT *
    FROM {{ ref('stg_patients') }}
), 

int_patient_conditions AS (

SELECT
-- unique ID for each condition row
  ROW_NUMBER() OVER () AS record_id,  
  patient_id,
  practice_id,
  age,
  registration_date,
  condition
FROM (
    SELECT
      patient_id,
      practice_id,
      age,
      registration_date,
      CAST(json_extract(conditions_json, '$') AS TEXT[]) AS condition_array
    FROM stg_patients
) source,
UNNEST(condition_array) AS cond(condition)

)

SELECT *
FROM int_patient_conditions