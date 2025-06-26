WITH patients_activity AS (
    SELECT *
    FROM {{ ref('stg_activities') }}
),

patients AS (
    SELECT *
    FROM {{ ref('stg_patients')}}
)


SELECT patients.patient_id,
MAX(patients_activity.activity_timestamp) AS last_activity
FROM patients
LEFT JOIN patients_activity ON patients_activity.patient_id = patients.patient_id
WHERE patients.patient_id IS NOT NULL
group by 1

