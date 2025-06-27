WITH source AS (
    SELECT *
    FROM {{ ref('raw_pcns') }}
), 

stg_primary_care_networks AS (
    SELECT id AS primary_care_network_id,
    pcn_name AS primary_care_network_name,
    FROM source
)

SELECT *
FROM stg_primary_care_networks