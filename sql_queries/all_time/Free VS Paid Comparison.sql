SELECT 
    CASE WHEN is_free = 'True' THEN 'Free' ELSE 'Paid' END AS game_type,
    COUNT(*) AS game_count,
    ROUND(AVG(CAST(metacritic_score AS DECIMAL)), 1) AS avg_score,
    ROUND(AVG(CAST(recommendations_total AS DECIMAL)), 0) AS avg_recommendations
FROM applications
WHERE type = 'game' OR 'dlc'
  AND metacritic_score != 'nan'
GROUP BY is_free;