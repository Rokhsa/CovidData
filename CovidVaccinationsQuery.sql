Select *
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.Location = vac.Location 
	and dea.date = vac.date

--Looking at Total Population vs Vaccinations
Select dea.continent, dea.Location, dea.date, dea.Population, dea.new_vaccinations
, Sum(Cast(dea.new_vaccinations As int)) OVER (Partition By dea.Location Order By dea.Location, 
	dea.date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/Population) *100
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.Location = vac.Location 
	and dea.date = vac.date
Where dea.continent IS NOT NUll 
Order By 2,3 


--USE CTE

with PopvsVac (Continent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated)
as 
(
Select dea.continent, dea.Location, dea.date, dea.Population, dea.new_vaccinations
, Sum(Cast(dea.new_vaccinations As int)) OVER (Partition By dea.Location Order By dea.Location, 
	dea.date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/Population) *100
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.Location = vac.Location 
	and dea.date = vac.date
Where dea.continent IS NOT NUll 
--Order By 2,3 
)
Select *, (RollingPeopleVaccinated/Population) *100 AS Percent_RollingPeopleVaccinated
From PopvsVac 



--Temp Table 

--DROP Table If exists #PercentPopulationVacinated
Create Table #PercentPopulationVacinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccination numeric,
RollingPeopleVaccinated numeric
)

Insert Into #PercentPopulationVacinated
Select dea.continent, dea.Location, dea.date, dea.Population, dea.new_vaccinations
, Sum(Cast(dea.new_vaccinations As int)) OVER (Partition By dea.Location Order By dea.Location, 
	dea.date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/Population) *100
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.Location = vac.Location 
	and dea.date = vac.date
Where dea.continent IS NOT NUll 
--Order By 2,3 

Select *, (RollingPeopleVaccinated/Population) *100 AS Percent_RollingPeopleVaccinated
From #PercentPopulationVacinated




--Creating View to Store Data for Visualization 

Create View PercentPopulationVacinated as
Select dea.continent, dea.Location, dea.date, dea.Population, dea.new_vaccinations
, Sum(Cast(dea.new_vaccinations As int)) OVER (Partition By dea.Location Order By dea.Location, 
	dea.date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/Population) *100
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.Location = vac.Location 
	and dea.date = vac.date
Where dea.continent IS NOT NUll 
--Order By 2,3 


Select *
From PercentPopulationVacinated  


