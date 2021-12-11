-- Total Population vs Total Vaccination using CTE
with PopvsVac (continent, location, date, population, new_vaccinations, cumulative_people_vaccinations)
as 
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations as bigint)) 
over (partition by dea.location order by dea.location, dea.date) as cumulative_people_vaccinations
from PortfolioProject..covid_deaths$ dea
join PortfolioProject..covid_vaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
select * , (cumulative_people_vaccinations/population)/100
from PopvsVac

-- Total Population vs Total Vaccination using Temp table
drop table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
cumulative_people_vaccinations numeric
)
Insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations as bigint)) 
over (partition by dea.location order by dea.location, dea.date) as cumulative_people_vaccinations
from PortfolioProject..covid_deaths$ dea
join PortfolioProject..covid_vaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
select * , (cumulative_people_vaccinations/population)/100
from #PercentPopulationVaccinated

-- Creating view to store data for later visualizations
create view PercentPopulationVaccinated1 as 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations as bigint)) 
over (partition by dea.location order by dea.location, dea.date) as cumulative_people_vaccinations
from PortfolioProject..covid_deaths$ dea
join PortfolioProject..covid_vaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
