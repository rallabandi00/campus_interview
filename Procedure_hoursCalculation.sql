USE [IBill]
GO
/****** Object:  StoredProcedure [dbo].[Proc_HoursCalculation]    Script Date: 3/30/2021 11:41:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Proc_HoursCalculation]
	@UserId int,
	@option varchar(50),
	@startdate varchar(10)=null,
	@enddate varchar(10)=null
AS
BEGIN
	declare @currentdate datetime
	declare @fromdate datetime
	declare @hours time

	if(@option='Start')
	begin
	
	set @currentdate=GETDATE()
		if exists(select userid from HoursCalculation where UserId=@UserId and Enddate is null and TotalHours is null )
		begin
		set @fromdate=(select StartDate  from HoursCalculation where UserId=@UserId and Enddate is null and TotalHours is null)
		set @hours=convert(time,@currentdate-@fromdate)
		update HoursCalculation set Enddate=GETDATE(),TotalHours=@hours where UserId=@UserId and Enddate is null and TotalHours is null
		end
		else 
		begin
			insert into HoursCalculation(UserId,StartDate)values(@UserId,GETDATE())
		end
	end
	else if(@option='stop')
	begin
		set @currentdate=GETDATE()
		if exists(select userid from HoursCalculation where UserId=@UserId and Enddate is null and TotalHours is null )
		begin
		set @fromdate=(select StartDate  from HoursCalculation where UserId=@UserId and Enddate is null and TotalHours is null)
		set @hours=convert(time,@currentdate-@fromdate)
		update HoursCalculation set Enddate=GETDATE(),TotalHours=@hours where UserId=@UserId and Enddate is null and TotalHours is null
		end
	
	end
	else if(@option='report')
	begin
		  select SUM(DATEDIFF(HOUR, '0:00:00', TotalHours))  from HoursCalculation where userid=1 and convert(varchar(10),startdate,101)>=@startdate 
  and convert(varchar(10),enddate,101)<=@enddate
	end

END
