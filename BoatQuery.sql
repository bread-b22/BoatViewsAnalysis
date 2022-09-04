-- Select correct database
USE BoatProject;

--------------DATA EXPLORATION--------------
--SELECT * FROM BoatData;
-- This file just has some light queries listed and exploration for Tableau 

-- Are some countries more common?
SELECT
  Country,
  COUNT(Country) AS Num
FROM BoatData
GROUP BY Country
ORDER BY Num DESC;

-- Checking if there is price variability in the top 5 countries 
SELECT
  Country,
  AVG(EuroPrice) AS AvgPrice
FROM BoatData
GROUP BY Country
HAVING COUNT(Country) > 1000
ORDER BY AVG(EuroPrice) DESC;
-- Might be interesting to make a map of average price in each country

---------------------------------------------

-- Which country had the most views in the past 7 days?
SELECT TOP 10
  Country,
  SUM(NumViews7Day) AS TotalViews
FROM BoatData
GROUP BY Country
ORDER BY TotalViews DESC;

---------------------------------------------
-- What are the summary statistics for length and width?

SELECT
  'total',
  SUM(Length) AS Length,
  SUM(Width) AS Width
FROM BoatData
UNION
SELECT
  'average',
  AVG(Length),
  AVG(Width)
FROM BoatData
UNION
SELECT
  'min',
  MIN(Length),
  MIN(Width)
FROM BoatData
UNION
SELECT
  'max',
  MAX(Length),
  MAX(Width)
FROM BoatData


---------------------------------------------
-- Are more expensive boats viewed more often?

SELECT
  EuroPrice,
  Year,
  Country,
  NumViews7Day
FROM BoatData
WHERE NumViews7Day > 1000
ORDER BY NumViews7Day DESC;
-- Price does not seem to be a determining factor in views, it varies greatly


----------------------------------------------
-- What materials are commonly used?

SELECT
  Material,
  COUNT(Material) AS Count
FROM BoatData
GROUP BY Material
ORDER BY Count DESC;

-- Most common boat types?
SELECT TOP 10
  BoatType,
  COUNT(BoatType) AS Count
FROM BoatData
GROUP BY BoatType
ORDER BY Count DESC;

----------------------------------------------
-- Create one view that may be useful
CREATE VIEW CountryStats
AS
SELECT
  Country,
  COUNT(Country) AS NumBoats,
  AVG(EuroPrice) AS AvgPrice,
  ROUND(AVG(Length), 2) AS AvgLength,
  ROUND(AVG(Width), 2) AS AvgWidth,
  ROUND(AVG(NumViews7Day), 2) AS AvgViews
FROM BoatData
GROUP BY Country;

-- That's enough data exploration, the rest will be easier to visualize once in Tableau