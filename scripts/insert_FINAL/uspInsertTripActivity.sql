ALTER PROCEDURE [dbo].[uspInsertTripActivity]
	@TripName VARCHAR(255),
	@ActivityTypeName VARCHAR(255),
	@ActivityCategoryName VARCHAR(255),
	@CityName VARCHAR(255),
	@RegionName VARCHAR(255),
	@CountryName VARCHAR(255),
	@ActivityName VARCHAR(255),
	@ActivityDesc VARCHAR(255),
	@ActivityStreetAddress VARCHAR(255),
	@ActivityStartDate DATE,
	@ActivityEndDate DATE,
	@ActivityCost MONEY

AS
BEGIN
	BEGIN TRAN t1
		DECLARE @TripFind INT;
		DECLARE @ActivityTypeFind INT;
		DECLARE @ActivityCategoryFind INT;
		DECLARE @CityFind INT;

		SET @TripFind = (SELECT TOP 1 TripID FROM TRIP WHERE TripName = @TripName)
		IF @TripFind IS NULL
		BEGIN
			RETURN -1
		END

		SET @ActivityTypeFind = (SELECT TOP 1 ActivityTypeID FROM ACTIVITY_TYPE at JOIN ACTIVITY_CATEGORY ac ON at.ActivityCategoryID = ac.ActivityCategoryID WHERE ActivityTypeName = @ActivityTypeName)
		IF @ActivityTypeName IS NULL
		BEGIN
			RETURN -1
		END

		SET @CityFind = (SELECT TOP 1CityID FROM CITY c JOIN REGION r on r.RegionID = c.RegionID JOIN COUNTRY cu ON cu.CountryID = r.CountryID WHERE c.CityName = @CityName AND r.RegionName = @RegionName AND cu.CountryName = @CountryName)
		IF @CityFind IS NULL
		BEGIN
			EXEC dbo.uspInsertCity @City = @CityName, @Region = @RegionName, @Country = @CountryName, @CityID = @CityFind OUTPUT
		END

		INSERT INTO dbo.TRIP_ACTIVITY(TripID, ActivityTypeID, CityID, ActivityName, ActivityDesc, ActivityStartDate, ActivityEndDate, ActivityStreetAddress, ActivityCost)
		VALUES(@TripFind, @ActivityTypeFind, @CityFind, @ActivityName, @ActivityDesc, @ActivityStartDate, @ActivityEndDate, @ActivityStreetAddress, @ActivityCost)

		COMMIT TRAN t1
END
GO