CREATE PROCEDURE insertSponsorContact
	@SponsorContactFName VARCHAR(255),
	@SponsorContactLName VARCHAR(255),
	@SponsorContactPhoneNumber VARCHAR(255),
	@SponsorContactEmail VARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRAN t1
		DECLARE @SponsorContactID INT;
		DECLARE @SponsorID INT;

		BEGIN
			SELECT @SponsorContactID = ISNULL(MAX(SponsorContactID), 0) + 1
			FROM dbo.SPONSOR_CONTACT

			SET @SponsorID = (SELECT TOP 1 SponsorID FROM SPONSOR_CONTACT ORDER BY NEWID());

			INSERT INTO SPONSOR_CONTACT(SponsorContactID, SponsorID, SponsorContactFName, SponsorContactLName, SponsorContactPhoneNumber, SponsorContactEmail)
			VALUES(@SponsorContactID, @SponsorID, @SponsorContactFName, @SponsorContactLName, @SponsorContactPhoneNumber, @SponsorContactEmail)
		END

	IF @@error <> 0 
		ROLLBACK TRAN t1
	ELSE
		COMMIT TRAN t1
END