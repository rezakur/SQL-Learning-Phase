WITH PythonQuestions AS (
  SELECT
    q.id AS question_id,
    q.title AS question_title,
    q.body AS question_body,
    a.body AS answer_body,
    q.creation_date AS question_creation_date,
    a.creation_date AS answer_creation_date
  FROM
    `bigquery-public-data.stackoverflow.posts_questions` AS q
  JOIN
    `bigquery-public-data.stackoverflow.posts_answers` AS a
  ON
    q.id = a.parent_id
  WHERE
    q.tags LIKE '%python%'
    AND EXTRACT(YEAR FROM q.creation_date) = 2020
)
SELECT
  *
FROM
  PythonQuestions;

