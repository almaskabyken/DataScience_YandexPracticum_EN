/* =========================================================
   ЗАДАЧА 1
   =========================================================
   Составить сводную таблицу и вывести среднюю сумму инвестиций
   для стран, в которых есть стартапы, зарегистрированные в
   2011, 2012 и 2013 годах.

   Требования:
   - Данные за каждый год должны быть в отдельном поле
   - Отсортировать результат по среднему значению инвестиций
     за 2011 год (по убыванию)
   ========================================================= */


WITH
-- Средние инвестиции по странам за 2011 год
avg_2011 AS (
    SELECT
        country_code,
        AVG(funding_total) AS avg_funding_2011
    FROM company
    WHERE EXTRACT(YEAR FROM CAST(founded_at AS DATE)) = 2011
    GROUP BY country_code
),

-- Средние инвестиции по странам за 2012 год
avg_2012 AS (
    SELECT
        country_code,
        AVG(funding_total) AS avg_funding_2012
    FROM company
    WHERE EXTRACT(YEAR FROM CAST(founded_at AS DATE)) = 2012
    GROUP BY country_code
),

-- Средние инвестиции по странам за 2013 год
avg_2013 AS (
    SELECT
        country_code,
        AVG(funding_total) AS avg_funding_2013
    FROM company
    WHERE EXTRACT(YEAR FROM CAST(founded_at AS DATE)) = 2013
    GROUP BY country_code
)

-- Итоговая сводная таблица
SELECT
    avg_2011.country_code,
    avg_2011.avg_funding_2011,
    avg_2012.avg_funding_2012,
    avg_2013.avg_funding_2013
FROM avg_2011
JOIN avg_2012
    ON avg_2011.country_code = avg_2012.country_code
JOIN avg_2013
    ON avg_2011.country_code = avg_2013.country_code
ORDER BY avg_2011.avg_funding_2011 DESC;
