USE AtlasTravel;
GO

CREATE PROCEDURE uspInsertCity
	@City varchar(255),
	@Region varchar(255),
	@Country varchar(255)
AS
	BEGIN TRAN t1
		INSERT INTO COUNTRY (CountryName)
			VALUES (@Country);
		INSERT INTO REGION (RegionName, CountryID)
			VALUES (@Region, SCOPE_IDENTITY());
		INSERT INTO CITY (CityName, RegionID)
			VALUES (@City, SCOPE_IDENTITY());
	COMMIT TRAN t1
GO
