USE AtlasTravel;
GO

CREATE PROCEDURE [dbo].[uspHuieLab2_insertTRIP_HOTEL]
	@counter int
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRAN t1
		DECLARE @tripHotelID INT;
		DECLARE @randTripID INT;
		DECLARE @randHotelID INT;
		DECLARE @randHotelRoomsReserved varchar(4);
		DECLARE @randHotelCheckInDate Date;
		DECLARE @randHotelCheckOutDate Date;
		DECLARE @randHotelCost varchar(10);
		DECLARE @Dig1 varchar(20);
		DECLARE @rand Numeric (16, 16);

		WHILE @counter > 0
		BEGIN

			SELECT @tripHotelID = ISNULL(MAX(TripHotelID), 0) + 1
			FROM dbo.TRIP_HOTEL
					
			SET @randTripID = (SELECT TOP 1 TripID FROM TRIP ORDER BY NEWID());

			SET @randHotelID = (SELECT TOP 1 HotelID FROM HOTEL ORDER BY NEWID());

			SELECT @rand = RAND();
			SET @Dig1 = @rand;
			SET @randHotelCost = CAST((SELECT CASE 
									WHEN SUBSTRING(@Dig1, 9, 6) = 000000
										THEN 159223
										ELSE SUBSTRING(@Dig1, 9, 6)
									END
									) AS MONEY)

			SELECT @rand = RAND();
			SET @Dig1 = @rand;
			SET @randHotelRoomsReserved = CAST((SELECT CASE
											WHEN SUBSTRING(@Dig1, 10, 2) = 00
												THEN 15
												ELSE SUBSTRING(@Dig1, 10, 2) 
											END
											) AS INT)
			
			SELECT @rand = RAND();
			SET @Dig1 = @rand;
			SET @randHotelCheckInDate = (SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 45), '2008-01-01'));

			SELECT @rand = RAND();
			SET @Dig1 = @rand;
			SET @randHotelCheckOutDate = (SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 85), '2008-05-01'));
			

			INSERT INTO [dbo].[TRIP_HOTEL] (TripHotelID, TripID, HotelID, HotelRoomsReserved, HotelCheckInDate, HotelCheckOutDate, HotelCost)
			VALUES (@tripHotelID, @randTripID, @randHotelID, @randHotelRoomsReserved, @randHotelCheckInDate, @randHotelCheckOutDate, @randHotelCost)

			SET @counter = @counter - 1;
		END

	COMMIT TRAN t1

END


