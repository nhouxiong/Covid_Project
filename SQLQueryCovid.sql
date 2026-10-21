
--Covid Death Exporation

--Data Using for Exploration
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 1, 2

--1) Total Cases vs Total Deaths In USA (liklihood of getting covid)
SELECT location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location = 'United States' and continent is not null
ORDER BY 1, 2

--2) Total Cases vs Population (what percentage of population got covid)
SELECT location, date, population, total_cases, (total_cases/population)*100 as CovidInfectionPercentage
FROM PortfolioProject..CovidDeaths
WHERE location = 'United States' and continent is not null
ORDER BY 1, 2

--3) Looking At Countries With Hightest Infection Rate Compared To Population
SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentofPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY location, population
ORDER BY PercentofPopulationInfected DESC

--4)Showing Countries With Highest Death Count per Population
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC

--5)Breaking death count by location
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is null
GROUP BY location
ORDER BY TotalDeathCount DESC

--6)Showing continents with hightest death counts
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC

--7)Global Numbers Overall
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 1, 2

--8)Global Numbers by Date
SELECT date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1, 2

--Covid Vaccination Join and Exporation
--9) Total Population vs Vaccinations
WITH PopvsVac (continent, location, date, population, new_vaccinations, RollingVaccinationCount)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION by dea.location ORDER BY dea.location, dea.date) as RollingVaccinationCount
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location 
	and dea.date = vac.date
WHERE dea.continent is not null
)
SELECT *, (RollingVaccinationCount/population)*100
FROM PopvsVac

--VIEW
--10)Creating Views to Store Data for Visualizations
CREATE VIEW PopvsVac as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION by dea.location ORDER BY dea.location, dea.date) as RollingVaccinationCount
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location 
	and dea.date = vac.date
WHERE dea.continent is not null

CREATE VIEW GlobalNumbers as
SELECT date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY date

CREATE VIEW ContinentDeathCount as
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY continent

CREATE VIEW TotalCasesvsPop as
SELECT location, date, population, total_cases, (total_cases/population)*100 as CovidInfectionPercentage
FROM PortfolioProject..CovidDeaths
WHERE location = 'United States' and continent is not null

CREATE VIEW CountriesInfectionRatetoPop as
SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentofPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY location, population

CREATE VIEW CountriesDeathRateperPop as
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY location