SELECT ROUND(AVG(CAST(metacritic_score AS DECIMAL)), 1) AS avg_metacritic_2025
FROM applications
WHERE type = 'game'
    AND release_date LIKE '%/2025'
    AND metacritic_score != 'nan';