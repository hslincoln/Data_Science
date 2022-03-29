-- number of rides by hour

Alter Table [Cyclistic].[dbo].[all_data]
ADD hour_of_day int NULL
GO

UPDATE [Cyclistic].[dbo].[all_data]
SET hour_of_day = DATEPART(hour, started_at)

ALTER TABLE [Cyclistic].[dbo].[all_data]
   ALTER COLUMN hour_of_day INT NOT NULL

Select
hour_of_day,
Count(case when member_casual = 'member' then 1 else NULL END) AS num_of_members,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual,
Count(*) AS num_of_users
From [Cyclistic].[dbo].[all_data]
Group By hour_Of_day
Order By hour_Of_day