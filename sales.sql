--Сравнение продаж по месяцам
WITH monthly_sales AS (
    SELECT 
        TO_CHAR(o.order_date, 'YYYY-MM') AS year_month,
        SUM(oi.amount) AS total_sales,
        LAG(SUM(oi.amount)) OVER (ORDER BY TO_CHAR(o.order_date, 'YYYY-MM')) AS prev_month_sales,
        LAG(TO_CHAR(o.order_date, 'YYYY-MM')) OVER (ORDER BY TO_CHAR(o.order_date, 'YYYY-MM')) AS prev_month,
        LAG(SUM(oi.amount)) OVER (
            PARTITION BY EXTRACT(MONTH FROM o.order_date)
            ORDER BY EXTRACT(YEAR FROM o.order_date)
        ) AS prev_year_sales
    FROM 
        orders o
    JOIN 
        order_items oi ON o.id = oi.order_id
    GROUP BY 
        TO_CHAR(o.order_date, 'YYYY-MM'),
        EXTRACT(MONTH FROM o.order_date),
        EXTRACT(YEAR FROM o.order_date)
)
SELECT 
    year_month,
    total_sales,
    CASE 
        WHEN prev_month IS NULL 
             OR TO_DATE(year_month, 'YYYY-MM') - INTERVAL '1 month' <> TO_DATE(prev_month, 'YYYY-MM')
        THEN NULL
        ELSE ROUND((total_sales - prev_month_sales) * 100.0 / prev_month_sales, 2)
    END AS prev_month_diff,
    CASE 
        WHEN prev_year_sales IS NULL THEN NULL
        ELSE ROUND((total_sales - prev_year_sales) * 100.0 / prev_year_sales, 2)
    END AS prev_year_diff
FROM 
    monthly_sales
ORDER BY 
    year_month;