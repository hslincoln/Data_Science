/* Cleaning Data */

--Add Ride Length
ALTER TABLE Cyclistic.dbo.all_data 
ADD ride_length INT NULL
GO   

UPDATE Cyclistic.dbo.all_data SET ride_length = DATEDIFF(MINUTE, started_at, ended_at)

ALTER TABLE Cyclistic.dbo.all_data 
    ALTER COLUMN ride_length INT NOT NULL

--Add Day of the Week
ALTER TABLE Cyclistic.dbo.all_data 
ADD day_of_week NVARCHAR (10) NULL
GO   

UPDATE Cyclistic.dbo.all_data SET day_of_week = DATENAME(WEEKDAY, started_at)

ALTER TABLE Cyclistic.dbo.all_data 
    ALTER COLUMN day_of_week NVARCHAR (10) NOT NULL

--Add Month (number and text)
ALTER TABLE Cyclistic.dbo.all_data 
ADD ride_month INT NULL
GO   

UPDATE Cyclistic.dbo.all_data SET ride_month = month(started_at)

ALTER TABLE Cyclistic.dbo.all_data 
    ALTER COLUMN ride_month INT NOT NULL

ALTER TABLE Cyclistic.dbo.all_data 
ADD ride_month_text NVARCHAR(10) NULL
GO   

UPDATE Cyclistic.dbo.all_data SET ride_month_text = DATENAME(MONTH,started_at)

ALTER TABLE Cyclistic.dbo.all_data 
    ALTER COLUMN ride_month_text NVARCHAR(10) NOT NULL

-- Deleted rows that have NULL values, or ride length <= 0 or ride_length > 1440 mins
DELETE FROM [Cyclistic].dbo.[all_data]
Where ride_id IS NULL OR
start_station_name IS NULL OR
ride_length IS NULL OR
ride_length <= 0 OR
ride_length > 1440

-- Checking for any duplicates by checking count

Select Count(DISTINCT(ride_id)) AS uniq,
Count(ride_id) AS total
From [Cyclistic].[dbo].[all_data]
