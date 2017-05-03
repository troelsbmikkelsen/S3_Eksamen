IF OBJECT_ID('dbo.report_log', 'U') IS NOT NULL
	DROP TABLE report_log;
IF OBJECT_ID('dbo.report', 'U') IS NOT NULL
	DROP TABLE report;
IF OBJECT_ID('dbo.observed_gang', 'U') IS NOT NULL
	DROP TABLE observed_gang;	
IF OBJECT_ID('dbo.gang', 'U') IS NOT NULL
	DROP TABLE gang;
IF OBJECT_ID('dbo.observed', 'U') IS NOT NULL
	DROP TABLE observed;
IF OBJECT_ID('dbo.informer', 'U') IS NOT NULL
	DROP TABLE informer;
IF OBJECT_ID('dbo.agent', 'U') IS NOT NULL
	DROP TABLE agent;
IF OBJECT_ID('dbo.image', 'U') IS NOT NULL
	DROP TABLE image;
IF OBJECT_ID('dbo.appearance', 'U') IS NOT NULL
	DROP TABLE appearance;
IF OBJECT_ID('dbo.address', 'U') IS NOT NULL
	DROP TABLE address;
IF OBJECT_ID('dbo.person', 'U') IS NOT NULL
	DROP TABLE person;


-- person
CREATE TABLE person(
	id INT PRIMARY KEY IDENTITY,
	name VARCHAR(255) NOT NULL,
	nationality CHAR(3) NOT NULL,
	cpr VARCHAR(11),
	person_type VARCHAR(16) NOT NULL,
	CHECK(person_type in ('agent', 'informer', 'observed'))
)

-- address
CREATE TABLE address(
	id INT PRIMARY KEY FOREIGN KEY REFERENCES person(id) ON DELETE CASCADE,
	areacode int NOT NULL,
	street VARCHAR(255) NOT NULL
)

-- appearance
CREATE TABLE appearance(
	id INT PRIMARY KEY FOREIGN KEY REFERENCES person(id) ON DELETE CASCADE,
	height INT NOT NULL,
	eyecolor VARCHAR(32) NOT NULL,
	haircolor VARCHAR(32) NOT NULL
)

-- image
CREATE TABLE image(
	id INT PRIMARY KEY FOREIGN KEY REFERENCES person(id) ON DELETE CASCADE,
	data VARBINARY(MAX) NOT NULL
)

-- agent
CREATE TABLE agent(
	id INT PRIMARY KEY FOREIGN KEY REFERENCES person(id) ON DELETE CASCADE,
	--username VARCHAR(64) NOT NULL,
	--password CHAR(128) NOT NULL
)

-- informer
CREATE TABLE informer(
	id INT PRIMARY KEY FOREIGN KEY REFERENCES person(id) ON DELETE CASCADE,
	--username VARCHAR(64) NOT NULL,
	--password CHAR(128) NOT NULL,
	currency VARCHAR(16) NOT NULL,
	paymenttype VARCHAR(64) NOT NULL,
	tags VARCHAR(MAX)
)

-- observed
CREATE TABLE observed(
	id INT PRIMARY KEY FOREIGN KEY REFERENCES person(id) ON DELETE CASCADE,
	tags VARCHAR(MAX)
)

-- gang
CREATE TABLE gang(
	id INT PRIMARY KEY IDENTITY,
	name VARCHAR(64) NOT NULL
)

-- observed_gang
CREATE TABLE observed_gang(
	observed_id INT FOREIGN KEY REFERENCES observed(id) ON DELETE CASCADE,
	gang_id INT FOREIGN KEY REFERENCES gang(id) ON DELETE CASCADE,
	PRIMARY KEY(observed_id, gang_id)
)

-- report
CREATE TABLE report(
	id INT PRIMARY KEY IDENTITY,
	content VARCHAR(MAX) NOT NULL,
	create_date DATETIME NOT NULL,
	change_date DATETIME NOT NULL,
	place VARCHAR(255) NOT NULL,
	author_id INT NOT NULL FOREIGN KEY REFERENCES person(id),
	observed_id INT NOT NULL FOREIGN KEY REFERENCES observed(id),
	comment VARCHAR(MAX) NOT NULL
)

-- report_log
CREATE TABLE report_log(
	id INT PRIMARY KEY IDENTITY,
	report_id INT FOREIGN KEY REFERENCES report(id),
	content VARCHAR(MAX) NOT NULL,
	create_date DATETIME NOT NULL,
	change_date DATETIME NOT NULL,
	place VARCHAR(255) NOT NULL,
	author_id INT NOT NULL FOREIGN KEY REFERENCES person(id),
	observed_id INT NOT NULL FOREIGN KEY REFERENCES observed(id),
	comment VARCHAR(MAX) NOT NULL
)


exec CreateInformer 'Elias A. Kristoffersen', 'DNK', '151168-0979', 'DKK', 'Cash', ''
exec CreateAddress 1, 3450, 'Gammelhavn 4'

exec CreateInformer 'Alfred N. Damgaard', 'DNK', '180996-0621', 'DKK', 'Cash', ''
exec CreateAddress 2, 9610, 'Hyrdevej 57'

exec CreateInformer 'Sebastian T. Gregersen', 'DNK', '220763-3227', 'DKK', 'Cash', ''
exec CreateAddress 3, 8541, 'Hans Schacksvej 31'

exec CreateObserved 'Christian N. Lind', 'DNK', '060886-0533', ''
exec CreateAddress 4, 1614, 'Nørremarksvej 40'
exec CreateAppearance 4, 170, 'Ukendt', 'Brun'

exec CreateObserved 'Silas T. Mortensen', 'DNK', '280484-4603', ''
exec CreateAddress 5, 1068, 'Mosegårdsvej 35'

exec CreateObserved 'Jakob E. Lauritsen', 'DNK', '100671-3757', ''
exec CreateAddress 6, 1604, 'Bygmestervej 63'

exec CreateAgent 'Magnus S. Bang', 'DNK', '230785-2481'
exec CreateAddress 7, 9500, 'Albanivej 98'

exec CreateAgent 'Mohammad K. Schultz', 'DNK', '100264-3401'
exec CreateAddress 8, 1911, 'Funkevænget 17'

exec CreateAgent 'Joachim C. Madsen', 'DNK', '240967-3425'
exec CreateAddress 9, 1634, 'Langegade 57'


exec CreateReport 'Lorem Ipsum', CONVERT(DATETIME, GETDATE), GETDATE(), '', 1, 4, ''
exec CreateReport 'Lorem Ipsum', GETDATE(), GETDATE(), '', 7, 5, ''
exec CreateReport 'Lorem Ipsum', GETDATE(), GETDATE(), '', 9, 6, ''
