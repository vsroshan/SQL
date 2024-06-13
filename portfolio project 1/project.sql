-- SELECT * FROM `portfolio project`.`covid deaths`
-- SELECT location,date,total_cases,new_cases,total_deaths,population_density FROM `portfolio project`.`covid deaths`
-- order by 1,2;

-- SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as death_percentage FROM `portfolio project`.`covid deaths`
-- where location like '%India%'
-- order by 1,2;
-- SELECT location,date,total_cases,population_density,(total_cases/population_density)*100 as 'affected percentage' FROM `portfolio project`.`covid deaths`
-- where location like '%India%'
-- order by 1,2;
SELECT location,population_density,max(total_cases)as 'HIGH INFECTION COUNT',max((total_cases/population_density))*100 as 'percentage population affected' FROM `portfolio project`.`covid deaths`
group by location,population_density
 order by 'percentage population affected' desc;
