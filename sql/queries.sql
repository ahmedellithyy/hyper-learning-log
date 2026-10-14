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


-- 577. Employee Bonus
-- Concept: LEFT JOIN, then filter while keeping the unmatched rows
-- Lesson: employees with no bonus row get NULL, and NULL < 1000 is not true,
-- so the IS NULL check is needed or they silently disappear
SELECT e.name, b.bonus
FROM Employee e
LEFT JOIN Bonus b ON e.empId = b.empId
WHERE b.bonus < 1000
   OR b.bonus IS NULL;



-- 1661. Average Time of Process per Machine
-- Concept: self-join to put the start and end of a process on the same row
-- Lesson: the activity_type conditions in ON fix the roles (s = start, e = end);
-- without them start-start and end-end pairs make the average 0
-- Note: timestamp is a float, so cast to numeric before ROUND(value, 3)
SELECT s.machine_id,
       ROUND(AVG(e.timestamp - s.timestamp)::numeric, 3) AS processing_time
FROM Activity s
JOIN Activity e
  ON s.machine_id = e.machine_id
 AND s.process_id = e.process_id
 AND s.activity_type = 'start'
 AND e.activity_type = 'end'
GROUP BY s.machine_id;


-- 1280. Students and Examinations
-- Concept: CROSS JOIN builds every student/subject pair, LEFT JOIN attaches
-- the exams, GROUP BY + COUNT turns them into one number per pair
-- Lesson: COUNT a column from the third table (not COUNT(*)) so pairs with
-- no exams show 0, and match on BOTH student and subject in ON
SELECT st.student_id,
       st.student_name,
       sub.subject_name,
       COUNT(ex.subject_name) AS attended_exams
FROM Students st
CROSS JOIN Subjects sub
LEFT JOIN Examinations ex
  ON st.student_id = ex.student_id
 AND sub.subject_name = ex.subject_name
GROUP BY st.student_id, st.student_name, sub.subject_name
ORDER BY st.student_id, sub.subject_name;


-- 570. Managers with at Least 5 Direct Reports
-- Concept: self-join to count rows that point to another row, HAVING to
-- filter on the count
-- Lesson: read ON as a sentence ("e's manager is m"), then SELECT and
-- GROUP BY the manager alias and COUNT the employee alias
SELECT m.name
FROM Employee m
JOIN Employee e ON e.managerId = m.id
GROUP BY m.id, m.name
HAVING COUNT(e.id) >= 5;


-- 1934. Confirmation Rate
-- Concept: conditional counting with COUNT(*) FILTER, then a ratio per user
-- Lesson: integer / integer drops the decimals in PostgreSQL, so cast to
-- numeric BEFORE dividing; ROUND afterwards is too late
-- Note: COUNT(*) counts the NULL row from the LEFT JOIN, so users with no
-- confirmations divide by 1 (not 0) and get 0.00
SELECT s.user_id,
       ROUND(
         COUNT(*) FILTER (WHERE c.action = 'confirmed')::numeric / COUNT(*),
         2
       ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id;