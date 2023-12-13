SELECT name, short_name, region_id, lat, lon  FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_station_info` WHERE region_id = (SELECT region_id FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_station_info` WHERE short_name = 'BK-D7-1') AND short_name != 'BK-D7-1';

