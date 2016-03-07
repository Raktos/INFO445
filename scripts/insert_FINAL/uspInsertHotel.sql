ALTER PROCEDURE [dbo].[uspInsertHotel]
	@City varchar(255),
	@Region varchar(255),
	@Country varchar(255),
	@Type varchar(255),
	@HotelName varchar(255),
	@HotelDesc varchar(255),
	@HotelAddress varchar(255)
AS
	BEGIN TRAN t1
		DECLARE @TypeFind int;
		DECLARE @CityFind int;
		
		SET @TypeFind = (SELECT HotelTypeID 
			FROM HOTEL_TYPE 
			WHERE HotelTypeName = @Type);
		

		SET @CityFind = (SELECT CityID 
			FROM CITY c JOIN REGION r ON c.RegionID = r.RegionID
			JOIN COUNTRY co ON r.CountryID = co.CountryID
			WHERE c.CityName = @City
			AND r.RegionName = @Region
			AND co.CountryName = @Country);
		IF @CityFind IS NULL
		BEGIN
			EXEC [dbo].[uspInsertCity] @City = @City, @Region = @Region, @Country = @Country, @CityID = @CityFind OUTPUT;
		END
			
		INSERT INTO HOTEL(HotelTypeID, CityID, HotelName, HotelDesc, HotelStreetAddress)
		VALUES(@TypeFind, @CityFind, @HotelName, @HotelDesc, @HotelAddress);
	COMMIT TRAN t1
GO