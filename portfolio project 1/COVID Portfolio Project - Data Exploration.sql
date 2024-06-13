/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

Select *
From  `portfolio project`.`covid deaths` 
Where continent is not null 
order by 3,4;


-- Select Data that we are going to be starting with

SELECT Location, date, total_cases, new_cases, total_deaths, population_density 
FROM `portfolio project`.`covid deaths` 
WHERE continent IS NOT NULL 
ORDER BY Location, date;


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From  `portfolio project`.`covid deaths` 
Where location like '%India%'
and continent is not null 
order by 1,2;


-- Total Cases vs population_density
-- Shows what percentage of population_density infected with Covid

Select Location, date, population_density, total_cases,  (total_cases/population_density)*100 as Percentpopulation_densityInfected
From  `portfolio project`.`covid deaths` 
Where location like '%India%'
order by 1,2;


-- Countries with Highest Infection Rate compared to population_density

Select Location, population_density, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population_density))*100 as Percentpopulation_densityInfected
From  `portfolio project`.`covid deaths` 
Where location like '%India%'
Group by Location, population_density
order by Percentpopulation_densityInfected desc;


-- Countries with Highest Death Count per population_density

SELECT Location, MAX(CAST(Total_deaths AS UNSIGNED)) AS TotalDeathCount 
FROM `portfolio project`.`covid deaths` 
WHERE continent IS NOT NULL 
GROUP BY Location 
ORDER BY TotalDeathCount DESC;



-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

Select continent, MAX(cast(Total_deaths as unsigned)) as TotalDeathCount
From  `portfolio project`.`covid deaths` 
Where location like '%India%' and
 continent is not null 
Group by continent
order by TotalDeathCount desc;



-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as unsigned)) as total_deaths, SUM(cast(new_deaths as unsigned))/SUM(New_Cases)*100 as DeathPercentage
From  `portfolio project`.`covid deaths` 
Where location like '%India%'
and continent is not null 
Group By date
order by 1,2;



-- Total population_density vs Vaccinations
-- Shows Percentage of population_density that has recieved at least one Covid Vaccine

SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population_density, 
    vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS UNSIGNED)) OVER (PARTITION BY dea.Location ORDER BY dea.date) AS RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population_density)*100 
FROM 
    `portfolio project`.`covid deaths` dea 
JOIN 
    `PortfolioProject`.`CovidVaccinations` vac  
ON 
    dea.location = vac.location  
    AND dea.date = vac.date 
WHERE 
    dea.continent IS NOT NULL  
ORDER BY 
    dea.location, dea.date;


-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, population_density, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population_density, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as unsigned )) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
, (RollingPeopleVaccinated/population_density)*100
From  `portfolio project`.`covid deaths` as dea 
Join `portfolio project`.`covid vacinations` as vac 
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by  2,3
)
Select *, (RollingPeopleVaccinated/population_density)*100
From PopvsVac;



-- Using Temp Table to perform Calculation on Partition By in previous query

DROP TABLE IF EXISTS Percentpopulation_densityVaccinated;

CREATE TEMPORARY TABLE Percentpopulation_densityVaccinated (
    Continent VARCHAR(255),
    Location VARCHAR(255),
    Date DATETIME,
    population_density NUMERIC,
    New_vaccinations NUMERIC,
    RollingPeopleVaccinated NUMERIC
);

Insert into Percentpopulation_densityVaccinated
Select dea.continent, dea.location, dea.date, dea.population_density, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as unsigned )) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
, (RollingPeopleVaccinated/population_density)*100
From  `portfolio project`.`covid deaths`  dea
Join `portfolio project`.`covid vacinations` vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3;

Select *, (RollingPeopleVaccinated/population_density)*100
From Percentpopulation_densityVaccinated;




-- Creating View to store data for later visualizations

CREATE VIEW Percentpopulation_densityVaccinated AS
SELECT
    subquery.continent,
    subquery.location,
    subquery.date,
    subquery.population_density,
    subquery.new_vaccinations,
    subquery.RollingPeopleVaccinated,
    (subquery.RollingPeopleVaccinated / subquery.population_density) * 100 AS PercentPopulationDensityVaccinated
FROM (
    SELECT 
        dea.continent,
        dea.location,
        dea.date,
        dea.population_density,
        vac.new_vaccinations,
        SUM(CAST(vac.new_vaccinations AS UNSIGNED)) OVER (PARTITION BY dea.Location ORDER BY dea.date) AS RollingPeopleVaccinated
    FROM 
        `portfolio project`.`covid deaths` dea
    JOIN 
        `portfolio project`.`covid vacinations` vac
    ON 
        dea.location = vac.location
        AND dea.date = vac.date
    WHERE 
        dea.continent IS NOT NULL
) AS subquery;


