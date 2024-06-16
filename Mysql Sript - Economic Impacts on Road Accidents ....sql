SELECT * FROM `uk road accident - 2021 & 2022 dataset`.uk_road_accidents;

--- Data Wrang------
UPDATE uk_road_accidents
SET Accident_Severity='Fatal'
WHERE Accident_Severity='Fetal';

SELECT * FROM `uk road accident - 2021 & 2022 dataset`.uk_road_accidents
WHERE Accident_Severity = 'Fetal';


------ Add Month_Name Column-----------
SELECT Accident_Date, monthname(Accident_Date) as Month_Name
FROM `uk road accident - 2021 & 2022 dataset`.uk_road_accidents;

ALTER TABLE `uk road accident - 2021 & 2022 dataset`.uk_road_accidents
ADD Month_Name text;

UPDATE `uk road accident - 2021 & 2022 dataset`.uk_road_accidents
SET Month_Name = monthname(Accident_Date);


------ Add Year Column-----------
SELECT Accident_Date, year(Accident_Date) as Year
FROM `uk road accident - 2021 & 2022 dataset`.uk_road_accidents;

ALTER TABLE `uk road accident - 2021 & 2022 dataset`.uk_road_accidents
ADD Year int2;

UPDATE `uk road accident - 2021 & 2022 dataset`.uk_road_accidents
SET Year = year(Accident_Date);


-------  Join uk_road_accidents and cost tables together --------------
SELECT u.Accident_Date, u.Day_of_Week, u.Junction_Control, u.Junction_Detail, u.Accident_Severity,
u.Light_Conditions, u.Number_of_Casualties, u.Number_of_Vehicles,
u.Road_Surface_Conditions, u.Road_Type, u.Time, u.Urban_or_Rural_Area, u.Weather_Conditions, 
u.Vehicle_Type, u.Month_Name, u.Year,
c.Casualty_Cost, c.Accident_Cost
FROM `uk road accident - 2021 & 2022 dataset`.uk_road_accidents as u
JOIN `uk road accident - 2021 & 2022 dataset`.cost as c ON u.Accident_Severity = c.Accident_Severity;


--------- create a new table - economic_impacts_of_road_accidents_on_uk_gdp ----------
CREATE TABLE economic_impacts_of_road_accidents_on_uk_gdp
SELECT u.Accident_Date, u.Day_of_Week, u.Junction_Control, u.Junction_Detail, u.Accident_Severity,
u.Light_Conditions, u.Number_of_Casualties, u.Number_of_Vehicles,
u.Road_Surface_Conditions, u.Road_Type, u.Time, u.Urban_or_Rural_Area, u.Weather_Conditions, 
u.Vehicle_Type, u.Month_Name, u.Year,
c.Casualty_Cost, c.Accident_Cost
FROM `uk road accident - 2021 & 2022 dataset`.uk_road_accidents as u
JOIN `uk road accident - 2021 & 2022 dataset`.cost as c ON u.Accident_Severity = c.Accident_Severity;


----- Add a new column - Total_Casualty_Cost ----------------
SELECT Number_of_Casualties, Casualty_Cost, (Number_of_Casualties * Casualty_Cost) as Total_Casualty_Cost
FROM `uk road accident - 2021 & 2022 dataset`.economic_impacts_of_road_accidents_on_uk_gdp;

ALTER TABLE `uk road accident - 2021 & 2022 dataset`.economic_impacts_of_road_accidents_on_uk_gdp
ADD Total_Casualty_Cost bigint;

UPDATE `uk road accident - 2021 & 2022 dataset`.economic_impacts_of_road_accidents_on_uk_gdp
SET Total_Casualty_Cost = (Number_of_Casualties * Casualty_Cost);

----- Add a new column - Total_Accident_Cost ----------------
SELECT Number_of_Casualties, Accident_Cost, (Number_of_Casualties * Accident_Cost) as Total_Accident_Cost
FROM `uk road accident - 2021 & 2022 dataset`.economic_impacts_of_road_accidents_on_uk_gdp;

ALTER TABLE `uk road accident - 2021 & 2022 dataset`.economic_impacts_of_road_accidents_on_uk_gdp
ADD Total_Accident_Cost bigint;

UPDATE `uk road accident - 2021 & 2022 dataset`.economic_impacts_of_road_accidents_on_uk_gdp
SET Total_Accident_Cost = (Number_of_Casualties * Accident_Cost);

----- Add a new column - Total_Payment ----------------
SELECT Total_Casualty_Cost, Total_Accident_Cost, (Total_Casualty_Cost + Total_Accident_Cost) as Total_Payment
FROM `uk road accident - 2021 & 2022 dataset`.economic_impacts_of_road_accidents_on_uk_gdp;

ALTER TABLE `uk road accident - 2021 & 2022 dataset`.economic_impacts_of_road_accidents_on_uk_gdp
ADD Total_Payment bigint;

UPDATE `uk road accident - 2021 & 2022 dataset`.economic_impacts_of_road_accidents_on_uk_gdp
SET Total_Payment = (Total_Casualty_Cost + Total_Accident_Cost);

SELECT * FROM `uk road accident - 2021 & 2022 dataset`.economic_impacts_of_road_accidents_on_uk_gdp;