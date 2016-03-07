ALTER PROCEDURE uspInsertTransitType
	@TransitTypeName varchar(255),
	@TransitTypeDesc varchar(255)
AS
	BEGIN TRAN T1
		DECLARE @TransitTypeFind int

		SET @TransitTypeFind = (SELECT TransitTypeID
								FROM TRANSIT_TYPE
								WHERE TransitTypeName = @TransitTypeName);
		IF @TransitTypeFind IS NULL
		BEGIN
			INSERT INTO TRANSIT_TYPE(TransitTypeName, TransitTypeDesc)
			VALUES(@TransitTypeName, @TransitTypeDesc)
		END
	COMMIT TRAN T1
GO