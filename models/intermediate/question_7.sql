WITH patients_activity AS (
    SELECT *
    FROM {{ ref('stg_activities') }}
),

first_activity AS (
    SELECT 
        patient_id,
        MIN(activity_timestamp) AS first_activity_date
    FROM patients_activity
    GROUP BY patient_id
),

recent_activity AS (
    SELECT 
        a.patient_id,
        a.activity_timestamp,
        f.first_activity_date
    FROM patients_activity a
    JOIN first_activity f ON a.patient_id = f.patient_id
    WHERE a.activity_timestamp > f.first_activity_date
      AND a.activity_timestamp <= f.first_activity_date + INTERVAL '3 months'
),

patients_with_no_recent_activity AS (
    SELECT 
        f.patient_id,
        f.first_activity_date
    FROM first_activity f
    LEFT JOIN recent_activity r ON f.patient_id = r.patient_id
    WHERE r.patient_id IS NULL
)

SELECT *
FROM patients_with_no_recent_activity
ORDER BY first_activity_date
