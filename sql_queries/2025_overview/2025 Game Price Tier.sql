SELECT 
    CASE 
        WHEN CAST(current_price AS DECIMAL) / 100 = 0 THEN 'Free'
        WHEN CAST(current_price AS DECIMAL) / 100 < 20 THEN 'Budget ($0-$19.99)'
        WHEN CAST(current_price AS DECIMAL) / 100 < 40 THEN 'Standard ($20-$39.99)'
        ELSE 'Premium ($40+)'
    END AS price_tier,
    COUNT(*) AS game_count,
    ROUND(AVG(CAST(metacritic_score AS DECIMAL)), 1) AS avg_score
FROM applications
WHERE type = 'game'
    AND release_date LIKE '%/2025'
    AND metacritic_score != 'nan'
GROUP BY price_tier
ORDER BY FIELD(price_tier, 'Free', 'Budget ($0-$19.99)', 'Standard ($20-$39.99)', 'Premium ($40+)');