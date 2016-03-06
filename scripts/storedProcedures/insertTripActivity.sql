CREATE PROCEDURE insertTripActivity
	-- fail if tripname do not exist
	-- fail if activityTypeName does not exist
	-- fail if join on activityCategoryName where ActivityType.cateogryID = activitycategory.categoryID is not the same

	@TripName VARCHAR(255),
	@ActivityTypeName VARCHAR(255),
	@ActivityCategoryName VARCHAR(255),
	@CityName VARCHAR(255),
	@RegionName VARCHAR(255),
	@CountryName VARCHAR(255),
	@ActivityName VARCHAR(255),
	@ActivityDesc VARCHAR(255),
	@ActivityStreetAddress VARCHAR(255)

AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRAN t1
		DECLARE @TripFind INT;
		DECLARE @ActivityTypeFind INT;
		DECLARE @ActivityCategoryFind INT;
		DECLARE @CityFind INT;

		DECLARE @TripID INT;
		DECLARE @ActivityTypeID INT;
		DECLARE @CityID INT;
		DECLARE @ActivityStartDate DATE;
		DECLARE @ActivityEndDate DATE;
		DECLARE @ActivityCost MONEY;
		DECLARE @Dig1 VARCHAR(20);
		DECLARE @rand NUMERIC (16, 16);

		BEGIN

			SET @TripFind = (SELECT TripID FROM TRIP WHERE TripName = @TripName)
			IF @TripFind IS NULL
			BEGIN
				RETURN -1
			END

			SET @ActivityTypeFind = (SELECT ActivityTypeID FROM ACTIVITY_TYPE WHERE ActivityTypeName = @ActivityTypeName)
			IF @ActivityTypeName IS NULL
			BEGIN
				RETURN -1
			END

			SET @ActivityCategoryFind = (SELECT ActivityCategoryID FROM ACTIVITY_CATEGORY ac JOIN ACTIVITY_TYPE at ON ac.ActivityCategoryID = at.ActivityCategoryID WHERE ac.ActivityCategoryName = @ActivityCategoryName)
			IF @ActivityCategoryFind IS NULL
			BEGIN
				RETURN -1
			END

			SET @CityFind = (SELECT CityID FROM CITY c JOIN REGION r on r.RegionID = c.RegionID JOIN COUNTRY cu ON cu.CountryID = r.CountryID WHERE c.CityName = @CityName AND r.RegionName = @RegionName AND cu.CountryName = @CountryName)
			IF @CityFind IS NULL
			BEGIN
				EXEC dbo.uspInsertCity @City = @CityName, @Region = @RegionName, @Country = @CountryName, @CityID = @CityFind OUTPUT
			END

			SET @TripID = (SELECT TOP 1 TripID FROM TRIP ORDER BY newid())

			SET @ActivityTypeID = (SELECT TOP 1 ActivityTypeID FROM ACTIVITY_TYPE ORDER BY newid())

			SET @CityID = (SELECT TOP 1 CityID FROM CITY ORDER BY newid())

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

			INSERT INTO dbo.TRIP_ACTIVITY(TripID, ActivityTypeID, CityID, ActivityName, ActivityDesc, ActivityStartDate, ActivityEndDate, ActivityStreetAddress, ActivityCost)
			VALUES(@TripID, @ActivityTypeID, @CityID, @ActivityName, @ActivityDesc, @ActivityStartDate, @ActivityEndDate, @ActivityStreetAddress, @ActivityCost)
		END

		IF @@error <> 0
			ROLLBACK TRAN t1
		ELSE
			COMMIT TRAN t1
	END