# Assignment

## Brief

Write the SQL statements for the following questions.

## Instructions

Paste the answer as SQL in the answer code section below each question.

### Question 1

Let's revisit our `austin_bikeshare_demo` dbt project. Modify the `dim_station.sql` model to include the following columns:

- `total_duration` (sum of `duration` for each station in seconds)
- `total_starts` (count of `start_station_name` for each station)
- `total_ends` (count of `end_station_name` for each station)

Then, rebuild the models with the following command to see if the changes are correct:

```bash
dbt run
```

Answer:

Paste the `dim_station.sql` model here:

```sql

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


```

## Submission

- Submit the URL of the GitHub Repository that contains your work to NTU black board.
- Should you reference the work of your classmate(s) or online resources, give them credit by adding either the name of your classmate or URL.
