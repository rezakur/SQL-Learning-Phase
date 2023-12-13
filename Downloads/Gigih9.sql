SELECT
  --COUNT(DISTINCT trip_id) AS total_trips
  bike_number
FROM
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips` s
INNER JOIN 
   `bigquery-public-data.san_francisco_bikeshare.bikeshare_station_info` t
ON s.start_station_name = t.name
INNER JOIN
 `bigquery-public-data.san_francisco_bikeshare.bikeshare_regions` r
  ON t.region_id = r.region_id
WHERE
  --EXTRACT(DAY FROM start_date) = 16
  --AND
  --EXTRACT(MONTH FROM start_date) = 10
  --AND
  --EXTRACT(YEAR FROM start_date) = 2017
  --EXTRACT(DATE FROM start_date) = '2017-10-16'
  DATE(start_date) = '2017-10-16'
  AND r.name = 'San Jose'
  AND
  subscriber_type != 'Subscriber'
  AND 
  start_station_id != end_station_id
  AND
  --TIME (start_date) >= '21:20:00'
  EXTRACT(TIME FROM start_date) >= '21:20:00'
  AND
  duration_sec < 900

