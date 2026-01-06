-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

with ranks as( SELECT 
  date(sent_at) as 'date_sent',
  sender_id,
  count(message_id) as messages_sent,
  rank() over (partition by date(sent_at) order by count(message_id) DESC) as rnk
FROM npn_messages
GROUP BY date(sent_at), sender_id
  )

SELECT 
    u.user_id,
    u.user_name, 
    m.date_sent,
    m.messages_sent
FROM npn_users u , ranks m 
WHERE u.user_id= m.sender_id and rnk = 1
