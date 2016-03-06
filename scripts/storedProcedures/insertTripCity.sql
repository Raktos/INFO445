create procedure insertTripCity
	@counter int
as
begin
	set nocount on;
	begin tran t1

		declare @TripCityID int;
		declare @TripID int;
		declare @CityID int;
		declare @TripCityArrivalDate Date;
		declare @TripCityDepartureDate Date;
		DECLARE @Dig1 varchar(20);
		DECLARE @rand Numeric (16, 16);

		while @counter > 0
		begin
			
			select @TripCityID = ISNULL(MAX(TripCityID), 0) + 1
			from dbo.TRIP_CITY

			select @TripID = (select top 1 TripID from TRIP order by newid());

			select @CityID = (select top 1 CityID from CITY order by newid());

			SELECT @rand = RAND();
			SET @Dig1 = @rand;
			SET @TripCityArrivalDate = (SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 45), '2008-01-01'));

			SELECT @rand = RAND();
			SET @Dig1 = @rand;
			SET @TripCityDepartureDate = (SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 85), '2008-05-01'));

			insert into dbo.TRIP_CITY (TripCityID, TripID, CityID, TripCityArrivalDate, TripCityDepartureDate)
			values (@TripCityID, @TripID, @CityID, @TripCityArrivalDate, @TripCityDepartureDate)

			set @counter = @counter - 1;
		end

		if @@error <> 0
			rollback tran t1
		else 
			commit tran t1
end