--Calculating Most Popular Stations for Casual Users, (limiting results to top 20 station)


Select
TOP 20 start_station_name AS Station_name,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual
From [Cyclistic].[dbo].[all_data]
Group By start_station_name
Order By num_of_casual DESC