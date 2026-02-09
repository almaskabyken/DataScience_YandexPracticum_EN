/* =========================================================
   ЗАДАЧА №1 
   =========================================================
   Для стран, в которых есть стартапы, зарегистрированные в 2011–2013,
   постройте сводную таблицу:

   - country_code
   - avg_funding_2011 / 2012 / 2013
   - share_2011: доля среднего 2011 года от суммы средних 2011 по всем странам
   - rank_2011: ранг страны по avg_funding_2011

   Условия:
   - учитывать только 2011–2013
   - оставить только страны, у которых есть данные за все 3 года
   - сортировка по avg_funding_2011 DESC
   ========================================================= */

WITH base AS (
    SELECT
        country_code,
        EXTRACT(YEAR FROM CAST(founded_at AS DATE))::int AS yr,
        funding_total
    FROM company
    WHERE EXTRACT(YEAR FROM CAST(founded_at AS DATE)) BETWEEN 2011 AND 2013
      AND country_code IS NOT NULL
      AND founded_at IS NOT NULL
),
pivoted AS (
    SELECT
        country_code,
        AVG(funding_total) FILTER (WHERE yr = 2011) AS avg_funding_2011,
        AVG(funding_total) FILTER (WHERE yr = 2012) AS avg_funding_2012,
        AVG(funding_total) FILTER (WHERE yr = 2013) AS avg_funding_2013
    FROM base
    GROUP BY country_code
)
SELECT
    country_code,
    avg_funding_2011,
    avg_funding_2012,
    avg_funding_2013,
    avg_funding_2011 / NULLIF(SUM(avg_funding_2011) OVER (), 0) AS share_2011,
    RANK() OVER (ORDER BY avg_funding_2011 DESC)                AS rank_2011
FROM pivoted
WHERE avg_funding_2011 IS NOT NULL
  AND avg_funding_2012 IS NOT NULL
  AND avg_funding_2013 IS NOT NULL
ORDER BY avg_funding_2011 DESC;


/* =========================================================
   ЗАДАЧА №2
   =========================================================
   Отобрать данные по месяцам (номер месяца) за 2010–2013 годы и получить:

   - month: номер месяца
   - unique_funds_usa: кол-во уникальных фондов из США, инвестировавших в раунды
   - acquired_companies_count: кол-во купленных компаний в этом месяце
   - total_deal_amount: сумма сделок по покупкам в этом месяце
   ========================================================= */

WITH
funds_cte AS (
    SELECT
        EXTRACT(MONTH FROM fr.funded_at)::int AS month,
        COUNT(DISTINCT f.name) FILTER (WHERE f.country_code = 'USA') AS unique_funds_usa
    FROM funding_round AS fr
    LEFT JOIN investment AS i
        ON fr.id = i.funding_round_id
    LEFT JOIN fund AS f
        ON i.fund_id = f.id
    WHERE fr.funded_at IS NOT NULL
      AND EXTRACT(YEAR FROM fr.funded_at) BETWEEN 2010 AND 2013
    GROUP BY EXTRACT(MONTH FROM fr.funded_at)
),
acquisitions_cte AS (
    SELECT
        EXTRACT(MONTH FROM a.acquired_at)::int AS month,
        COUNT(a.acquired_company_id)          AS acquired_companies_count,
        SUM(a.price_amount)                   AS total_deal_amount
    FROM acquisition AS a
    WHERE a.acquired_at IS NOT NULL
      AND EXTRACT(YEAR FROM a.acquired_at) BETWEEN 2010 AND 2013
    GROUP BY EXTRACT(MONTH FROM a.acquired_at)
)

SELECT
    COALESCE(f.month, a.month)              AS month,
    COALESCE(f.unique_funds_usa, 0)         AS unique_funds_usa,
    COALESCE(a.acquired_companies_count, 0) AS acquired_companies_count,
    COALESCE(a.total_deal_amount, 0)        AS total_deal_amount
FROM funds_cte AS f
FULL OUTER JOIN acquisitions_cte AS a
    ON f.month = a.month
ORDER BY month;
