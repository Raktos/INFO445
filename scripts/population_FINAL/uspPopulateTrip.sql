CREATE PROCEDURE uspPopulateTrip
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
			
			SET @TripName = 'Trip ' + (SELECT CAST((ISNULL(MAX(TripID), 0) + 2) AS varchar) FROM dbo.TRIP);
			SET @SponsorContactID= (SELECT TOP 1 SponsorContactID FROM SPONSOR_CONTACT ORDER BY newid());
			SET @TripDesc = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut velit lorem, placerat varius arcu quis, ullamcorper sagittis quam. Nulla placerat purus ac suscipit fermentum. Curabitur pulvinar in quam tincidunt rutrum.';
			
			INSERT INTO dbo.TRIP (SponsorContactID, TripName, TripDesc)
			VALUES (@SponsorContactID, @TripName, @TripDesc)
			SET @counter = @counter - 1;
			
		END

	COMMIT TRAN t1
END

