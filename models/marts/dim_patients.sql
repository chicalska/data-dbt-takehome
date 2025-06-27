WITH dim_patients AS (
    SELECT *
    FROM {{ ref('int_patients_master')}}
)

SELECT *
FROM dim_patients