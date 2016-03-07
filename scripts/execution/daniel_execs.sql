DECLARE @ret int;
DECLARE @CityFind varchar(255);

EXEC @ret = dbo.uspInsertTripCity
	@Tripname = 'Trip 22',
	@CityName = 'Seattle',
	@RegionName = 'Washington',
	@CountryName = 'Seattle',
	@TripCityArrivalDate = '2013-01-01',
	@TripCityDepartureDate = '2013-01-31'

select @ret

select top 1 * from TRIP_CITY order by TripCityID desc