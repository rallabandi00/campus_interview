USE [IBill]
GO

/****** Object:  Table [dbo].[HoursCalculation]    Script Date: 3/30/2021 11:41:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HoursCalculation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[TotalHours] [time](7) NULL
) ON [PRIMARY]
GO

2021-02-01

  select SUM(DATEDIFF(HOUR, '0:00:00', TotalHours))  from HoursCalculation where userid=1 and convert(varchar(10),startdate,101)>='03/30/2021' 
  and convert(varchar(10),enddate,101)<='03/30/2021' 

