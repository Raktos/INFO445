USE AtlasTravel_FINAL;
GO

CREATE PROCEDURE uspInsertCity
	@City varchar(255),
	@Region varchar(255),
	@Country varchar(255),
	@CityID int OUTPUT
AS
	BEGIN TRAN t1
		DECLARE @CountryFind int;
		DECLARE @RegionFind int;
		DECLARE @CityFind int;
		
		SET @CountryFind = (SELECT CountryID 
			FROM COUNTRY 
			WHERE CountryName = @Country);
			
		IF @CountryFind IS NULL
		BEGIN
			INSERT INTO COUNTRY (CountryName)
			VALUES (@Country);
			SET @CountryFind = SCOPE_IDENTITY();
		END
		
		SET @RegionFind = (SELECT RegionID 
			FROM REGION 
			WHERE RegionName = @Region
			AND CountryID = @CountryFind);
			
		IF @RegionFind IS NULL
		BEGIN
			INSERT INTO REGION (RegionName, CountryID)
			VALUES (@Region, @CountryFind);
			SET @RegionFind = SCOPE_IDENTITY();
		END
		
		SET @CityFind = (SELECT CityID 
			FROM CITY 
			WHERE CityName = @City
			AND RegionID = @RegionFind);
			
		SET @CityID = @CityFind
		IF @CityFind IS NULL
		BEGIN
			INSERT INTO CITY (CityName, RegionID)
			VALUES (@City, @RegionFind);
			SET @CityID = SCOPE_IDENTITY()
		END
	COMMIT TRAN t1
GO
