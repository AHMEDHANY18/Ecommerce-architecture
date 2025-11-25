SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS total_spent_last_month
FROM Customer c
JOIN `Order` o
    ON c.customer_id = o.customer_id
WHERE
    o.order_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY
    c.customer_id, customer_name
HAVING
    SUM(o.total_amount) > 500
ORDER BY
    total_spent_last_month DESC;
