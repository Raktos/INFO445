USE AtlasTravel;
GO

CREATE PROCEDURE uspInsertCity
	@City varchar(255),
	@Region varchar(255),
	@Country varchar(255)
AS
	BEGIN TRAN t1
		DECLARE @CountryFind int;
		DECLARE @RegionFind int;
		DECLARE @CityFind int;
		
		SELECT @CountryFind = CountryID 
			FROM COUNTRY 
			WHERE CountryName LIKE @Country;
			
		IF @CountryFind IS NULL
		BEGIN
			INSERT INTO COUNTRY (CountryName)
			VALUES (@Country);
			@CountryFind = SCOPE_IDENTITY();
		END
		
		SELECT @CountryFind = CountryID 
			FROM COUNTRY 
			WHERE CountryName = @Country;
			
		IF @CountryFind IS NULL
		BEGIN
			INSERT INTO COUNTRY (CountryName)
			VALUES (@Country);
			@CountryFind = SCOPE_IDENTITY();
		END
		
		SELECT @RegionFind = RegionID 
			FROM REGION 
			WHERE RegionName = @Region
			AND CountryID = @CountryFind;
			
		IF @RegionFind IS NULL
		BEGIN
			INSERT INTO REGION (RegionName)
			VALUES (@Region, @CountryFind);
			@RegionFind = SCOPE_IDENTITY();
		END
		
		SELECT @CityFind = CityID 
			FROM CITY 
			WHERE CityName = @City
			AND RegionID = @RegionFind;
			
		IF @CityFind IS NULL
		BEGIN
			INSERT INTO CITY (CityName)
			VALUES (@City, @RegionFind);
		END
	COMMIT TRAN t1
GO
