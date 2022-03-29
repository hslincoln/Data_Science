/* Combine data */

DROP TABLE IF EXISTS [Cyclistic].[dbo].[all_data]
CREATE TABLE Cyclistic.dbo.[all_data](
        ride_id nvarchar(255),
        rideable_type nvarchar(50),
        started_at datetime2,
        ended_at datetime2,
        start_station_name nvarchar(MAX),
        start_station_id nvarchar(MAX),
        end_station_name nvarchar(MAX),
        end_station_id nvarchar(MAX),
        start_lat float,
        start_lng float,
        end_lat float,
        end_lng float,
        member_casual nvarchar(50)
    )
TRUNCATE TABLE [Cyclistic].[dbo].[all_data]
INSERT INTO Cyclistic.dbo.[all_data] (ride_id,rideable_type,started_at,ended_at,start_station_name,start_station_id,end_station_name,end_station_id,start_lat,start_lng,end_lat,end_lng,member_casual)
(Select * From Cyclistic.dbo.[202101-divvy-tripdata]) 
UNION ALL
(Select * From Cyclistic.dbo.[202102-divvy-tripdata]) 
UNION ALL
(Select * From Cyclistic.dbo.[202103-divvy-tripdata]) 
UNION ALL
(Select * From Cyclistic.dbo.[202104-divvy-tripdata]) 
UNION ALL
(Select * From Cyclistic.dbo.[202105-divvy-tripdata]) 
UNION ALL
(Select * From Cyclistic.dbo.[202106-divvy-tripdata])
UNION ALL
(Select * FROM Cyclistic.dbo.[202107-divvy-tripdata])
UNION ALL
(Select * From Cyclistic.dbo.[202108-divvy-tripdata]) 
UNION ALL
(Select * FROM Cyclistic.dbo.[202109-divvy-tripdata])
UNION ALL
(Select * From Cyclistic.dbo.[202110-divvy-tripdata]) 
UNION ALL
(Select * From Cyclistic.dbo.[202111-divvy-tripdata])
UNION ALL
(Select * From Cyclistic.dbo.[202112-divvy-tripdata]) 

