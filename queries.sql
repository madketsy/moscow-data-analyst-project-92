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

WITH seller_revenue AS (
    SELECT 
        e.employee_id,
        CONCAT(e.first_name, ' ', e.last_name) AS seller,
        ROUND(AVG(p.price * s.quantity)) AS average_income
    FROM 
        sales s
    JOIN 
        employees e ON s.sales_person_id = e.employee_id
    JOIN 
        products p ON s.product_id = p.product_id
    GROUP BY 
        e.employee_id, e.first_name, e.last_name
),
overall_average AS (
    SELECT AVG(p.price * s.quantity) AS avg_income
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
)
SELECT 
    sr.seller,
    sr.average_income
FROM 
    seller_revenue sr
CROSS JOIN 
    overall_average oa
WHERE 
    sr.average_income < oa.avg_income
ORDER BY 
    sr.average_income ASC;


SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS seller,
    TO_CHAR(s.sale_date, 'Day') AS day_of_week,
    ROUND(SUM(p.price * s.quantity)) AS income
FROM
    sales s
JOIN
    employees e ON s.sales_person_id = e.employee_id
JOIN
    products p ON s.product_id = p.product_id
GROUP BY
    e.employee_id,
    e.first_name,
    e.last_name,
    TO_CHAR(s.sale_date, 'Day'),
    CASE WHEN EXTRACT(DOW FROM s.sale_date) = 0 
         THEN 7 
         ELSE EXTRACT(DOW FROM s.sale_date) 
    END
ORDER BY
    CASE WHEN EXTRACT(DOW FROM s.sale_date) = 0 
         THEN 7 
         ELSE EXTRACT(DOW FROM s.sale_date) 
    END,
    seller;