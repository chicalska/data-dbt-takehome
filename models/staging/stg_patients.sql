WITH source AS (
    SELECT *
    FROM {{ ref('raw_patients') }}
), 

stg_patients AS (
    SELECT TRY_CAST(json_extract(data, '$.patient_id') AS INTEGER) AS patient_id,
    TRY_CAST(json_extract(data, '$.practice_id') AS INTEGER) AS practice_id,
    TRY_CAST(json_extract(data, '$.age') AS INTEGER) AS age,
    TRY_CAST(json_extract(data, '$.gender') AS BOOLEAN) AS gender,
    TRY_CAST(json_extract(data, '$.registration_date') AS DATE) AS registration_date,
    json_extract(data, '$.conditions') AS conditions_json
    FROM source
)

SELECT *
FROM stg_patients
