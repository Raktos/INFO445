USE AtlasTravel_FINAL;
GO

CREATE PROCEDURE uspInsertFlightGroupStudent
	@DepCity varchar(255),
	@DepRegion varchar(255),
	@DepCountry varchar(255),
	@ArrCity varchar(255),
	@ArrRegion varchar(255),
	@ArrCountry varchar(255),
	@AirlineName varchar(255),
	@DepDate Datetime,
	@ArrDate Datetime,
	@FlightNum int,
	@StudentFName varchar(255),
	@StudentLName varchar(255),
	@StudentEmail varchar(255),
	@GroupName varchar(255)
AS
	BEGIN TRAN t1
		DECLARE @StudentFind int;
		DECLARE @GroupStudentFind int;

/**		DECLARE @AirlineFind int;
		DECLARE @DepCityFind int;
		DECLARE @DepRegionFind int;
		DECLARE @DepCountryFind int;
		DECLARE @ArrCityFind int;
		DECLARE @ArrRegionFind int;
		DECLARE @ArrCountryFind int;
**/
		DECLARE @FlightFind int;
		
		SET @StudentFind = (SELECT StudentID 
							FROM STUDENT
							WHERE StudentFName = @StudentFName
							AND StudentLName = @StudentLName
							AND StudentEmal = @StudentEmail);
		
		SET @GroupStudentFind = (SELECT GroupStudentID FROM GROUP_STUDENT
								 WHERE GroupID = (SELECT GroupID FROM TRIPGROUP WHERE GroupName = @GroupName)
								 AND StudentID = @StudentFind);

/**		SET @ArrCountryFind = (SELECT CountryID FROM COUNTRY 
								WHERE CountryName = @ArrCountry);
		
		SET @ArrRegionFind = (SELECT RegionID FROM REGION 
								WHERE RegionName = @ArrRegionFind
								AND CountryID = @ArrCountryFind);

		SET @ArrCityFind = (SELECT CityID 
			FROM CITY 
			WHERE CityName = @ArrCity
			AND RegionID = @ArrRegionFind);

		IF @ArrCityFind IS NULL
		BEGIN
			EXEC dbo.uspInsertCity @City = @ArrCity, @Region = @ArrRegion, @Country = @ArrCountry;
		END
		SET @ArrCityFind = SCOPE_IDENTITY();

		SET @DepCountryFind = (SELECT CountryID FROM COUNTRY 
								WHERE CountryName = @DepCountry);
		
		SET @DepRegionFind = (SELECT RegionID FROM REGION 
								WHERE RegionName = @DepRegionFind
								AND CountryID = @DepCountryFind);
		
		SET @DepCityFind = (SELECT CityID 
			FROM CITY 
			WHERE CityName = @DepCity
			AND RegionID = @DepRegionFind);

		IF @DepCityFind IS NULL
		BEGIN
			EXEC dbo.uspInsertCity @City = @DepCity, @Region = @DepRegion, @Country = @DepCountry;
		END
		SET @DepCityFind = SCOPE_IDENTITY();

		SET @AirlineFind = (SELECT AirlineID FROM AIRLINE 
						WHERE AirlineName = @AirlineName);
		IF @AirlineFind IS NULL
		BEGIN
			EXEC dbo.uspInsertAirline @AirlineName = @AirlineName;
		END
		SET @AirlineFind = SCOPE_IDENTITY();
		
**/

		SET @FlightFind = (SELECT FlightID FROM FLIGHT
										   JOIN AIRLINE ON FLIGHT.AirlineID = AIRLINE.AirlineID
										   JOIN CITY c1 ON FLIGHT.FlightDepartureCityID = c1.CityID
										   JOIN CITY c2 ON FLIGHT.FlightArrivalCityID = c2.CityID
							WHERE AirlineName = @AirlineName
							AND c1.CityName = @DepCity
							AND c2.CityName = @ArrCity
							AND FlightNumber = @FlightNum
							AND FligthDepartureDate = @DepDate
							AND FlightArrivalDate = @ArrDate);
		IF @FlightFind IS NULL
		BEGIN
			EXEC dbo.uspInsertFlight @Airline = @AirlineName, @FlightDepartureCity = @DepCity, @FlightDepartureRegion = @DepRegion,
									 @FlightDepartureCountry = @DepCountry, @FlightArrivalCity = @ArrCity, 
									 @FlightArrivalRegion = @ArrRegion, @FlightArrivalCountry = @ArrCountry,
									 @FlightArrivalCity = @ArrCityFind, @FlightDepartureDate = @DepDate, 
									 @FlightArrivalDate = @ArrDate, @FlightNumber = @FlightNum, @FlightID = @FlightFind;
		END

		INSERT INTO FLIGHT_GROUP_STUDENT(FlightID, GroupStudentID) 
		VALUES(@FlightFind, @GroupStudentFind);
	
	IF @@error <>0
		ROLLBACK TRAN t1
	ELSE
		COMMIT TRAN t1
GO
