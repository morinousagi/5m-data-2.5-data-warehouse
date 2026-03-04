SELECT DISTINCT
    s.station_id,
    s.name,
    s.status,
    s.location,
    s.address,
    --alternate_name,
    --city_asset_number,
    --property_type,
    --number_of_docks,
    --power_type,
    --footprint_length,
    --footprint_width,
    --notes,
    --council_district,
    --image,
    s.modified_date,

    (SELECT SUM(t.duration_minutes*60)
     FROM {{ source('austin_bikeshare', 'bikeshare_trips') }} AS t
     WHERE s.station_id = t.start_station_id
     ) AS total_duration,

    (SELECT COUNT(t.start_station_name)
     FROM {{ source('austin_bikeshare', 'bikeshare_trips') }} AS t
     WHERE s.station_id = t.start_station_id
     ) AS total_starts,

    (SELECT COUNT(t.end_station_name)
     FROM {{ source('austin_bikeshare', 'bikeshare_trips') }} AS t
     WHERE s.station_id = SAFE_CAST(t.end_station_id AS INT64)
     ) AS total_ends

FROM {{ source('austin_bikeshare', 'bikeshare_stations') }} AS s
