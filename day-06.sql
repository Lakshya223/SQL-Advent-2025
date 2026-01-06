-- SQL Advent Calendar - Day 6
-- Title: Ski Resort Snowfall Rankings
-- Difficulty: hard
--
-- Question:
-- Buddy is planning a winter getaway and wants to rank ski resorts by annual snowfall. Can you help him bucket these ski resorts into quartiles?
--
-- Buddy is planning a winter getaway and wants to rank ski resorts by annual snowfall. Can you help him bucket these ski resorts into quartiles?
--

-- Table Schema:
-- Table: resort_monthly_snowfall
--   resort_id: INT
--   resort_name: VARCHAR
--   snow_month: INT
--   snowfall_inches: DECIMAL
--

-- My Solution:

with annual as (
    SELECT 
        resort_id,
        resort_name,
        sum(snowfall_inches) as annual_snowfall
    FROM resort_monthly_snowfall
    GROUP BY resort_id
)
-- SELECT * from annual
SELECT 
      resort_id,
      resort_name, 
      annual_snowfall,
      NTILE(4) over (ORDER by annual_snowfall DESC) as snowfall_quartile
FROM annual
