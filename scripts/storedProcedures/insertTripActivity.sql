create procedure insertTripActivity
	@ActivityName varchar(255),
	@ActivityDesc varchar(255),
	@ActivityStreetAddress varchar(255)
as
begin
	set nocount on;
	begin tran t1

		declare @TripActivityID int;
		declare @TripID int
		declare @ActivityTypeID int;
		declare @CityID int;
		declare @ActivityStartDate Date;
		declare @ActivityEndDate Date;
		declare @ActivityCost Money;
		declare @Dig1 varchar(20);
		declare @rand Numeric (16, 16);

		begin
			select @TripActivityID = ISNULL(MAX(TripActivityID), 0) + 1
			from dbo.TRIP_ACTIVITY

			set @TripID = (select top 1 TripID from TRIP order by newid())

			set @ActivityTypeID = (select top 1 ActivityTypeID from ACTIVITY_TYPE order by newid())

			set @CityID = (select top 1 CityID from CITY order by newid())

			SELECT @rand = RAND();
			SET @Dig1 = @rand;
			SET @ActivityStartDate = (SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 45), '2008-01-01'));

			SELECT @rand = RAND();
			SET @Dig1 = @rand;
			SET @ActivityEndDate = (SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 85), '2008-05-01'));

			SET @ActivityCost = CAST((SELECT CASE 
									WHEN SUBSTRING(@Dig1, 9, 6) = 000000
										THEN 159223
										ELSE SUBSTRING(@Dig1, 9, 6)
									END
									) AS MONEY)

			insert into dbo.TRIP_ACTIVITY(TripActivityID, TripID, ActivityTypeID, CityID, ActivityName, ActivityDesc, ActivityStartDate, ActivityEndDate, ActivityStreetAddress, ActivityCost)
			values(@TripActivityID, @TripID, @ActivityTypeID, @CityID, @ActivityName, @ActivityDesc, @ActivityStartDate, @ActivityEndDate, @ActivityStreetAddress, @ActivityCost)
		end

		if @@error <> 0
			rollback tran t1
		else
			commit tran t1
	end