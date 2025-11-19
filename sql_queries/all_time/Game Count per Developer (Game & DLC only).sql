SELECT 
    CASE 
        WHEN developers.name LIKE '%Capcom%' THEN 'Capcom'
        WHEN developers.name LIKE '%Ubisoft%' THEN 'Ubisoft'
        WHEN developers.name LIKE '%Square Enix%' THEN 'Square Enix'
        WHEN developers.name LIKE '%Electronic Arts%' OR developers.name LIKE '%EA %' THEN 'Electronic Arts'
        WHEN developers.name LIKE '%Activision%' THEN 'Activision'
        WHEN developers.name LIKE '%Bethesda%' THEN 'Bethesda'
        WHEN developers.name LIKE '%Rockstar%' THEN 'Rockstar Games'
        ELSE developers.name 
    END AS developer,
    COUNT(*) AS game_count
FROM applications
JOIN application_developers 
    ON applications.appid = application_developers.appid
JOIN developers
    ON application_developers.developer_id = developers.id
WHERE applications.type IN ('game', 'dlc')
GROUP BY 
    CASE 
        WHEN developers.name LIKE '%Capcom%' THEN 'Capcom'
        WHEN developers.name LIKE '%Ubisoft%' THEN 'Ubisoft'
        WHEN developers.name LIKE '%Square Enix%' THEN 'Square Enix'
        WHEN developers.name LIKE '%Electronic Arts%' OR developers.name LIKE '%EA %' THEN 'Electronic Arts'
        WHEN developers.name LIKE '%Activision%' THEN 'Activision'
        WHEN developers.name LIKE '%Bethesda%' THEN 'Bethesda'
        WHEN developers.name LIKE '%Rockstar%' THEN 'Rockstar Games'
        ELSE developers.name 
    END
ORDER BY game_count DESC;