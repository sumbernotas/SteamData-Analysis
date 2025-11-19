SELECT 
    ROUND(AVG(CAST(current_price AS DECIMAL) / 100), 2) AS avg_game_price_all_time
FROM applications
WHERE type = 'game'
    AND is_free = 'False'
    AND current_price != 'nan'
    AND current_price != '0'
    AND CAST(current_price AS DECIMAL) / 100 <= 150;