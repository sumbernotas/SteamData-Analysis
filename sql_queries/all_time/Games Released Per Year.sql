SELECT 
    SUBSTRING_INDEX(release_date, '/', -1) AS release_year,
    COUNT(*) AS games_released
FROM applications
WHERE type = 'game'
    AND release_date IS NOT NULL
    AND release_date != ''
    AND release_date != 'nan'
GROUP BY release_year
ORDER BY games_released DESC;