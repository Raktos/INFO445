ALTER PROCEDURE dbo.uspInsertSponsorType (
	@SponsorTypeName varchar(255),
	@SponsorTypeDesc varchar(255)
)
AS

BEGIN TRAN T1
	DECLARE @SponsorTypeID int;
	SET @SponsorTypeID = 
		(SELECT SponsorTypeID
		FROM SPONSOR_TYPE
		WHERE SponsorTypeName = @SponsorTypeName);
		
	IF @SponsorTypeID IS NULL
	BEGIN
		
		INSERT INTO AtlasTravel_Final.dbo.SPONSOR_TYPE(SponsorTypeName, SponsorTypeDesc)
		VALUES (@SponsorTypeName, @SponsorTypeDesc)

	END

COMMIT TRAN T1
GO