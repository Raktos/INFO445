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
	@StudentEmail varchar(255)
AS
	BEGIN TRAN t1
		DECLARE @StudentFind int;
		DECLARE @AirlineFind int;
		DECLARE @DepCityFind int;
		DECLARE @ArrCityFind int;
		
		SET @StudentFind = (SELECT StudentID 
			FROM STUDENT
			WHERE StudentFName = @StudentFName
			AND StudentLName = @StudentLName
			AND StudentEmail = @StudentEmail);
		
		SET @ArrCityFind = (SELECT CityID 
			FROM CITY 
			WHERE CityName = @ArrCity);

		IF @ArrCityFind IS NULL
		BEGIN
			EXEC dbo.uspInsertCity @City = @ArrCity
		END

		SET @DepCityFind = (SELECT CityID 
			FROM CITY 
			WHERE CityName = @DepCity);

		IF @DepCityFind IS NULL
		BEGIN
			EXEC dbo.uspInsertCity @City = @DepCity
		END

		SET @Airline
		INSERT INTO HOTEL(HotelTypeID, CityID, HotelName, HotelDesc, HotelStreetAddress)
		VALUES(@TypeFind, @CityFind, @HotelName, @HotelDesc, @HotelAddress);
	COMMIT TRAN t1
GO