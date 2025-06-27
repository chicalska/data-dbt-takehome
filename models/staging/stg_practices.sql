WITH source AS (
    SELECT *
    FROM {{ ref('raw_practices') }}
), 

stg_practices AS (
    SELECT id AS practice_id,
    practice_name,
    location,
    established_date,
    pcn As primary_care_network_id
    FROM source
    -- we could look at excluding the invalid record from the data
    -- WHERE practice_name <> 'Invalid Practice'
)

SELECT *
FROM stg_practices