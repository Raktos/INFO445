CREATE PROCEDURE insertTripActivity
	@ActivityName VARCHAR(255),
	@ActivityDesc VARCHAR(255),
	@ActivityStreetAddress VARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRAN t1

		DECLARE @TripActivityID INT;
		DECLARE @TripID INT;
		DECLARE @ActivityTypeID INT;
		DECLARE @CityID INT;
		DECLARE @ActivityStartDate DATE;
		DECLARE @ActivityEndDate DATE;
		DECLARE @ActivityCost MONEY;
		DECLARE @Dig1 VARCHAR(20);
		DECLARE @rand NUMERIC (16, 16);

		BEGIN
			SELECT @TripActivityID = ISNULL(MAX(TripActivityID), 0) + 1
			FROM dbo.TRIP_ACTIVITY

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

			INSERT INTO dbo.TRIP_ACTIVITY(TripActivityID, TripID, ActivityTypeID, CityID, ActivityName, ActivityDesc, ActivityStartDate, ActivityEndDate, ActivityStreetAddress, ActivityCost)
			VALUES(@TripActivityID, @TripID, @ActivityTypeID, @CityID, @ActivityName, @ActivityDesc, @ActivityStartDate, @ActivityEndDate, @ActivityStreetAddress, @ActivityCost)
		END

		IF @@error <> 0
			ROLLBACK TRAN t1
		ELSE
			COMMIT TRAN t1
	END