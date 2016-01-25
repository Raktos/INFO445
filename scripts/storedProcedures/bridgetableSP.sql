
CREATE PROCEDURE populateGroupStudent
	@NumRows INT,
AS
BEGIN
	DECLARE @i INT;
	DECLARE @stud INT;
	DECLARE	@randStud INT;
	DECLARE @group INT;
	DECLARE @randGroup INT;

	SET @i = 1;



	WHILE @i <= @NumRows
	BEGIN
		SET @stud = (SELECT COUNT(*) FROM STUDENT);
		SET @randStud = ROUND((RAND()*(@stud - 1) + 1), 0);
		SET @group = (SELECT COUNT(*) FROM GROUP);
		SET @randGroup = ROUND((RAND()*(@stud - 1) + 1), 0);

		INSERT INTO GROUP_STUDENT(StudentID, GroupID) VALUES (@randStud, @randGroup);
	END
END
