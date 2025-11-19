SELECT 
    SUBSTRING_INDEX(release_date, '/', 1) AS month,
    COUNT(*) AS games_released
FROM applications
WHERE type = 'game'
    AND release_date LIKE '%/2025'
GROUP BY month
ORDER BY CAST(month AS UNSIGNED);