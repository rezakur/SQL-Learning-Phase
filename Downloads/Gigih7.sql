SELECT
  location,
  COUNT(*) AS user_count
FROM
  `bigquery-public-data.stackoverflow.users`
WHERE
  location IS NOT NULL
GROUP BY
  location
ORDER BY
  user_count DESC
LIMIT
  10;


