-- RowInTable id
CREATE PROCEDURE RowInTable
(
	@id INT,
	@table VARCHAR(MAX)
)
AS
BEGIN
	EXEC('SELECT COUNT(1) as bool FROM ' + @table + ' WHERE id=' + @id)
END

-- CreateAgent name, nationality, cpr
CREATE PROCEDURE CreateAgent
(
	@name VARCHAR(255),
	@nationality CHAR(3),
	@cpr VARCHAR(11) = ''
)
AS
BEGIN
	DECLARE @row table (row_id INT)

	INSERT INTO person 
	OUTPUT INSERTED.id INTO @row(row_id)
	VALUES(@name, @nationality, @cpr, 'agent')

	INSERT INTO agent 
	SELECT row_id FROM @row

END


-- UpdateAgent id, name, nationality, cpr
CREATE PROCEDURE UpdateAgent
(
	@id INT,
	@name VARCHAR(255),
	@nationality CHAR(3),
	@cpr VARCHAR(11) = ''
)
AS
BEGIN
	UPDATE person 
	SET name = @name,
		nationality = @nationality,
		cpr = @cpr
	WHERE id = @id

END


-- CreateInformer name, nationality, cpr, currency, paymenttype, tags
CREATE PROCEDURE CreateInformer
(
	@name VARCHAR(255),
	@nationality CHAR(3),
	@cpr VARCHAR(11) = ''
	@currency VARCHAR(16),
	@paymenttype VARCHAR(64),
	@tags VARCHAR(MAX) = ''
)
AS
BEGIN
	DECLARE @row table (row_id INT)

	INSERT INTO person 
	OUTPUT INSERTED.id INTO @row(row_id)
	VALUES(@name, @nationality, @cpr, 'informer')

	INSERT INTO informer 
	SELECT row_id, @currency, @paymenttype, @tags FROM @row
END


-- UpdateInformer id, name, nationality, cpr, currency, paymenttype, tags
CREATE PROCEDURE UpdateInformer
(
	@id INT,
	@name VARCHAR(255),
	@nationality CHAR(3),
	@cpr VARCHAR(11) = ''
	@currency VARCHAR(16),
	@paymenttype VARCHAR(64),
	@tags VARCHAR(MAX) = ''
)
AS
BEGIN
	UPDATE person 
	SET name = @name,
		nationality = @nationality,
		cpr = @cpr
	WHERE id = @id

	UPDATE informer
	SET 
		currency = @currency,
		paymenttype = @paymenttype,
		tags = @tags
	WHERE id = @id
END



-- CreateObserved name, nationality, cpr, tags
CREATE PROCEDURE CreateObserved
(
	@name VARCHAR(255),
	@nationality CHAR(3),
	@cpr VARCHAR(11) = '',
	@tags VARCHAR(MAX) = ''
)
AS
BEGIN
	DECLARE @row table (row_id INT)
	INSERT INTO person 
	OUTPUT INSERTED.id INTO @row(row_id)
	VALUES(@name, @nationality, @cpr, 'observed')

	--INSERT INTO observed VALUES(@row.row_id, @tags)
	INSERT INTO observed 
	SELECT row_id, @tags FROM @row
END


-- UpdateObserved id, name, nationality, cpr, tags
CREATE PROCEDURE UpdateObserved
(
	@id INT,
	@name VARCHAR(255),
	@nationality CHAR(3),
	@cpr VARCHAR(11) = '',
	@tags VARCHAR(MAX) = ''
)
AS
BEGIN
	UPDATE person 
	SET name = @name,
		nationality = @nationality,
		cpr = @cpr
	WHERE id = @id

	UPDATE observed
		SET tags = @tags
	WHERE id = @id
END


-- DeletePerson id
CREATE PROCEDURE DeletePerson
(
	@id INT
)
AS
BEGIN
	DELETE FROM person WHERE person.id = @id
END



-- CreateReport content, create_date, change_date, place, author_id, observed_id comment
CREATE PROCEDURE CreateReport
(
	@content VARCHAR(MAX),
	@create_date DATETIME,
	@change_date DATETIME,
	@place VARCHAR(255),
	@author_id INT,
	@observed_id INT,
	@comment VARCHAR(MAX)
)
AS
BEGIN
	INSERT INTO report
	VALUES(
		@content,
		@create_date,
		@change_date,
		@place,
		@author_id,
		@observed_id,
		@comment
	)
END

