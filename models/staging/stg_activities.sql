WITH source AS (
    SELECT *
    FROM {{ ref('raw_activities') }}
), 

stg_activities AS (
    SELECT activity_id,
    patient_id,
    activity_type,
    activity_date AS activity_timestamp,
    duration_minutes
    FROM source
)

SELECT *
FROM stg_activities