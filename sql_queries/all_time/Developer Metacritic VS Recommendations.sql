SELECT 
    CASE 
        WHEN developers.name LIKE '%Capcom%' THEN 'Capcom'
        WHEN developers.name LIKE '%Ubisoft%' THEN 'Ubisoft'
        WHEN developers.name LIKE '%Square Enix%' THEN 'Square Enix'
        WHEN developers.name LIKE '%Electronic Arts%' OR developers.name LIKE '%EA %' THEN 'Electronic Arts'
        WHEN developers.name LIKE '%Activision%' THEN 'Activision'
        WHEN developers.name LIKE '%Bethesda%' THEN 'Bethesda'
        WHEN developers.name LIKE '%Rockstar%' THEN 'Rockstar Games'
        WHEN developers.name LIKE '%Nintendo%' THEN 'Nintendo'
        ELSE developers.name 
    END AS developer,
    COUNT(*) AS game_count,
    ROUND(AVG(CAST(applications.metacritic_score AS DECIMAL)), 1) AS avg_metacritic_score,
    ROUND(SUM(CAST(applications.recommendations_total AS DECIMAL)), 0) AS total_recommendations
FROM applications
JOIN application_developers 
    ON applications.appid = application_developers.appid
JOIN developers
    ON application_developers.developer_id = developers.id
WHERE applications.type = 'game'
  AND applications.metacritic_score != 'nan'
  AND applications.recommendations_total != 'nan'
GROUP BY 
    CASE 
        WHEN developers.name LIKE '%Capcom%' THEN 'Capcom'
        WHEN developers.name LIKE '%Ubisoft%' THEN 'Ubisoft'
        WHEN developers.name LIKE '%Square Enix%' THEN 'Square Enix'
        WHEN developers.name LIKE '%Electronic Arts%' OR developers.name LIKE '%EA %' THEN 'Electronic Arts'
        WHEN developers.name LIKE '%Activision%' THEN 'Activision'
        WHEN developers.name LIKE '%Bethesda%' THEN 'Bethesda'
        WHEN developers.name LIKE '%Rockstar%' THEN 'Rockstar Games'
        WHEN developers.name LIKE '%Nintendo%' THEN 'Nintendo'
        ELSE developers.name 
    END
HAVING game_count >= 10
ORDER BY total_recommendations DESC;