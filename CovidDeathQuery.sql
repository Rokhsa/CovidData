--Select *
--From CovidDeaths

--Select * 
--From CovidVaccinations
--Order By 3,4

Select Location, date, total_cases, new_cases, total_deaths, population 
From CovidDeaths
Order By 1,2

--Looking at Total Cases vs Total Deaths
--Shows likelihood dying if you contract Covid in your Country
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
Where Location like '%Iran%'
Order By 1,2

--Looking at the total Cases vs Population 
--Shows what percentage of population gut Covid
Select Location, date, population, total_cases, (total_cases/population)*100 as CovidPercentage
From CovidDeaths
--Where Location like '%Iran%'
Order By 1,2


--Looking at Countries with Highest Infection Rate Compared to Population 
Select Location, population, Max(total_cases) as HighestInfectioncount, Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDeaths
Group By population, Location
Order By PercentPopulationInfected desc

--Looking at Countries with Highest Death Count per Population 
Select Location, Max(cast (total_deaths as int)) as TotalDeathcount
From CovidDeaths
Where continent Is NOT NULL
Group By Location
Order By TotalDeathcount desc


--Let's Break Things Dwon By Continent
--Showing the Continent With The Highest Death Count per Population 

Select continent, Max(cast (total_deaths as int)) as TotalDeathcount
From CovidDeaths
Where continent Is Not NULL
Group By continent
Order By TotalDeathcount desc
--AND

Select Location, Max(cast(total_deaths as int)) as TotalDeathcount
From CovidDeaths
Where continent Is NULL
Group By Location
Order By TotalDeathcount desc


--Global Numbers per date
Select date, Sum(new_cases) As total_cases, Sum(Cast(new_deaths as int)) As Total_deaths, Sum(Cast(new_deaths as int))/Sum(new_cases)*100 as DeathPercentage
From CovidDeaths
Where continent IS NOT NULL 
Group By date 
Order By 1,2

--Global Numbers
Select Sum(new_cases) As total_cases, Sum(Cast(new_deaths as int)) As Total_deaths, Sum(Cast(new_deaths as int))/Sum(new_cases)*100 as DeathPercentage
From CovidDeaths
Where continent IS NOT NULL 
--Group By date 
Order By 1,2

