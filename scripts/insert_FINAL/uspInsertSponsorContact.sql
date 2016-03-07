ALTER PROCEDURE [dbo].[uspInsertSponsorContact]
	@SponsorName VARCHAR(255),
	@SponsorContactFName VARCHAR(255),
	@SponsorContactLName VARCHAR(255),
	@SponsorContactPhoneNumber VARCHAR(255),
	@SponsorContactEmail VARCHAR(255)
AS
BEGIN TRAN t1

	DECLARE @SponsorNameFind INT;
		
	SET @SponsorNameFind = (SELECT TOP 1 SponsorID FROM SPONSOR WHERE SponsorName = @SponsorName)

	IF @SponsorNameFind IS NULL
	BEGIN
		RETURN -1
	END	

	INSERT INTO SPONSOR_CONTACT(SponsorID, SponsorContactFName, SponsorContactLName, SponsorContactPhoneNumber, SponsorContactEmail)
	VALUES(@SponsorNameFind, @SponsorContactFName, @SponsorContactLName, @SponsorContactPhoneNumber, @SponsorContactEmail)

COMMIT TRAN t1
GO