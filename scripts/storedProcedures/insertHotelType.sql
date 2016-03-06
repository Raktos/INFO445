USE AtlasTravel_FINAL;
GO

CREATE PROCEDURE uspInsertHotelType
	@HotelTypeName varchar(255),
	@HotelTypeDesc varchar(255),
AS
	BEGIN TRAN t1
		INSERT INTO HOTEL_TYPE(HotelTypeName, HotelTypeDesc)
		VALUES(@HotelTypeName, @HotelTypeDesc);
	COMMIT TRAN t1
GO