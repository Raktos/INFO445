USE AtlasTravel_FINAL;
GO

CREATE PROCEDURE uspInsertHotel
	@City varchar(255),
	@Type varchar(255),
	@HotelName varchar(255),
	@HotelDesc varchar(255),
	@HotelAddress varchar(255)
AS
	BEGIN TRAN t1
		DECLARE @TypeFind int;
		DECLARE @CityFind int;
		
		SET @TypeFind = (SELECT CountryID 
			FROM COUNTRY 
			WHERE CountryName = @Country);
		
		SET @CityFind = (SELECT CityID 
			FROM CITY 
			WHERE CityName = @City
			AND RegionID = @RegionFind);
			
		INSERT INTO HOTEL(HotelTypeID, CityID, HotelName, HotelDesc, HotelStreetAddress)
		VALUES(@TypeFind, @CityFind, @HotelName, @HotelDesc, @HotelAddress);
	COMMIT TRAN t1
GO