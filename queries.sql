-- =============================================================
-- LeetCode SQL 50: my solutions (PostgreSQL)
-- Part of hyper-learning-log
-- =============================================================


-- -------------------------------------------------------------
-- SELECT
-- -------------------------------------------------------------

-- 1757. Recyclable and Low Fat Products
-- Concept: filtering with AND
SELECT product_id
FROM Products
WHERE low_fats = 'Y'
  AND recyclable = 'Y';


-- 584. Find Customer Referee
-- Concept: NULL is not equal or unequal to anything, so it needs IS NULL
SELECT name
FROM Customer
WHERE referee_id IS NULL
   OR referee_id != 2;


-- 595. Big Countries
-- Concept: filtering with OR
SELECT name, population, area
FROM World
WHERE area >= 3000000
   OR population >= 25000000;


-- 1148. Article Views I
-- Concept: removing duplicates (DISTINCT works the same as GROUP BY here)
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id ASC;


-- 1683. Invalid Tweets
-- Concept: string length
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;


-- -------------------------------------------------------------
-- BASIC JOINS
-- -------------------------------------------------------------

-- 1378. Replace Employee ID With The Unique Identifier
-- Concept: LEFT JOIN keeps every employee, NULL when no match
SELECT e.name, u.unique_id
FROM Employees e
LEFT JOIN EmployeeUNI u ON e.id = u.id;


-- 1068. Product Sales Analysis I
-- Concept: INNER JOIN keeps only matching rows
SELECT p.product_name, s.year, s.price
FROM Sales s
JOIN Product p ON s.product_id = p.product_id;


-- 1581. Customer Who Visited but Did Not Make Any Transactions
-- Concept: anti-join (LEFT JOIN + IS NULL), then count per customer
-- Lesson: GROUP BY the thing you are counting per (customer_id, not visit_id)
SELECT v.customer_id, COUNT(v.visit_id) AS count_no_trans
FROM Visits v
LEFT JOIN Transactions t ON v.visit_id = t.visit_id
WHERE t.visit_id IS NULL
GROUP BY v.customer_id;


-- 197. Rising Temperature
-- Concept: self-join to compare a row with another row in the same table
-- Note: INTERVAL is a data type, not a function. LAG() would compare with the
-- previous ROW, but this problem needs exactly the previous DAY.
SELECT w1.id
FROM Weather w1
JOIN Weather w2
  ON w1.recordDate = w2.recordDate + INTERVAL '1 day'
WHERE w1.temperature > w2.temperature;