-- UpdateReport id, content, create_date, change_date, place, author_id, observed_id comment
CREATE PROCEDURE UpdateReport
(
	@id INT,
	@content VARCHAR(MAX),
	@create_date DATETIME,
	@change_date DATETIME,
	@place VARCHAR(255),
	@author_id INT,
	@observed_id INT,
	@comment VARCHAR(MAX)
)
AS
BEGIN
	INSERT INTO report_log
	SELECT * FROM report WHERE id = @id

	UPDATE report
	SET 
		content = @content,
		create_date = @create_date,
		change_date = @change_date,
		place = @place,
		author_id = @author_id,
		observed_id = @observed_id,
		comment = @comment
	WHERE id = @id

END

-- SelectReports id
CREATE PROCEDURE SelectReports
(
	@id INT
)
AS
BEGIN
	SELECT * FROM report WHERE observed_id = @id
END

-- SelectReportLogs id
CREATE PROCEDURE SelectReportLogs
(
	@id INT
)
AS
BEGIN
	SELECT * FROM report_log WHERE id = @id
END

-- SelectAgent id
CREATE PROCEDURE SelectAgent
(
	@id INT
)
AS
BEGIN
	SELECT * FROM person
	JOIN agent ON agent.id = person.id
	WHERE person.id = @id
END

-- SelectAllAgents
CREATE PROCEDURE SelectAllAgents
AS
BEGIN
	SELECT * FROM person
	JOIN agent ON agent.id = person.id
END

-- SelectInformer id
CREATE PROCEDURE SelectInformer
(
	@id INT
)
AS
BEGIN
	SELECT * FROM person
	JOIN informer ON informer.id = person.id
	WHERE person.id = @id
END

-- SelectAllInformers
CREATE PROCEDURE SelectAllInformers
AS
BEGIN
	SELECT * FROM person
	JOIN informer ON informer.id = person.id
END

-- SelectObserved id
CREATE PROCEDURE SelectObserved
(
	@id INT
)
AS
BEGIN
	SELECT * FROM person
	JOIN observed ON observed.id = person.id
	WHERE person.id = @id
END

-- SelectAllObserved
CREATE PROCEDURE SelectAllObserved
AS
BEGIN
	SELECT * FROM person
	JOIN observed ON observed.id = person.id
END




-- CreateAddress id, areacode, street
CREATE PROCEDURE CreateAddress
(
	@id INT,
	@areacode INT,
	@street VARCHAR(255)
)
AS
BEGIN
	INSERT INTO address VALUES(@id, @areacode, @street)
END

-- SelectAddress id
CREATE PROCEDURE SelectAddress
(
	@id INT
)
AS
BEGIN
	SELECT * FROM address WHERE id = @id
END

-- UpdateAddress id, areacode, street
CREATE PROCEDURE UpdateAddress
(
	@id INT,
	@areacode INT,
	@street VARCHAR(255)
)
AS
BEGIN
	UPDATE address
	SET
		areacode = @areacode,
		street = @street
	WHERE id = @id
END

-- CreateAppearance id, height, eyecolor, haircolor
CREATE PROCEDURE CreateAppearance
(
	@id INT,
	@height INT,
	@eyecolor VARCHAR(32),
	@haircolor VARCHAR(32)
)
AS
BEGIN
	INSERT INTO Appearance VALUES(@id, @height, @eyecolor, @haircolor)
END


-- SelectAppearance id
CREATE PROCEDURE SelectAppearance
(
	@id INT
)
AS
BEGIN
	SELECT * FROM Appearance WHERE id = @id
END

-- UpdateAppearance id, height, eyecolor, haircolor
CREATE PROCEDURE UpdateAppearance
(
	@id INT,
	@height INT,
	@eyecolor VARCHAR(32),
	@haircolor VARCHAR(32)
)
AS
BEGIN
	UPDATE Appearance
	SET
		height = @height,
		eyecolor = @eyecolor,
		haircolor = @haircolor
	WHERE id = @id
END

-- CreateImage id, data
CREATE PROCEDURE CreateImage
(
	@id INT,
	@data VARBINARY(MAX)
)
AS
BEGIN
	INSERT INTO image VALUES(@id, @data)
END


-- SelectImage id
CREATE PROCEDURE SelectImage
(
	@id INT
)
AS
BEGIN
	SELECT * FROM image WHERE id = @id
END

-- UpdateImage id, data
CREATE PROCEDURE UpdateImage
(
	@id INT,
	@data VARBINARY(MAX)
)
AS
BEGIN
	UPDATE image
	SET
		data = @data
	WHERE id = @id
END

