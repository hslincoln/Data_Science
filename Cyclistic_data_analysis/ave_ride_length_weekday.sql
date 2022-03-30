--Average Ride Length for Weekday
SELECT *
FROM (SELECT 
	    day_of_week,
            member_casual,
	    ride_length
      FROM [Cyclistic].[dbo].[all_data]
      ) AS t
      PIVOT (AVG(ride_length)
	      FOR day_of_week IN (
              [Sunday],[Monday],[Tuesday],[Wednesday],
              [Thursday],[Friday],[Saturday])
      ) AS pvt_tbl;
