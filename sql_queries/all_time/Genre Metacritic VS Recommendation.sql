SELECT genres.name AS genre,
       COUNT(*) AS game_count,
       ROUND(AVG(CAST(applications.metacritic_score AS DECIMAL)), 1) AS avg_metacritic_score,
       ROUND(SUM(CAST(applications.recommendations_total AS DECIMAL)), 0) AS total_recommendations
FROM applications
JOIN application_genres 
    ON applications.appid = application_genres.appid
JOIN genres
    ON application_genres.genre_id = genres.id
WHERE applications.type = 'game'
  AND applications.metacritic_score != 'nan'
  AND applications.recommendations_total != 'nan'
GROUP BY genres.name
HAVING game_count >= 50
ORDER BY total_recommendations DESC;