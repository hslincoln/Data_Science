--Number of rides by Bike Type and Membership Type
SELECT rideable_type, 
       member_casual, 
	   COUNT(*) AS num_rides
FROM [Cyclistic].[dbo].[all_data]
GROUP BY rideable_type, member_casual
ORDER BY rideable_type, member_casual

SELECT *
FROM (SELECT ride_id, rideable_type, member_casual FROM [Cyclistic].[dbo].[all_data]) AS t
PIVOT (COUNT(ride_id) FOR rideable_type IN (classic_bike, docked_bike, electric_bike)) AS pvt_tbl;
