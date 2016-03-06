CREATE PROCEDURE uspInsertAirline
	@AirlineName varchar(255)
AS
BEGIN
	BEGIN TRAN T1		

		INSERT INTO AIRLINE(AirlineName)
		VALUES(@AirlineName)
	
	IF @@error <> 0
		ROLLBACK TRAN T1
	ELSE
		COMMIT TRAN T1
END
