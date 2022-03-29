--Number of rides by weekday between members and casual riders
SELECT *
FROM (SELECT 
			ride_id,
			day_of_week,
            member_casual
			FROM [Cyclistic].[dbo].[all_data]
	) AS t
	PIVOT (COUNT(ride_id)
			FOR day_of_week IN (
            [Sunday],[Monday],[Tuesday],[Wednesday],
            [Thursday],[Friday],[Saturday]
			)
    ) AS pvt_tbl;
