ALTER PROCEDURE dbo.uspInsertTransitCompany (
	@TransitCompanyName varchar(255),
	@TransitCompanyDesc varchar(255)
)
AS

BEGIN
	DECLARE @TransitCompanyID int
	SET @TransitCompanyID = 
		(SELECT TransitCompanyID
		FROM TRANSIT_COMPANY
		WHERE TransitCompanyName = @TransitCompanyName);
	IF @TransitCompanyID IS NULL
	BEGIN 
		INSERT INTO TRANSIT_COMPANY(TransitCompanyName, TransitCompanyDesc)
		VALUES (@TransitCompanyName, @TransitCompanyDesc)
	END
END
GO