EXPLAIN ANALYZE SELECT name, color, 'toy' as type
FROM toys
WHERE color = 'Red'
UNION
SELECT name, color, 'cat' as type
FROM cats
WHERE color = 'Red';

EXPLAIN ANALYZE SELECT name
FROM cats
WHERE color = 'Orange';

EXPLAIN ANALYZE SELECT toys.name, toys.price
FROM toys
LEFT JOIN cattoys ON cattoys.toy_id = toys.id
LEFT JOIN cats ON cats.id = cattoys.cat_id
WHERE cats.breed = 'British Shorthair';


SELECT DISTINCT c1.name, t1.name
FROM cats c1
    LEFT JOIN cattoys ON cattoys.cat_id = c1.id
    LEFT JOIN toys t1 ON cattoys.toy_id = t1.id
WHERE t1.id IN (
      SELECT t2.id
FROM toys t2
    LEFT JOIN cattoys ct2 ON ct2.toy_id = t2.id
    LEFT JOIN cats c2 ON ct2.cat_id = c2.id
WHERE c2.name = 'Jet'
    )
AND c1.name != 'Jet'
    ORDER BY c1.name;
