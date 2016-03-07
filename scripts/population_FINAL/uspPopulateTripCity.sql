ALTER PROCEDURE uspPopulateTripCity
	@NumInserts int
AS
WHILE @NumInserts > 0
BEGIN
	DECLARE @TripNameFind VARCHAR(255);
	DECLARE @CityNameFind VARCHAR(255);
	DECLARE @RegionNameFind VARCHAR(255);
	DECLARE @CountryNameFind VARCHAR(255);
	DECLARE @TripCityArrivalDateFind DATE;
	DECLARE @TripCityDepartureDateFind DATE;
	DECLARE @Dig1 varchar(20);
	DECLARE @rand Numeric (16, 16);

	SET @TripNameFind = (SELECT TOP 1 TripName FROM TRIP ORDER BY NEWID())
	SET @CountryNameFind = (SELECT TOP 1 CountryName FROM COUNTRY ORDER BY NEWID())
	SET @RegionNameFind = (SELECT TOP 1 RegionName FROM REGION r JOIN COUNTRY c on r.countryID = c.countryID ORDER BY NEWID())
	SET @CityNameFind = (SELECT TOP 1 CityName FROM CITY c JOIN REGION r on c.regionID = r.regionID ORDER BY NEWID())
	
	SELECT @rand = RAND();
	SET @Dig1 = @rand;
	SET @TripCityArrivalDateFind = (SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 45), '2015-01-01'));

	SELECT @rand = RAND();
	SET @Dig1 = @rand;
	SET @TripCityDepartureDateFind = (SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 85), '2015-05-01'));

	EXEC dbo.uspInsertTripCity
		@TripName = @TripNameFind,
		@CityName = @CityNameFind,
		@RegionName = @RegionNameFind,
		@CountryName = @CountryNameFind,
		@TripCityArrivalDate = @TripCityArrivalDateFind,
		@TripCityDepartureDate = @TripCityDepartureDateFind
	
	SET @NumInserts = @NumInserts - 1
END
GO