select 
   Count(c.customer_id) as customers_count

from customers c 

SELECT
    e.first_name || ' ' || e.last_name AS seller,
    COUNT(*) AS operations,
    SUM(s.quantity * p.price) AS income
FROM sales s
JOIN employees e ON s.sales_person_id = e.employee_id
JOIN products p ON s.product_id = p.product_id
GROUP BY e.employee_id
ORDER BY income DESC
LIMIT 10;
