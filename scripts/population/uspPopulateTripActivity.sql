ALTER PROCEDURE uspPopulateTripActivity
	@NumInserts int
AS
WHILE @NumInserts > 0
BEGIN
	DECLARE @TripNameFind VARCHAR(255);
	DECLARE @ActivityTypeNameFind VARCHAR(255);
	DECLARE @ActivityCategoryNameFind VARCHAR(255);
	DECLARE @CityNameFind VARCHAR(255);
	DECLARE @RegionNameFind VARCHAR(255);
	DECLARE @CountryNameFind VARCHAR(255);
	DECLARE @ActivityNameFind VARCHAR(255);
	DECLARE @ActivityDescFind VARCHAR(255); -- some description
	DECLARE @ActivityStartDateFind VARCHAR(255);
	DECLARE @ActivityEndDateFind VARCHAR(255);
	DECLARE @ActivityStreetAddressFind VARCHAR(255);
	DECLARE @ActivityCostFind MONEY;
	DECLARE @Dig1 varchar(20);
	DECLARE @rand Numeric (16, 16);



	SET @TripNameFind = (SELECT TOP 1 TripName FROM TRIP ORDER BY NEWID())

	SET @ActivityTypeNameFind = (SELECT TOP 1 ActivityTypeName FROM ACTIVITY_TYPE ORDER BY NEWID())	

	SET @ActivityCategoryNameFind = (SELECT TOP 1 ActivityCategoryName FROM ACTIVITY_CATEGORY ORDER BY NEWID())

	SET @CountryNameFind = (SELECT TOP 1 CountryName FROM COUNTRY ORDER BY NEWID())
	SET @RegionNameFind = (SELECT TOP 1 RegionName FROM REGION r JOIN COUNTRY c on r.countryID = c.countryID ORDER BY NEWID())
	SET @CityNameFind = (SELECT TOP 1 CityName FROM CITY c JOIN REGION r on c.regionID = r.regionID ORDER BY NEWID())

	SET @ActivityNameFind = (SELECT TOP 1 verb FROM VERB ORDER BY NEWID()) + ' ' + (SELECT TOP 1 noun FROM noun ORDER BY NEWID())

	SELECT @rand = RAND();
	SET @Dig1 = @rand;
	SET @ActivityStartDateFind = (SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 45), '2015-01-01'));

	SELECT @rand = RAND();
	SET @Dig1 = @rand;
	SET @ActivityEndDateFind = (SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 85), '2015-05-01'));

	SET @ActivityStreetAddressFind = CAST(ABS(CHECKSUM(NewId())) % 1000 AS VARCHAR(255)) + ' ' + 'main street';

	SET @ActivityCostFind = ABS(CHECKSUM(NewId())) % 500;


	EXEC dbo.uspInsertTripActivity
		@TripName = @TripNameFind,
		@ActivityTypeName = @ActivityTypeNameFind,
		@ActivityCategoryName = @ActivityCategoryNameFind,
		@CityName = @CityNameFind,
		@RegionName = @RegionNameFind,
		@CountryName = @CountryNameFind,
		@ActivityName = @ActivityNameFind,
		@ActivityDesc = 'Some random description',
		@ActivityStreetAddress = @ActivityStreetAddressFind,
		@ActivityStartDate = @ActivityStartDateFind,
		@ActivityEndDate = @ActivityEndDateFind,
		@ActivityCost = @ActivityCostFind
	
	SET @NumInserts = @NumInserts - 1
END
