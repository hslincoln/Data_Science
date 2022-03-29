/* analyze data */

--Numbers of Rides for each month from Each Type of Customer
SELECT [ride_month],[member_casual], count(*) AS Number_of_rides
FROM [Cyclistic].[dbo].[all_data]
GROUP BY [ride_month], [member_casual]
ORDER BY [ride_month], [member_casual]

 SELECT * 
 FROM (SELECT
			ride_id,
            ride_month_text,
            member_casual
        FROM [Cyclistic].[dbo].[all_data]
	) AS t
    PIVOT (COUNT(ride_id)
			FOR ride_month_text IN (
            [January],[February],[March],
            [April],[May],[June],[July], [August],
			[September],[October],[November],[December])
    ) AS pvt_tbl;
