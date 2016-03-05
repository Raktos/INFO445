USE AtlasTravel;
GO

CREATE PROCEDURE [dbo].[insertSPONSOR_TYPE](
	@SponsorTypeID int OUTPUT,
	@SponsorTypeName varchar(255),
	@SponsorTypeDesc varchar(255)
)
AS

BEGIN
	SET NOCOUNT ON;

	SELECT @SponsorTypeID = ISNULL(MAX(SponsorTypeID), 0) + 1
	FROM dbo.SPONSOR_TYPE

	BEGIN
		
		INSERT INTO AtlasTravel.dbo.SPONSOR_TYPE(SponsorTypeID, SponsorTypeName, SponsorTypeDesc)
		VALUES (@SponsorTypeID, @SponsorTypeName, @SponsorTypeDesc)

	END

END
GO


