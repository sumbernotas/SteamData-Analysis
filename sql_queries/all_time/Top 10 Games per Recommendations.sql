SELECT applications.name AS game_title,
       applications.release_date,
       CAST(applications.metacritic_score AS DECIMAL) AS metacritic_score,
       CAST(applications.recommendations_total AS DECIMAL) AS total_recommendations
FROM applications
WHERE applications.type = 'game'
  AND applications.recommendations_total != 'nan'
  AND applications.metacritic_score != 'nan'
ORDER BY CAST(applications.recommendations_total AS DECIMAL) DESC
LIMIT 10;