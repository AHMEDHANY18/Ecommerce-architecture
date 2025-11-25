SELECT
    p.product_id,
    p.name AS product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM Order_details od
JOIN `Order` o
    ON od.order_id = o.order_id
JOIN Product p
    ON od.product_id = p.product_id
WHERE
    MONTH(o.order_date) = 1
    AND YEAR(o.order_date) = 2025
GROUP BY
    p.product_id, p.name
ORDER BY
    total_quantity_sold DESC
