# SQL

Solutions written in **PostgreSQL**, starting with the LeetCode SQL 50 study plan.

All solutions are in [`queries.sql`](queries.sql), grouped by topic.

## Progress: LeetCode SQL 50

**Solved: 10 / 50**

| # | Problem | Concept |
|---|---|---|
| 1757 | Recyclable and Low Fat Products | Filtering with `AND` |
| 584 | Find Customer Referee | `NULL` handling with `IS NULL` |
| 595 | Big Countries | Filtering with `OR` |
| 1148 | Article Views I | Removing duplicates with `DISTINCT` |
| 1683 | Invalid Tweets | String length with `LENGTH()` |
| 1378 | Replace Employee ID With The Unique Identifier | `LEFT JOIN` |
| 1068 | Product Sales Analysis I | `INNER JOIN` |
| 1581 | Customer Who Visited but Did Not Make Any Transactions | Anti-join + `GROUP BY` |
| 197 | Rising Temperature | Self-join with `INTERVAL` |
| 577 | Employee Bonus | `LEFT JOIN` with a `NULL` filter |

## How each solution is documented

```sql
-- 1581. Customer Who Visited but Did Not Make Any Transactions
-- Concept: anti-join (LEFT JOIN + IS NULL), then count per customer
-- Lesson: GROUP BY the thing you are counting per (customer_id, not visit_id)
SELECT v.customer_id, COUNT(v.visit_id) AS count_no_trans
FROM Visits v
LEFT JOIN Transactions t ON v.visit_id = t.visit_id
WHERE t.visit_id IS NULL
GROUP BY v.customer_id;
```

- **Concept**: the idea the problem practices
- **Lesson**: a mistake I made or a subtle point worth remembering

## Key lessons so far

- `NULL` is not equal or unequal to anything, so filters need `IS NULL` explicitly.
- A `WHERE` condition on the right table can quietly turn a `LEFT JOIN` into an `INNER JOIN`.
- `GROUP BY` the entity you are counting per, not the row identifier.
- `LAG()` compares with the previous row; a self-join compares with an exact related row (like the previous day).
- `INTERVAL` is a data type, not a function.
