Select product_id from Products Where low_fats ='Y' and recyclable ='Y'

select name from Customer where referee_id is null  or referee_id != 2 

Select name, population, area from World where area >= 3000000 or population >= 25000000


select author_id AS id from Views where author_id = viewer_id group by author_id order by author_id ASC


select tweet_id from Tweets where LENGTH(content) >15

Select Employees.name, EmployeeUNI.unique_id From Employees Left join EmployeeUNI On Employees.id = EmployeeUNI.id

Select Product.product_name, Sales.year, Sales.price From Sales inner join Product on Sales.product_id = Product.product_id


Select Visits.customer_id, COUNT(Visits.visit_id) as count_no_trans from Visits left join Transactions on Visits.visit_id = Transactions.visit_id  where Transactions.visit_id is null GROUP BY Visits.customer_id


SELECT w1.id
FROM Weather w1
JOIN Weather w2
  ON w1.recordDate = w2.recordDate + INTERVAL '1 day'
WHERE w1.temperature > w2.temperature;

