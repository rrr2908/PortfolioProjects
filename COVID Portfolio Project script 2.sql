select * 
from PortfolioProject..covid_deaths$
where continent is not null
order by 3,4

--select * 
--from PortfolioProject..covid_vaccinations$
--order by 3,4

select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..covid_deaths$
where continent is not null
order by 1,2

-- Total Cases vs Total Deaths
-- Displays chances of dying due to covid in India
select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
From PortfolioProject..covid_deaths$
where location like '%India%' AND continent is not null
order by 1,2

-- Total Cases vs Population
-- Displays percentage of population that got covid in India
select Location, date, population, total_cases, (total_cases/population)*100 as percentage_of_infected_population
From PortfolioProject..covid_deaths$
where location like '%India%' and continent is not null
order by 1,2

-- Countries with high infection rate
select Location, population, MAX(total_cases) as highest_Infection_Count, MAX((total_cases/population))*100 as percentage_of_infected_population
From PortfolioProject..covid_deaths$
where continent is not null
group by Location, population
order by percentage_of_infected_population desc

-- Countries with highest death count per population
select Location, MAX(cast((total_deaths) as int)) as total_death_count
From PortfolioProject..covid_deaths$
where continent is not null
group by Location
order by total_death_count desc

-- Countinents with highest death count per population
select location, MAX(cast((total_deaths) as int)) as total_death_count
From PortfolioProject..covid_deaths$
where continent is null
group by location
order by total_death_count desc

-- Global Numbers (total new cases everyday, total new deaths everyday, death percentage )
select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Death_Percentage
From PortfolioProject..covid_deaths$
where continent is not null
group by date
order by 1,2

-- Global Numbers (total)
select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Death_Percentage
From PortfolioProject..covid_deaths$
where continent is not null
order by 1,2

