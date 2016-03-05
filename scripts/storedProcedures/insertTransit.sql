USE AtlasTravel;
GO

CREATE PROCEDURE [dbo].[insertTRANSIT](
	@TransitID int,
	@TransitTypeID int,
	@TransitCompanyID int,
	@TransitDesc varchar(255)
)
AS

BEGIN
	SET NOCOUNT ON

	SELECT @TransitID = ISNULL(MAX(TransitID), 0) + 1
	FROM dbo.TRANSIT

	BEGIN 
		SET IDENTITY_INSERT AtlasTravel.dbo.TRANSIT ON
		INSERT INTO AtlasTravel.dbo.TRANSIT(TransitID, TransitTypeID, TransitCompanyID, TransitDesc)
		VALUES (@TransitID, @TransitTypeID, @TransitCompanyID, @TransitDesc)
	END
END
GO


