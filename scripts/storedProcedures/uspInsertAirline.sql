CREATE PROCEDURE uspInsertAirline
	@AirlineName varchar(255),
	@AirlineID int output
AS
BEGIN
	BEGIN TRAN T1		
		DECLARE @AirlineFind int;

		SET @AirlineFind = (SELECT AirlineID FROM AIRLINE WHERE AirlineName = @AirlineName)

		IF @AirlineFind IS NULL
		BEGIN
			INSERT INTO AIRLINE(AirlineName)
			VALUES (@AirlineName);
			SET @AirlineID = SCOPE_IDENTITY()
		END

		IF @@error <> 0
			ROLLBACK TRAN T1
		ELSE
			COMMIT TRAN T1
END
