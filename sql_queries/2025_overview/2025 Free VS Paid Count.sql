SELECT 
    CASE WHEN is_free = 'True' THEN 'Free' ELSE 'Paid' END AS game_type,
    COUNT(*) AS game_count
FROM applications
WHERE release_date LIKE '%/2025'
GROUP BY is_free;