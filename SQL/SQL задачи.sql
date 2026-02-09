/* =========================================================
   TASK #1
   =========================================================
   For countries where startups were founded in 2011–2013,
   build a summary table with the following fields:

   - country_code
   - avg_funding_2011 / 2012 / 2013
   - share_2011: share of 2011 average funding relative to
     the total sum of 2011 averages across all countries
   - rank_2011: country rank based on avg_funding_2011

   Conditions:
   - Include only years 2011–2013
   - Keep only countries that have data for all 3 years
   - Sort by avg_funding_2011 DESC
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
   TASK #2
   =========================================================
   Extract monthly data (month number) for the period 2010–2013
   and calculate the following metrics:

   - month: month number
   - unique_funds_usa: number of unique US-based funds that
     invested in funding rounds during the month
   - acquired_companies_count: number of companies acquired
     during the month
   - total_deal_amount: total acquisition deal amount during
     the month
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
