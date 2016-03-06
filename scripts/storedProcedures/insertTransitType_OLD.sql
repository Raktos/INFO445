USE AtlasTravel;
GO

CREATE PROCEDURE [dbo].[insertTRANSIT_TYPE](
	@TransitTypeID int,
	@TransitTypeName varchar(255),
	@TransitTypeDesc varchar(255)
)
AS

BEGIN

	SET NOCOUNT ON

	SELECT @TransitTypeID = ISNULL(MAX(TransitTypeID), 0) + 1
	FROM dbo.TRANSIT_TYPE

	BEGIN 
		SET IDENTITY_INSERT AtlasTravel.dbo.TRANSIT_TYPE ON

		INSERT INTO AtlasTravel.dbo.TRANSIT_TYPE(TransitTypeID, TransitTypeName, TransitTypeDesc)
		VALUES (@TransitTypeID, @TransitTypeName, @TransitTypeDesc)

	END

END
GO
