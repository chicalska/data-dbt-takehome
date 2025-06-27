WITH patients AS (
    SELECT *
    FROM {{ ref('stg_patients') }}
),

practices AS (
    SELECT *
    FROM {{ ref('stg_practices') }}
),

primary_care_networks AS (
    SELECT *
    FROM {{ ref('stg_primary_care_networks') }}
),

int_patients_master AS (

SELECT patients.patient_id,
patients.practice_id, 
patients.age,
patients.gender,
patients.registration_date,
practices.practice_id,
practices.practice_name,
practices.location AS practice_location,
primary_care_networks.primary_care_network_id,
primary_care_networks.primary_care_network_name

FROM patients 
LEFT JOIN practices ON practices.practice_id = patients.practice_id
LEFT JOIN primary_care_networks ON practices.primary_care_network_id = primary_care_networks.primary_care_network_id
)

SELECT *
FROM int_patients_master