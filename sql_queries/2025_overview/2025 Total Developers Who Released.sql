SELECT COUNT(DISTINCT developers.id) AS total_2025_developers
FROM developers
JOIN application_developers ON developers.id = application_developers.developer_id
JOIN applications ON application_developers.appid = applications.appid
WHERE applications.type = 'game'
    AND applications.release_date LIKE '%/2025';