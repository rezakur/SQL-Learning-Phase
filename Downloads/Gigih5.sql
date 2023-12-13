WITH YearlyAnswerCounts AS (
  SELECT
    EXTRACT(YEAR FROM q.creation_date) AS year,
    COUNT(*) AS total_answers
  FROM
    `bigquery-public-data.stackoverflow.posts_questions` AS q
  JOIN
    `bigquery-public-data.stackoverflow.posts_answers` AS a
  ON
    q.id = a.parent_id
  WHERE
    q.tags LIKE '%bigquery%'
  GROUP BY
    year
)
SELECT
  year,
  total_answers,
  RANK() OVER (ORDER BY total_answers DESC) AS ranking
FROM
  YearlyAnswerCounts
ORDER BY
  ranking;


