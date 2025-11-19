SELECT 
    ROUND(AVG(CAST(current_price AS DECIMAL) / 100), 2) AS avg_game_price_2025
FROM applications
WHERE type = 'game'
    AND release_date LIKE '%/2025'
    AND is_free = 'False'
    AND current_price != 'nan'
    AND current_price != '0'
    AND CAST(current_price AS DECIMAL) / 100 <= 150;