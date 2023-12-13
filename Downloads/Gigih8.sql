WITH UserActivity AS (
  SELECT
    u.id AS user_id,
    u.creation_date AS account_creation_date,
    MAX(q.creation_date) AS last_activity_date
  FROM
    `bigquery-public-data.stackoverflow.users` AS u
  JOIN
    `bigquery-public-data.stackoverflow.posts_questions` AS q
  ON
    u.id = q.owner_user_id
  GROUP BY
    user_id, account_creation_date
),
UserQuestionCounts AS (
  SELECT
    q.owner_user_id AS user_id,
    COUNT(*) AS question_count
  FROM
    `bigquery-public-data.stackoverflow.posts_questions` AS q
  GROUP BY
    user_id
)
SELECT
  APPROX_QUANTILES(uqc.question_count, 100)[OFFSET(9)] AS p10,
  APPROX_QUANTILES(uqc.question_count, 100)[OFFSET(24)] AS p25,
  APPROX_QUANTILES(uqc.question_count, 100)[OFFSET(74)] AS p75,
  APPROX_QUANTILES(uqc.question_count, 100)[OFFSET(94)] AS p95,
  APPROX_QUANTILES(uqc.question_count, 2)[OFFSET(1)] AS median
FROM
  UserActivity AS ua
LEFT JOIN
  (
    SELECT
      user_id,
      question_count
    FROM
      UserQuestionCounts
  ) AS uqc
ON
  ua.user_id = uqc.user_id;

