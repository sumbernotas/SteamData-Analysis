SELECT COUNT(*) AS total_2025_dlc
FROM applications
WHERE type = 'dlc'
    AND release_date LIKE '%/2025';