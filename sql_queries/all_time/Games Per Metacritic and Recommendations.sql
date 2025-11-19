SELECT name,
		release_date,
        CAST(metacritic_score AS DECIMAL) AS metacritic_score,
        CAST(recommendations_total AS DECIMAL) AS total_recommendations
FROM applications
WHERE metacritic_Score != 'nan' AND recommendations_total != 'nan'
ORDER BY CAST(metacritic_score AS DECIMAL) DESC