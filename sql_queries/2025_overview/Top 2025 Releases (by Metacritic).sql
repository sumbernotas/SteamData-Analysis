SELECT applications.name AS game_title,
       applications.release_date,
       CAST(applications.metacritic_score AS DECIMAL) AS metacritic_score,
       CAST(applications.recommendations_total AS DECIMAL) AS recommendations_total
FROM applications
WHERE applications.type = 'game'
  AND applications.release_date LIKE '%/2025'
  AND applications.metacritic_score != 'nan'
  AND applications.recommendations_total != 'nan'
ORDER BY CAST(applications.metacritic_score AS DECIMAL) DESC;