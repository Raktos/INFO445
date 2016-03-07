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

		BEGIN

			SET @TripFind = (SELECT TripID FROM TRIP WHERE TripName = @TripName)
			IF @TripFind IS NULL
			BEGIN
				RETURN -1
			END

			SET @ActivityTypeFind = (SELECT ActivityTypeID FROM ACTIVITY_TYPE at JOIN ACTIVITY_CATEGORY ac ON at.ActivityCategoryID = ac.ActivityCategoryID WHERE ActivityTypeName = @ActivityTypeName)
			IF @ActivityTypeName IS NULL
			BEGIN
				RETURN -1
			END

			SET @CityFind = (SELECT CityID FROM CITY c JOIN REGION r on r.RegionID = c.RegionID JOIN COUNTRY cu ON cu.CountryID = r.CountryID WHERE c.CityName = @CityName AND r.RegionName = @RegionName AND cu.CountryName = @CountryName)
			IF @CityFind IS NULL
			BEGIN
				EXEC dbo.uspInsertCity @City = @CityName, @Region = @RegionName, @Country = @CountryName, @CityID = @CityFind OUTPUT
			END

			INSERT INTO dbo.TRIP_ACTIVITY(TripID, ActivityTypeID, CityID, ActivityName, ActivityDesc, ActivityStartDate, ActivityEndDate, ActivityStreetAddress, ActivityCost)
			VALUES(@TripFind, @ActivityTypeFind, @CityFind, @ActivityName, @ActivityDesc, @ActivityStartDate, @ActivityEndDate, @ActivityStreetAddress, @ActivityCost)
		END

		IF @@error <> 0
			ROLLBACK TRAN t1
		ELSE
			COMMIT TRAN t1
	END