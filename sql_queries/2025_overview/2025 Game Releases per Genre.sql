SELECT genres.name AS genre,
       COUNT(*) AS games_released_2025
FROM applications
JOIN application_genres ON applications.appid = application_genres.appid
JOIN genres ON application_genres.genre_id = genres.id
WHERE applications.type = 'game'
    AND applications.release_date LIKE '%/2025'
GROUP BY genres.name
ORDER BY games_released_2025 DESC
LIMIT 10;