/*** computed column ***/
SELECT [AirlineID]
      ,[AirlineName]
      ,[NumberOfFlights]
  FROM [AtlasTravel_FINAL].[dbo].[AIRLINE]
INSERT INTO FLIGHT([AirlineID]
      ,[FlightDepartureCityID]
      ,[FlightArrivalCityID]
      ,[FlightDepartureDate]
      ,[FlightArrivalDate]
      ,[FlightNumber]
      ,[NumberOfStudents])
      VALUES (3, 2, 23, '2015-10-10', '2015-10-11', 145, 0);

/*** insert exec ***/
SELECT f.FlightID, f.FlightNumber, c1.CityName AS DepartureCity, c2.CityName AS ArrivalCity, r.RegionName AS ArrivalRegion FROM FLIGHT_GROUP_STUDENT fg 
         JOIN GROUP_STUDENT gs ON fg.GroupStudentID = gs.GroupStudentID 
         JOIN STUDENT s ON gs.StudentID = s.StudentID 
         JOIN FLIGHT f ON f.FlightID = fg.FlightID
		     JOIN CITY c1 ON f.FlightDepartureCityID = c1.CityID
		     JOIN CITY c2 ON f.FlightArrivalCityID = c2.CityID
		     JOIN REGION r ON r.RegionID = c2.RegionID
         WHERE s.StudentFName = 'Milton' 
         AND s.StudentLName = 'Trani' 
         AND s.StudentEmail = 'Milton.Trani@FeedbugAHA.edu';

EXEC [dbo].[uspInsertFlightGroupStudent] 
   @DepCity = 'Seattle', 
   @DepRegion = 'Washington', 
   @DepCountry = 'USA', 
   @ArrCity = 'Jinan', /*** new city ***/
   @ArrRegion = 'Shandong', /*** new region ***/
   @ArrCountry = 'China', 
   @AirlineName = 'Delta',
   @DepDate = '2016-2-7', 
   @ArrDate = '2016-2-8', 
   @FlightNum = 115, /*** new flight number ***/
   @StudentFName = 'Milton', 
   @StudentLName = 'Trani', 
   @StudentEmail = 'Milton.Trani@FeedbugAHA.edu', 
   @GroupName = 'Group 9291';

