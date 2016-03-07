alter PROCEDURE uspInsertSponsorContact
	@SponsorName VARCHAR(255),
	@SponsorContactFName VARCHAR(255),
	@SponsorContactLName VARCHAR(255),
	@SponsorContactPhoneNumber VARCHAR(255),
	@SponsorContactEmail VARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRAN t1
		DECLARE @SponsorID INT;
		DECLARE @SponsorNameFind INT;
		
		SET @SponsorNameFind = (SELECT SponsorID FROM SPONSOR WHERE SponsorName = @SponsorName)

		IF @SponsorNameFind IS NULL
		BEGIN
			RETURN -1
		END	

		INSERT INTO SPONSOR_CONTACT(SponsorID, SponsorContactFName, SponsorContactLName, SponsorContactPhoneNumber, SponsorContactEmail)
		VALUES(@SponsorNameFind, @SponsorContactFName, @SponsorContactLName, @SponsorContactPhoneNumber, @SponsorContactEmail)

	IF @@error <> 0 
		ROLLBACK TRAN t1
	ELSE
		COMMIT TRAN t1
END




EXEC uspInsertSponsorContact @SponsorName = 'asdfasdfafasdfsdf', @SponsorContactFName = 'Jack', @SponsorContactLName = 'Burns', @SponsorContactPhoneNumber = '45-(462)643-1111', @SponsorContactEmail = 'jackburns@gmail.com'