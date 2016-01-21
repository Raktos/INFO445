USE AtlasTravel;
GO

CREATE PROCEDURE uspInsertSponsor
	@CityName varchar(255),
	@RegionName varchar(255),
	@CountryName varchar(255),
	@SponsorName varchar(255),
	@SponsorDesc varchar(255),
	@SponsorStreetAddress varchar(255),
	@SponsorType varchar(255)
AS
	BEGIN TRAN t1
		DECLARE @CityFind int
		DECLARE @SponsorFind int
		DECLARE @SponsorTypeFind int
		
		SET @CityFind = (SELECT CityID 
			FROM CITY c
			JOIN REGION r ON
				r.RegionID = c.RegionID
			JOIN COUNTRY co ON
				co.CountryID = r.CountryID
			WHERE CityName = @CityName
			AND r.RegionName = @RegionName
			AND co.CountryName = @CountryName
		);
			
		IF @CityFind IS NULL
		BEGIN
			EXEC uspInsertCity @City = @CityName, @Region = @RegionName, @Country = @CountryName;
			SET @CityFind = @@IDENTITY 
		END

		SET @SponsorTypeFind = (SELECT SponsorTypeID
			FROM SPONSOR_TYPE
			WHERE SponsorTypeName = @SponsorType)

		SET @SponsorFind = (SELECT SponsorID
			FROM SPONSOR
			WHERE SponsorName = @SponsorName
			AND CityID = @CityFind
			AND SponsorTypeID = @SponsorTypeFind
		);

		IF @SponsorFind IS NULL
		BEGIN
			INSERT INTO SPONSOR (
				SponsorTypeID,
				CityID,
				SponsorName,
				SponsorDesc,
				SponsorStreetAddress)
			VALUES (
				@SponsorTypeFind,
				@CityFind,
				@SponsorName,
				@SponsorDesc,
				@SponsorStreetAddress
			);
		END
	COMMIT TRAN t1
GO
