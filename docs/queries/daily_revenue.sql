SELECT
    order_date,
    SUM(total_amount) AS daily_revenue
FROM `Order`
WHERE order_date = '2025-01-01'
-- WHERE order_date = CURRENT_DATE
GROUP BY order_date;
