USE AtlasTravel_FINAL
GO

CREATE PROCEDURE [dbo].[uspinsertRandGROUP_STUDENT] 
	-- Add the parameters for the stored procedure here
	@numRows int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRAN t1

		DECLARE @randGroupID int;
		DECLARE @randStudentID int;
		DECLARE @RAND numeric(16, 16);
		DECLARE @digit varchar(20)

		WHILE @numRows > 0
		BEGIN
			SET @Rand = RAND();
			SET @digit = @Rand
			SET @randGroupID = (SELECT  CASE
							WHEN SUBSTRING(@digit, 3, 3) = 000 
								THEN 9
							ELSE CAST(SUBSTRING(@digit, 3, 1) AS INT)
							END);
			SET @randStudentID = (SELECT  CASE
							WHEN SUBSTRING(@digit, 7, 3) = 000 
								THEN 100
							ELSE CAST(SUBSTRING(@digit, 3, 1) AS INT)
							END);

			INSERT INTO GROUP_STUDENT (GroupID, StudentID)
			VALUES (@randGroupID, @randStudentID);

			SET @numRows = @numRows - 1;
		END

	COMMIT TRAN t1
END

GO