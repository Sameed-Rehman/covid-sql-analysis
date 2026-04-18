/* ============================================================
   COVID-19 Data Exploration Project (SQL)
   Objective:
   Analyze global COVID-19 data to extract insights on:
   - Infection rates
   - Death ratios
   - Regional comparisons
   - Vaccination progress
   -temp table 
   ============================================================ */


/* ============================================================
   1. Total Cases vs Population
   Calculates percentage of population infected per record
   ============================================================ */

 SELECT 
     location, 
     date, 
     total_cases,
     total_deaths,
     population,
     (total_cases / population) * 100 AS case_percentage_population
 FROM CovidDeaths
 ORDER BY case_percentage_population DESC;


/* ============================================================
   2. Country-Level Aggregated Metrics
   - Total cases and deaths
   - Infection and death percentages relative to population
   ============================================================ */

WITH cte_death_affection_rate AS (
    SELECT 
        location,
        continent,
        population,
        MAX(total_cases) AS total_cases_count,
        MAX(CAST(total_deaths AS INT)) AS total_death_count,
        (MAX(total_cases) / population) * 100 AS percentage_affected,
        (MAX(CAST(total_deaths AS INT)) / population) * 100 AS percentage_death
    FROM CovidDeaths
    GROUP BY location, continent, population
)

-- View summarized country-level data
 --SELECT *
 --FROM cte_death_affection_rate
 --WHERE continent IS NOT NULL
 --ORDER BY percentage_death DESC;


/* ============================================================
   3. Extreme Values (Highest Impact Countries)
   ============================================================ */

-- Most affected country (by infection rate)
 --SELECT TOP 1 
 --    location,
 --    population,
 --    percentage_affected AS highest_infection_rate
 --FROM cte_death_affection_rate
 --WHERE continent IS NOT NULL
 --ORDER BY percentage_affected DESC;

-- Highest death ratio country
 --SELECT TOP 1 
 --    location,
 --    population,
 --    percentage_death AS highest_death_ratio
 --FROM cte_death_affection_rate
 --WHERE continent IS NOT NULL
 --ORDER BY percentage_death DESC;


/* ============================================================
   4. Countries with Highest Total Death Count
   ============================================================ */

 --SELECT 
 --    location,
 --    population,
 --    total_death_count
 --FROM cte_death_affection_rate
 --WHERE continent IS NOT NULL
 --ORDER BY total_death_count DESC;


/* ============================================================
   5. Continent-Level Death Analysis
   Aggregates total deaths per continent
   ============================================================ */

 SELECT TOP 1 
     continent,
     SUM(total_death_count) AS total_deaths
 FROM cte_death_affection_rate
 WHERE continent IS NOT NULL
 GROUP BY continent
 ORDER BY total_deaths DESC;


/* ============================================================
   6. Global Summary Metrics
   ============================================================ */

 SELECT 
     SUM(new_cases) AS global_total_cases,
     SUM(CAST(new_deaths AS INT)) AS global_total_deaths,
     (SUM(CAST(new_deaths AS INT)) / SUM(new_cases)) * 100 AS global_death_percentage
 FROM CovidDeaths
 WHERE continent IS NOT NULL;


/* ============================================================
   7. Vaccination Analysis (Country Level)
   Percentage of population vaccinated
   ============================================================ */

 SELECT 
     cd.location,
     MAX(cv.people_vaccinated) AS people_vaccinated,
     cd.population,
     (MAX(cv.people_vaccinated) / cd.population) * 100 AS vaccination_rate
 FROM CovidDeaths cd
 JOIN CovidVaccinations cv 
     ON cd.location = cv.location 
     AND cd.date = cv.date
 WHERE cd.continent IS NOT NULL
 GROUP BY cd.location, cd.population
 ORDER BY vaccination_rate DESC;


/* ============================================================
   8. Rolling Vaccination Progress
   Tracks cumulative vaccinations over time per country
   ============================================================ */

WITH cte_rolling_vaccination AS (
    SELECT 
        cd.location,
        cd.date,
        cd.population,
        cv.new_vaccinations,
        SUM(CAST(cv.new_vaccinations AS INT)) 
            OVER (PARTITION BY cd.location ORDER BY cd.date) 
            AS rolling_people_vaccinated
    FROM CovidDeaths cd
    JOIN CovidVaccinations cv 
        ON cd.location = cv.location 
        AND cd.date = cv.date
    WHERE cd.continent IS NOT NULL
)

SELECT 
    *,
    (rolling_people_vaccinated / population) * 100 AS vaccination_percentage
FROM cte_rolling_vaccination;


/* ============================================================
   9. Create View for Reusability
   Stores rolling vaccination results for future queries
   ============================================================ */

--CREATE VIEW vw_rolling_vaccination AS
--SELECT 
--    cd.location,
--    cd.date,
--    cd.population,
--    cv.new_vaccinations,
--    SUM(CAST(cv.new_vaccinations AS INT)) 
--        OVER (PARTITION BY cd.location ORDER BY cd.date) 
--        AS rolling_people_vaccinated
--FROM CovidDeaths cd
--JOIN CovidVaccinations cv 
--    ON cd.location = cv.location 
--    AND cd.date = cv.date
--WHERE cd.continent IS NOT NULL;