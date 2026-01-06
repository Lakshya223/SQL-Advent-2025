-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

with ranks as (SELECT 
      subject,
      quiz_date,
      score,
      dense_rank() OVER (PARTITION BY subject order by quiz_date) as rnk
FROM daily_quiz_scores),
summary as(
  SELECT subject,
      max(rnk) as max_rank,
      min(rnk) as min_rank
  FROM ranks
  Group BY subject
  
),
max_table as(
SELECT ranks.subject,
    ranks.score as max_score
FROM ranks join summary ON
      ranks.subject = summary.subject AND 
      ranks.rnk = summary.max_rank
),
min_table as(
  SELECT ranks.subject,
    ranks.score as min_score
FROM ranks join summary ON
      ranks.subject = summary.subject AND 
      ranks.rnk = summary.min_rank
),
Results as (
  SELECT * from max_table join min_table using(subject)
)
SELECT * from results
