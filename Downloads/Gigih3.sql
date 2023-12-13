SELECT
  EXTRACT(YEAR FROM q.creation_date) AS year,
  COUNT(*) AS number_of_questions
FROM
  `bigquery-public-data.stackoverflow.posts_questions` AS q
JOIN
  `bigquery-public-data.stackoverflow.users` AS u
ON
  q.owner_user_id = u.id
WHERE
  u.location LIKE '%Indonesia%'
  AND EXTRACT(YEAR FROM q.creation_date) BETWEEN 2015 AND 2020
GROUP BY
  year
ORDER BY
  year;


