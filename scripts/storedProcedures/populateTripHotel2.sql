USE [AtlasTravel]
GO
/****** Object:  StoredProcedure [dbo].[populateTripHotelCaroline]    Script Date: 1/25/2016 3:50:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE populateTripHotelCaroline
	@NumRows INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @digit varchar(20);
	DECLARE @i INT;
	DECLARE @trip INT;
	DECLARE @hotel INT;
	DECLARE @room INT;
	DECLARE @cost money;
	DECLARE @date DATE;
	DECLARE @reservedDuration INT;
	DECLARE @Rand Numeric(16, 16);

	SET @i = 1;

	WHILE @i <= @NumRows
	BEGIN
		SET @Rand = RAND();
		SET @digit = @Rand
		SET @trip = (SELECT  CASE
						WHEN SUBSTRING(@digit, 3, 1) = 0 
							THEN 3
						WHEN SUBSTRING(@digit, 3, 1) = 9
							THEN 1
						ELSE CAST(SUBSTRING(@digit, 3, 1) AS INT)
						END);
		SET @hotel = (SELECT CASE
						WHEN SUBSTRING(@digit, 4, 1) = 0 
							THEN 2
						WHEN SUBSTRING(@digit, 4, 1) = 9
							THEN 8
						ELSE CAST(SUBSTRING(@digit, 4, 1) AS INT)
						END);
		SET @cost = (SELECT CASE 
						WHEN SUBSTRING(@digit, 5, 4) = 0000
							THEN 1000.00
						ELSE CAST(SUBSTRING(@digit, 5, 4) AS money)
						END);
		SET @room = (SELECT CASE 
						WHEN SUBSTRING(@digit, 12, 2) = 00 
							THEN 5
						ELSE CAST(SUBSTRING(@digit, 12, 2) AS INT)
						END);
		SET @date = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 3650), '2000-01-01');
		SET @reservedDuration = (SELECT CASE
							WHEN SUBSTRING(@digit, 14, 1) = 0
								THEN 6
							ELSE CAST(SUBSTRING(@digit, 14, 1) AS INT)
							END);
		BEGIN
			INSERT INTO TRIP_HOTEL (TripID, HotelID, HotelRoomsReserved, HotelCheckInDate, HotelCheckOutDate, HotelCost) 
			VALUES (@trip, @hotel, @room, @date, DATEADD(DAY, @reservedDuration, @date), @cost);
		END
		SET @i = @i + 1;
	END
END
