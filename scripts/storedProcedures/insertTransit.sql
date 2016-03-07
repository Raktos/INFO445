USE AtlasTravel_FINAL;
GO

CREATE PROCEDURE uspInsertTransit(
	@TransitType varchar(255),
	@TransitCompany varchar(255),
	@TransitDesc varchar(255),
	@TransitID int OUTPUT
)
AS
BEGIN
	DECLARE @TransitTypeFind int
	DECLARE @TransitCompanyFind int

	SET @TransitTypeFind = (SELECT TransitTypeID
							FROM TRANSIT_TYPE
							WHERE TransitTypeName = @TransitType);
	IF @TransitTypeFind IS NULL
	BEGIN
		raiserror('cannot find transit type', 18, 1)
		return -1
	END

	SET @TransitCompanyFind = (SELECT TransitCompanyID
							FROM TRANSIT_COMPANY
							WHERE TransitCompanyName = @TransitCompany);
	IF @TransitCompanyFind IS NULL
	BEGIN
		raiserror('cannot find transit company', 18, 1)
		return -1
	END

	BEGIN TRAN T1
		INSERT INTO TRANSIT (TransitTypeID, TransitCompanyID, TransitDesc)
		VALUES (@TransitTypeFind, @TransitCompanyFind, @TransitDesc);
		SET @TransitID = SCOPE_IDENTITY()
	COMMIT TRAN T1
END
GO


