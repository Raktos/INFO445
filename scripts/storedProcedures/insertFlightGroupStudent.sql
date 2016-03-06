USE AtlasTravel_FINAL;
GO

CREATE PROCEDURE uspInsertHotel
	@DepCity varchar(255),
	@ArrCity varchar(255),
	@AirlineName varchar(255),
	@AttributeName varchar(255),
	@DepDate Date,
	@ArrDate Date,
	@FlightNum int,
	@StudentFName varchar(255),
	@StudentLName varchar(255),
	@StudentEmail varchar(255),
	@GroupName varchar(255)
AS
	BEGIN TRAN t1
		DECLARE @StudentFind int;
		DECLARE @GroupStudentFind int;
		DECLARE @AirlineFind int;
		DECLARE @DepCityFind int;
		DECLARE @ArrCityFind int;
		DECLARE @FlightFind int;
		
		SET @StudentFind = (SELECT StudentID 
			FROM STUDENT
			WHERE StudentFName = @StudentFName
			AND StudentLName = @StudentLName
			AND StudentEmail = @StudentEmail);

		SET @GroupStudentFind = (SELECT GroupStudentID FROM GROUP_STUDENT
								 WHERE GroupID = (SELECT GroupID FROM GROUP WHERE GroupName = @GroupName)
								 AND StudentID = StudentFind);

		SET @ArrCityFind = (SELECT CityID 
			FROM CITY 
			WHERE CityName = @ArrCity);

		IF @ArrCityFind IS NULL
		BEGIN
			EXEC dbo.uspInsertCity @City = @ArrCity
		END
		SET @ArrCityFind = SCOPE_IDENTITY();

		SET @DepCityFind = (SELECT CityID 
			FROM CITY 
			WHERE CityName = @DepCity);

		IF @DepCityFind IS NULL
		BEGIN
			EXEC dbo.uspInsertCity @City = @DepCity
		END
		SET @DepCityFind = SCOPE_IDENTITY();

		SET @AirlineFind = (SELECT AirlineID FROM AIRLINE 
						WHERE AirlineName = @AirlineName 
						AND AttributeName = @AttributeName);
		IF @AirlineFind IS NULL
		BEGIN
			EXEC dbo.uspInsertAirline @AirlineName = @AirlineName, @AttributeName = @AttributeName;
		END
		SET @AirlineFind = SCOPE_IDENTITY();
		
		SET @FlightFind = (SELECT FlightID FROM FLIGHT
							WHERE AirlineID = @AirlineFind
							AND FlightDepartureCityID = @DepCityFind
							AND FlightArrivalCityID = @ArrCityFind
							AND FlightNumber = @FlightNum
							AND FlightDepartureDate = @DepDate
							AND FlightArrivalDate = @ArrDate);
		IF @FlightFind IS NULL
		BEGIN
			EXEC dbo.uspInsertFlight @AirlineID = @AirlineFind, @FlightDepartureCityID = @DepCityFind, 
									 @FlightArrivalCityID = @ArrCityFind, @FlightDepartureDate = @DepDate, 
									 @FlightArrivalDate = @ArrDate, @FlightNumber = @FlightNum;
		END
		SET @FlightFind = SCOPE_IDENTITY();

		INSERT INTO FLIGHT_GROUP_STUDENT(FlightID, GroupStudentID) 
		VALUES(@FlightFind, @GroupStudentFind);

	COMMIT TRAN t1
GO