--Average ride length for each month
SELECT *
FROM (SELECT 
	    ride_month_text,
            member_casual,
	    ride_length
      FROM [Cyclistic].[dbo].[all_data]
      ) AS t
      PIVOT (AVG(ride_length)
	      FOR ride_month_text IN (
              [January],[February],[March],
              [April],[May],[June],[July],[August],
	      [September],[October],[November],[December])
       ) AS pvt_tbl;
