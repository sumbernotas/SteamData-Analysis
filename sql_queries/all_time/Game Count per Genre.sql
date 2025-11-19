SELECT genres.name AS genre,
       COUNT(*) AS game_count
FROM applications
JOIN application_genres 
    ON applications.appid = application_genres.appid
JOIN genres
    ON application_genres.genre_id = genres.id
WHERE applications.type IN ('game', 'dlc')
GROUP BY genres.name
ORDER BY game_count DESC;