USE AtlasTravel;
GO


CREATE PROCEDURE [dbo].[insertTRANSIT_COMPANY](
	@TransitCompanyID int,
	@TransitCompanyName varchar(255),
	@TransitCompanyDesc varchar(255)
)
AS

BEGIN
	SET NOCOUNT ON
	SELECT @TransitCompanyID = ISNULL(MAX(TransitCompanyID), 0) + 1
	FROM dbo.TRANSIT_COMPANY
	BEGIN 
		SET IDENTITY_INSERT AtlasTravel.dbo.TRANSIT_COMPANY ON
		INSERT INTO AtlasTravel.dbo.TRANSIT_COMPANY(TransitCompanyID, TransitCompanyName, TransitCompanyDesc)
		VALUES (@TransitCompanyID, @TransitCompanyName, @TransitCompanyDesc)
	END
END

GO


