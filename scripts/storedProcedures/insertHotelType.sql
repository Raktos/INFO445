USE AtlasTravel_FINAL;
GO

CREATE PROCEDURE uspInsertHotelType
	@HotelTypeName varchar(255),
	@HotelTypeDesc varchar(255),
AS
	BEGIN TRAN t1

		DECLARE @HotelTypeFind int;

		SET @HotelTypeFind = (SELECT HotelTypeID FROM HOTEL_TYPE
							WHERE HotelTypeName = @HotelTypeName
							AND HotelTypeDesc = @HotelTypeDesc);

		IF NOT EXIST @HotelTypeFind
		BEGIN
			INSERT INTO HOTEL_TYPE(HotelTypeName, HotelTypeDesc)
			VALUES(@HotelTypeName, @HotelTypeDesc);
		END
	IF @@error <> 0
		ROLLBACK TRAN t1
	ELSE
		COMMIT TRAN t1
GO
