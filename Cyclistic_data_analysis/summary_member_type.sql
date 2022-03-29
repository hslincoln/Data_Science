--Average Ride Length--
--Box plot stats
SELECT DISTINCT
  member_casual,
  MAX(ride_length) OVER (PARTITION BY member_casual) AS MaxDuration,
  MIN(ride_length) OVER (PARTITION BY member_casual) AS MinDuration,
  AVG(CAST(ride_length AS BIGINT)) OVER (PARTITION BY member_casual) AS MeanDuration, 
  (PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY ride_length) OVER (PARTITION BY member_casual)) AS Percentile25,
  (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY ride_length) OVER (PARTITION BY member_casual)) AS Percentile75,
  (PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY ride_length) OVER (PARTITION BY member_casual)) AS MedianDuration
FROM [Cyclistic].[dbo].[all_data]

	   
	   
