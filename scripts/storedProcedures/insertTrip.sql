CREATE PROCEDURE uspInsertTrip
	@counter INT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRAN T1

		DECLARE @TripID INT;
		DECLARE @SponsorContactID INT;
		DECLARE @TripName VARCHAR(50);
		DECLARE @TripDesc VARCHAR(100);

		WHILE @counter > 0
		BEGIN
			
			SELECT @TripID = ISNULL(MAX(TripID), 0) + 1
			FROM dbo.TRIP

			SELECT @SponsorContactID= (SELECT TOP 1 TripID FROM TRIP ORDER BY newid());
			
			IF EXISTS(@SponsorContactID)
			BEGIN
				SELECT @rand = RAND();
				INSERT INTO dbo.TRIP (TripID, SponsorContactID, TripName, TripDesc)
				VALUES (@TripID, @SponsorContactID, @TripName, @TripDesc)
				SET @counter = @counter - 1;
			END
			
		END

		IF @@error <> 0
			ROLLBACK TRAN t1
		ELSE 
			COMMIT TRAN t1
END