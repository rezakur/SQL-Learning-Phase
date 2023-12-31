WITH BadgeEarnings AS (
  SELECT
    u.display_name AS username,
    b.name AS badge_name,
    b.class AS badge_class,
    b.tag_based AS tag_based,
    b.date AS badge_date,
    ROW_NUMBER() OVER (PARTITION BY b.class, u.display_name ORDER BY b.date) AS badge_rank
  FROM
    `bigquery-public-data.stackoverflow.users` AS u
  JOIN
    `bigquery-public-data.stackoverflow.badges` AS b
    ON u.id = b.user_id
  WHERE
    EXTRACT(YEAR FROM b.date) = 2020
    AND EXTRACT(MONTH FROM b.date) = 1
)
SELECT
  username,
  badge_name,
  badge_class,
  tag_based,
  badge_date,
  RANK() OVER (PARTITION BY badge_class ORDER BY badge_date) AS badge_rank
FROM
  BadgeEarnings
ORDER BY
  badge_class,
  badge_rank;


