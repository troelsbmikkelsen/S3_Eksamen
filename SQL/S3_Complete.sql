USE [master]
GO
/****** Object:  Database [S3Eksamen]    Script Date: 03-05-2017 09:29:29 ******/
CREATE DATABASE [S3Eksamen]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'S3Eksamen', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\S3Eksamen.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'S3Eksamen_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\S3Eksamen_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [S3Eksamen] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [S3Eksamen].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [S3Eksamen] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [S3Eksamen] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [S3Eksamen] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [S3Eksamen] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [S3Eksamen] SET ARITHABORT OFF 
GO
ALTER DATABASE [S3Eksamen] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [S3Eksamen] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [S3Eksamen] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [S3Eksamen] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [S3Eksamen] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [S3Eksamen] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [S3Eksamen] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [S3Eksamen] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [S3Eksamen] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [S3Eksamen] SET  DISABLE_BROKER 
GO
ALTER DATABASE [S3Eksamen] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [S3Eksamen] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [S3Eksamen] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [S3Eksamen] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [S3Eksamen] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [S3Eksamen] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [S3Eksamen] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [S3Eksamen] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [S3Eksamen] SET  MULTI_USER 
GO
ALTER DATABASE [S3Eksamen] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [S3Eksamen] SET DB_CHAINING OFF 
GO
ALTER DATABASE [S3Eksamen] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [S3Eksamen] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [S3Eksamen] SET DELAYED_DURABILITY = DISABLED 
GO
USE [S3Eksamen]
GO
/****** Object:  Table [dbo].[address]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[address](
	[id] [int] NOT NULL,
	[areacode] [int] NOT NULL,
	[street] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[agent]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[agent](
	[id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[appearance]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[appearance](
	[id] [int] NOT NULL,
	[height] [int] NOT NULL,
	[eyecolor] [varchar](32) NOT NULL,
	[haircolor] [varchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[gang]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[gang](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[image]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[image](
	[id] [int] NOT NULL,
	[data] [varbinary](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[informer]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[informer](
	[id] [int] NOT NULL,
	[currency] [varchar](16) NOT NULL,
	[paymenttype] [varchar](64) NOT NULL,
	[tags] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[observed]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[observed](
	[id] [int] NOT NULL,
	[tags] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[observed_gang]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[observed_gang](
	[observed_id] [int] NOT NULL,
	[gang_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[observed_id] ASC,
	[gang_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[person]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[person](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[nationality] [char](3) NOT NULL,
	[cpr] [varchar](11) NULL,
	[person_type] [varchar](16) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[report]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[report](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[content] [varchar](max) NOT NULL,
	[create_date] [datetime] NOT NULL,
	[change_date] [datetime] NOT NULL,
	[place] [varchar](255) NOT NULL,
	[author_id] [int] NOT NULL,
	[observed_id] [int] NOT NULL,
	[comment] [varchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[report_log]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[report_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[report_id] [int] NULL,
	[content] [varchar](max) NOT NULL,
	[create_date] [datetime] NOT NULL,
	[change_date] [datetime] NOT NULL,
	[place] [varchar](255) NOT NULL,
	[author_id] [int] NOT NULL,
	[observed_id] [int] NOT NULL,
	[comment] [varchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[address]  WITH CHECK ADD FOREIGN KEY([id])
REFERENCES [dbo].[person] ([id])
GO
ALTER TABLE [dbo].[agent]  WITH CHECK ADD FOREIGN KEY([id])
REFERENCES [dbo].[person] ([id])
GO
ALTER TABLE [dbo].[appearance]  WITH CHECK ADD FOREIGN KEY([id])
REFERENCES [dbo].[person] ([id])
GO
ALTER TABLE [dbo].[image]  WITH CHECK ADD FOREIGN KEY([id])
REFERENCES [dbo].[person] ([id])
GO
ALTER TABLE [dbo].[informer]  WITH CHECK ADD FOREIGN KEY([id])
REFERENCES [dbo].[person] ([id])
GO
ALTER TABLE [dbo].[observed]  WITH CHECK ADD FOREIGN KEY([id])
REFERENCES [dbo].[person] ([id])
GO
ALTER TABLE [dbo].[observed_gang]  WITH CHECK ADD FOREIGN KEY([gang_id])
REFERENCES [dbo].[gang] ([id])
GO
ALTER TABLE [dbo].[observed_gang]  WITH CHECK ADD FOREIGN KEY([observed_id])
REFERENCES [dbo].[observed] ([id])
GO
ALTER TABLE [dbo].[report]  WITH CHECK ADD FOREIGN KEY([author_id])
REFERENCES [dbo].[person] ([id])
GO
ALTER TABLE [dbo].[report]  WITH CHECK ADD FOREIGN KEY([observed_id])
REFERENCES [dbo].[observed] ([id])
GO
ALTER TABLE [dbo].[report_log]  WITH CHECK ADD FOREIGN KEY([author_id])
REFERENCES [dbo].[person] ([id])
GO
ALTER TABLE [dbo].[report_log]  WITH CHECK ADD FOREIGN KEY([observed_id])
REFERENCES [dbo].[observed] ([id])
GO
ALTER TABLE [dbo].[report_log]  WITH CHECK ADD FOREIGN KEY([report_id])
REFERENCES [dbo].[report] ([id])
GO
ALTER TABLE [dbo].[person]  WITH CHECK ADD CHECK  (([person_type]='observed' OR [person_type]='informer' OR [person_type]='agent'))
GO
/****** Object:  StoredProcedure [dbo].[CreateAddress]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC CreateAddress
CREATE PROCEDURE [dbo].[CreateAddress]
(
	@id INT,
	@areacode INT,
	@street VARCHAR(255)
)
AS
BEGIN
	INSERT INTO address VALUES(@id, @areacode, @street)
END
GO
/****** Object:  StoredProcedure [dbo].[CreateAgent]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateAgent]
(
	@name VARCHAR(255),
	@nationality CHAR(3),
	@cpr VARCHAR(11) = ''--,
--	@username VARCHAR(64),
--	@password CHAR(128)
)
AS
BEGIN
	DECLARE @row table (row_id INT)

	INSERT INTO person 
	OUTPUT INSERTED.id INTO @row(row_id)
	VALUES(@name, @nationality, @cpr, 'agent')


	--INSERT INTO agent VALUES(@id, @username, @password)
	INSERT INTO agent 
	SELECT row_id FROM @row
	--SELECT row_id, @username, @password FROM @row

END
GO
/****** Object:  StoredProcedure [dbo].[CreateAppearance]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC CreateAppearance
CREATE PROCEDURE [dbo].[CreateAppearance]
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
GO
/****** Object:  StoredProcedure [dbo].[CreateImage]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC CreateImage
CREATE PROCEDURE [dbo].[CreateImage]
(
	@id INT,
	@data VARBINARY(MAX)
)
AS
BEGIN
	INSERT INTO image VALUES(@id, @data)
END
GO
/****** Object:  StoredProcedure [dbo].[CreateInformer]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateInformer]
(
	@name VARCHAR(255),
	@nationality CHAR(3),
	@cpr VARCHAR(11) = '',
--	@username VARCHAR(64),
--	@password CHAR(128),
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


	--INSERT INTO informer VALUES(@id, @username, @password, @currency, @paymenttype, @tags)
	INSERT INTO informer 
	SELECT row_id, @currency, @paymenttype, @tags FROM @row
	--SELECT row_id, @username, @password, @currency, @paymenttype, @tags FROM @row
END
GO
/****** Object:  StoredProcedure [dbo].[CreateObserved]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC CreateObserved name, nationality, cpr, tags
CREATE PROCEDURE [dbo].[CreateObserved]
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
GO
/****** Object:  StoredProcedure [dbo].[CreateReport]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC CreateReport
CREATE PROCEDURE [dbo].[CreateReport]
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
GO
/****** Object:  StoredProcedure [dbo].[DeletePerson]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC DeletePerson
CREATE PROCEDURE [dbo].[DeletePerson]
(
	@id INT
)
AS
BEGIN
	DELETE FROM person WHERE person.id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[RowInTable]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RowInTable]
(
	@id INT,
	@table VARCHAR(MAX)
)
AS
BEGIN
	EXEC('SELECT COUNT(1) as bool FROM ' + @table + ' WHERE id=' + @id)
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAddress]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SelectAddress
CREATE PROCEDURE [dbo].[SelectAddress]
(
	@id INT
)
AS
BEGIN
	SELECT * FROM address WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAgent]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SelectAgent
CREATE PROCEDURE [dbo].[SelectAgent]
(
	@id INT
)
AS
BEGIN
	SELECT * FROM person
	JOIN agent ON agent.id = person.id
	WHERE person.id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAllAgents]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SelectAllAgents
CREATE PROCEDURE [dbo].[SelectAllAgents]
AS
BEGIN
	SELECT * FROM person
	JOIN agent ON agent.id = person.id
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAllInformers]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SelectAllInformers
CREATE PROCEDURE [dbo].[SelectAllInformers]
AS
BEGIN
	SELECT * FROM person
	JOIN informer ON informer.id = person.id
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAllObserved]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SelectAllObserved
CREATE PROCEDURE [dbo].[SelectAllObserved]
AS
BEGIN
	SELECT * FROM person
	JOIN observed ON observed.id = person.id
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAppearance]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SelectAppearance
CREATE PROCEDURE [dbo].[SelectAppearance]
(
	@id INT
)
AS
BEGIN
	SELECT * FROM Appearance WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[SelectImage]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SelectImage
CREATE PROCEDURE [dbo].[SelectImage]
(
	@id INT
)
AS
BEGIN
	SELECT * FROM image WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[SelectInformer]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SelectInformer
CREATE PROCEDURE [dbo].[SelectInformer]
(
	@id INT
)
AS
BEGIN
	SELECT * FROM person
	JOIN informer ON informer.id = person.id
	WHERE person.id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[SelectObserved]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SelectObserved
CREATE PROCEDURE [dbo].[SelectObserved]
(
	@id INT
)
AS
BEGIN
	SELECT * FROM person
	JOIN observed ON observed.id = person.id
	WHERE person.id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[SelectReportLogs]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SelectReportLogs
CREATE PROCEDURE [dbo].[SelectReportLogs]
(
	@id INT
)
AS
BEGIN
	SELECT * FROM report_log WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[SelectReports]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SelectReports
CREATE PROCEDURE [dbo].[SelectReports]
(
	@id INT
)
AS
BEGIN
	SELECT * FROM report WHERE observed_id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateAddress]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC UpdateAddress
CREATE PROCEDURE [dbo].[UpdateAddress]
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
GO
/****** Object:  StoredProcedure [dbo].[UpdateAgent]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAgent]
(
	@id INT,
	@name VARCHAR(255),
	@nationality CHAR(3),
	@cpr VARCHAR(11) = ''--,
--	@username VARCHAR(64),
--	@password CHAR(128)
)
AS
BEGIN
	UPDATE person 
	SET name = @name,
		nationality = @nationality,
		cpr = @cpr
	WHERE id = @id

	--UPDATE agent
	--SET username = @username,
	--	password = @password
	--WHERE id = @id

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateAppearance]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC UpdateAppearance
CREATE PROCEDURE [dbo].[UpdateAppearance]
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
GO
/****** Object:  StoredProcedure [dbo].[UpdateImage]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC UpdateImage
CREATE PROCEDURE [dbo].[UpdateImage]
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
GO
/****** Object:  StoredProcedure [dbo].[UpdateInformer]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC UpdateInformer id, name, nationality, cpr, username, password, currency, paymenttype, tags
CREATE PROCEDURE [dbo].[UpdateInformer]
(
	@id INT,
	@name VARCHAR(255),
	@nationality CHAR(3),
	@cpr VARCHAR(11) = '',
--	@username VARCHAR(64),
--	@password CHAR(128),
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
		--username = @username,
		--password = @password,
		currency = @currency,
		paymenttype = @paymenttype,
		tags = @tags
	WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateObserved]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC UpdateObserved id, name, nationality, cpr, tags
CREATE PROCEDURE [dbo].[UpdateObserved]
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
GO
/****** Object:  StoredProcedure [dbo].[UpdateReport]    Script Date: 03-05-2017 09:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC UpdateReport
CREATE PROCEDURE [dbo].[UpdateReport]
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
GO
USE [master]
GO
ALTER DATABASE [S3Eksamen] SET  READ_WRITE 
GO
