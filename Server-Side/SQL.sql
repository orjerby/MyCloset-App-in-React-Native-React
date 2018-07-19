USE [master]
GO
/****** Object:  Database [site05]    Script Date: 7/17/2018 1:27:02 PM ******/
CREATE DATABASE [site05]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'site05_data', FILENAME = N'C:\Program Files (x86)\Plesk\Databases\MSSQL\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\site05_1e32edfe87bb44f18504b712082605db.mdf' , SIZE = 4352KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'site05_log', FILENAME = N'C:\Program Files (x86)\Plesk\Databases\MSSQL\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\site05_afe26b39c6c743aba56adc109f439350.ldf' , SIZE = 3456KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [site05] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [site05].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [site05] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [site05] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [site05] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [site05] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [site05] SET ARITHABORT OFF 
GO
ALTER DATABASE [site05] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [site05] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [site05] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [site05] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [site05] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [site05] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [site05] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [site05] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [site05] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [site05] SET  DISABLE_BROKER 
GO
ALTER DATABASE [site05] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [site05] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [site05] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [site05] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [site05] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [site05] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [site05] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [site05] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [site05] SET  MULTI_USER 
GO
ALTER DATABASE [site05] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [site05] SET DB_CHAINING OFF 
GO
ALTER DATABASE [site05] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [site05] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [site05] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [site05] SET QUERY_STORE = OFF
GO
USE [site05]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [site05]
GO
/****** Object:  User [site05]    Script Date: 7/17/2018 1:27:03 PM ******/
CREATE USER [site05] FOR LOGIN [site05] WITH DEFAULT_SCHEMA=[site05]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [site05]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [site05]
GO
ALTER ROLE [db_datareader] ADD MEMBER [site05]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [site05]
GO
/****** Object:  Schema [site05]    Script Date: 7/17/2018 1:27:03 PM ******/
CREATE SCHEMA [site05]
GO
/****** Object:  UserDefinedDataType [dbo].[email]    Script Date: 7/17/2018 1:27:03 PM ******/
CREATE TYPE [dbo].[email] FROM [varchar](30) NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[id]    Script Date: 7/17/2018 1:27:03 PM ******/
CREATE TYPE [dbo].[id] FROM [int] NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[string_heb]    Script Date: 7/17/2018 1:27:03 PM ******/
CREATE TYPE [dbo].[string_heb] FROM [nvarchar](30) NOT NULL
GO
/****** Object:  UserDefinedDataType [site05].[text_heb]    Script Date: 7/17/2018 1:27:03 PM ******/
CREATE TYPE [site05].[text_heb] FROM [nvarchar](1000) NULL
GO
/****** Object:  UserDefinedTableType [site05].[ColorsList]    Script Date: 7/17/2018 1:27:03 PM ******/
CREATE TYPE [site05].[ColorsList] AS TABLE(
	[ColorID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [site05].[SeasonsList]    Script Date: 7/17/2018 1:27:03 PM ******/
CREATE TYPE [site05].[SeasonsList] AS TABLE(
	[SeasonID] [int] NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[CheckDate]    Script Date: 7/17/2018 1:27:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create function [dbo].[CheckDate](@email nvarchar(150))
 returns int
 as
	begin
		declare @res int
		if exists(select * from DateTurns where BusinessEmail = @email and DateTurn = DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE())))
			set @res = 1
		else
			set @res =  0
		return @res
	end


GO
/****** Object:  UserDefinedFunction [dbo].[CheckIfClientHaveTurn]    Script Date: 7/17/2018 1:27:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create function [dbo].[CheckIfClientHaveTurn](@email nvarchar(150))
 returns int
 as
	begin
		declare @res int
		if exists(select * from Queues where ClientEmail = @email and  Dateturns = DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE())))
			set @res = 1
		else
			set @res =  0
		return @res
	end


GO
/****** Object:  UserDefinedFunction [dbo].[user_login]    Script Date: 7/17/2018 1:27:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE function [dbo].[user_login](@email nvarchar(150), @password nvarchar(10))
 returns int
 as
	begin
		declare @res int
		if exists(select * from [Business] where [Password] = @password and [Email] = @email)
			set @res = 1
		else if exists(select * from [Client] where [Password] = @password and [Email] = @email)
			set @res =  2
		else
			set @res =  0
		return @res
	end


GO
/****** Object:  Table [site05].[Categories]    Script Date: 7/17/2018 1:27:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[CategoriesByGender]    Script Date: 7/17/2018 1:27:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[CategoriesByGender](
	[CategoryID] [int] NOT NULL,
	[GenderID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[Colors]    Script Date: 7/17/2018 1:27:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[Colors](
	[ColorID] [int] IDENTITY(1,1) NOT NULL,
	[ColorName] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[ColorsOfItems]    Script Date: 7/17/2018 1:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[ColorsOfItems](
	[ItemID] [int] NOT NULL,
	[ColorID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC,
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[Genders]    Script Date: 7/17/2018 1:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[Genders](
	[GenderID] [int] IDENTITY(1,1) NOT NULL,
	[GenderName] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[Items]    Script Date: 7/17/2018 1:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[Items](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[ItemImg] [varchar](max) NOT NULL,
	[SubcategoryID] [int] NOT NULL,
	[RateID] [int] NOT NULL,
	[ItemMeasure] [nvarchar](30) NULL,
	[ItemCompany] [nvarchar](30) NULL,
	[ItemComment] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [site05].[ItemsOfUsers]    Script Date: 7/17/2018 1:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[ItemsOfUsers](
	[ItemID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[Rates]    Script Date: 7/17/2018 1:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[Rates](
	[RateID] [int] IDENTITY(1,1) NOT NULL,
	[RateName] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[Seasons]    Script Date: 7/17/2018 1:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[Seasons](
	[SeasonID] [int] IDENTITY(1,1) NOT NULL,
	[SeasonName] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SeasonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[SeasonsOfItems]    Script Date: 7/17/2018 1:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[SeasonsOfItems](
	[ItemID] [int] NOT NULL,
	[SeasonID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC,
	[SeasonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[Subcategories]    Script Date: 7/17/2018 1:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[Subcategories](
	[SubcategoryID] [int] IDENTITY(1,1) NOT NULL,
	[SubcategoryName] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SubcategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[SubcategoriesOfCategories]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[SubcategoriesOfCategories](
	[CategoryID] [int] NOT NULL,
	[SubcategoryID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC,
	[SubcategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [site05].[Users]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [site05].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserEmail] [varchar](100) NOT NULL,
	[UserPass] [varchar](30) NOT NULL,
	[UserFirstName] [nvarchar](15) NOT NULL,
	[UserLastName] [nvarchar](15) NOT NULL,
	[GenderID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [site05].[CategoriesByGender]  WITH CHECK ADD FOREIGN KEY([GenderID])
REFERENCES [site05].[Genders] ([GenderID])
GO
ALTER TABLE [site05].[ColorsOfItems]  WITH CHECK ADD FOREIGN KEY([ItemID])
REFERENCES [site05].[Items] ([ItemID])
GO
ALTER TABLE [site05].[ColorsOfItems]  WITH CHECK ADD FOREIGN KEY([ItemID])
REFERENCES [site05].[Items] ([ItemID])
GO
ALTER TABLE [site05].[Items]  WITH CHECK ADD FOREIGN KEY([SubcategoryID])
REFERENCES [site05].[Subcategories] ([SubcategoryID])
GO
ALTER TABLE [site05].[Items]  WITH CHECK ADD FOREIGN KEY([SubcategoryID])
REFERENCES [site05].[Subcategories] ([SubcategoryID])
GO
ALTER TABLE [site05].[ItemsOfUsers]  WITH CHECK ADD FOREIGN KEY([ItemID])
REFERENCES [site05].[Items] ([ItemID])
GO
ALTER TABLE [site05].[ItemsOfUsers]  WITH CHECK ADD FOREIGN KEY([ItemID])
REFERENCES [site05].[Items] ([ItemID])
GO
ALTER TABLE [site05].[ItemsOfUsers]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [site05].[Users] ([UserID])
GO
ALTER TABLE [site05].[ItemsOfUsers]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [site05].[Users] ([UserID])
GO
ALTER TABLE [site05].[SeasonsOfItems]  WITH CHECK ADD FOREIGN KEY([ItemID])
REFERENCES [site05].[Items] ([ItemID])
GO
ALTER TABLE [site05].[SeasonsOfItems]  WITH CHECK ADD FOREIGN KEY([ItemID])
REFERENCES [site05].[Items] ([ItemID])
GO
ALTER TABLE [site05].[SubcategoriesOfCategories]  WITH CHECK ADD FOREIGN KEY([SubcategoryID])
REFERENCES [site05].[Subcategories] ([SubcategoryID])
GO
ALTER TABLE [site05].[SubcategoriesOfCategories]  WITH CHECK ADD FOREIGN KEY([SubcategoryID])
REFERENCES [site05].[Subcategories] ([SubcategoryID])
GO
ALTER TABLE [site05].[Users]  WITH CHECK ADD FOREIGN KEY([GenderID])
REFERENCES [site05].[Genders] ([GenderID])
GO
ALTER TABLE [site05].[Users]  WITH CHECK ADD FOREIGN KEY([GenderID])
REFERENCES [site05].[Genders] ([GenderID])
GO
/****** Object:  StoredProcedure [site05].[AddItem]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[AddItem]
@UserID int,
@ItemImg varchar(max),
@SubcategoryID int,
@RateID int,
@ItemMeasure nvarchar(30),
@ItemCompany nvarchar(30),
@ItemComment nvarchar(max)
AS
BEGIN
	--IF EXISTS (SELECT UserID FROM site05.Users WHERE (UserID = @UserID))
	--BEGIN


		INSERT [site05].[Items] (ItemImg, SubcategoryID, RateID, ItemMeasure, ItemCompany, ItemComment) Values (@ItemImg, @SubcategoryID, @RateID, @ItemMeasure, @ItemCompany, @ItemComment)
		declare @ID int = SCOPE_IDENTITY()
		INSERT [site05].[ItemsOfUsers] (ItemID, UserID) Values (@ID, @UserID)

		--all info on item but colors and seasons
		SELECT        site05.Items.ItemID, site05.Items.ItemImg, site05.Subcategories.SubcategoryID, site05.Subcategories.SubcategoryName, site05.Categories.CategoryID, site05.Categories.CategoryName, site05.Rates.RateID, 
                         site05.Rates.RateName, site05.Items.ItemMeasure, site05.Items.ItemCompany, site05.Items.ItemComment
		FROM            site05.Rates INNER JOIN
                         site05.Items ON site05.Rates.RateID = site05.Items.RateID INNER JOIN
                         site05.Subcategories ON site05.Items.SubcategoryID = site05.Subcategories.SubcategoryID INNER JOIN
                         site05.SubcategoriesOfCategories ON site05.Subcategories.SubcategoryID = site05.SubcategoriesOfCategories.SubcategoryID INNER JOIN
                         site05.Categories ON site05.SubcategoriesOfCategories.CategoryID = site05.Categories.CategoryID
		WHERE        (site05.Items.ItemID = @ID)


	--END
END
GO
/****** Object:  StoredProcedure [site05].[DeleteItem]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[DeleteItem]
@ItemID int
AS
BEGIN
	DELETE FROM [site05].[ItemsOfUsers] WHERE ItemID = @ItemID
	DELETE FROM [site05].[ColorsOfItems] WHERE ItemID = @ItemID
	DELETE FROM [site05].[SeasonsOfItems] WHERE ItemID = @ItemID
	DELETE FROM [site05].[Items] WHERE ItemID = @ItemID
END
GO
/****** Object:  StoredProcedure [site05].[EditItem]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[EditItem]
@ItemID int,
@ItemImg varchar(max),
@SubcategoryID int,
@RateID int,
@ItemMeasure nvarchar(30),
@ItemCompany nvarchar(30),
@ItemComment nvarchar(max)
AS
BEGIN
	UPDATE [site05].[Items]
	SET ItemImg=@ItemImg, SubcategoryID=@SubcategoryID, RateID=@RateID, ItemMeasure=@ItemMeasure, ItemCompany=@ItemCompany, ItemComment=@ItemComment
	WHERE ItemID=@ItemID
	
	SELECT        site05.Items.ItemID, site05.Items.ItemImg, site05.Subcategories.SubcategoryID, site05.Subcategories.SubcategoryName, site05.Categories.CategoryID, site05.Categories.CategoryName, site05.Rates.RateID, 
                         site05.Rates.RateName, site05.Items.ItemMeasure, site05.Items.ItemCompany, site05.Items.ItemComment
	FROM            site05.Rates INNER JOIN
                         site05.Items ON site05.Rates.RateID = site05.Items.RateID INNER JOIN
                         site05.Subcategories ON site05.Items.SubcategoryID = site05.Subcategories.SubcategoryID INNER JOIN
                         site05.SubcategoriesOfCategories ON site05.Subcategories.SubcategoryID = site05.SubcategoriesOfCategories.SubcategoryID INNER JOIN
                         site05.Categories ON site05.SubcategoriesOfCategories.CategoryID = site05.Categories.CategoryID
	WHERE        (site05.Items.ItemID = @ItemID)
END
GO
/****** Object:  StoredProcedure [site05].[GetAllColorsOfItem]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[GetAllColorsOfItem]
@ItemID int
AS
BEGIN
		SELECT        site05.Items.ItemID, site05.Colors.ColorID, site05.Colors.ColorName
		FROM            site05.Colors INNER JOIN
                         site05.ColorsOfItems ON site05.Colors.ColorID = site05.ColorsOfItems.ColorID INNER JOIN
                         site05.Items ON site05.ColorsOfItems.ItemID = site05.Items.ItemID
		WHERE        (site05.Items.ItemID = @ItemID)
END
GO
/****** Object:  StoredProcedure [site05].[GetAllSeasonsOfItem]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[GetAllSeasonsOfItem]
@ItemID int
AS
BEGIN
		SELECT        site05.Items.ItemID, site05.Seasons.SeasonID, site05.Seasons.SeasonName
		FROM            site05.Seasons INNER JOIN
                         site05.SeasonsOfItems ON site05.Seasons.SeasonID = site05.SeasonsOfItems.SeasonID INNER JOIN
                         site05.Items ON site05.SeasonsOfItems.ItemID = site05.Items.ItemID
		WHERE        (site05.Items.ItemID = @ItemID)
END
GO
/****** Object:  StoredProcedure [site05].[GetGenders]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[GetGenders]
AS
BEGIN
	SELECT GenderID, GenderName FROM site05.Genders
END
GO
/****** Object:  StoredProcedure [site05].[GetItemsByFilter]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[GetItemsByFilter]
@UserID int,
@SubcategoryID int,
@RateID int,
@ColorsList AS ColorsList READONLY,
@SeasonsList AS SeasonsList READONLY
AS
BEGIN
  SELECT ColorID FROM @ColorsList;
END
GO
/****** Object:  StoredProcedure [site05].[InsertColorToItem]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[InsertColorToItem]
@ItemID int,
@ColorID int
AS
BEGIN
		INSERT [site05].[ColorsOfItems] (ItemID, ColorID) Values (@ItemID, @ColorID)
END
GO
/****** Object:  StoredProcedure [site05].[InsertSeasonToItem]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[InsertSeasonToItem]
@ItemID int,
@SeasonID int
AS
BEGIN
		INSERT [site05].[SeasonsOfItems] (ItemID, SeasonID) Values (@ItemID, @SeasonID)
END
GO
/****** Object:  StoredProcedure [site05].[LoginUser]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[LoginUser]
@UserEmail varchar(30),
@UserPass VARCHAR(30)
AS
BEGIN
	IF EXISTS (SELECT UserID FROM site05.Users WHERE (UserEmail = @UserEmail) AND (UserPass = @UserPass COLLATE SQL_Latin1_General_CP1_CS_AS))
	BEGIN


	--colors of all items include ItemID
	SELECT        site05.Items.ItemID, site05.Colors.ColorID, site05.Colors.ColorName
	FROM            site05.Users INNER JOIN
                         site05.ItemsOfUsers ON site05.Users.UserID = site05.ItemsOfUsers.UserID INNER JOIN
                         site05.Items ON site05.ItemsOfUsers.ItemID = site05.Items.ItemID INNER JOIN
                         site05.ColorsOfItems ON site05.Items.ItemID = site05.ColorsOfItems.ItemID INNER JOIN
                         site05.Colors ON site05.ColorsOfItems.ColorID = site05.Colors.ColorID
	WHERE        (site05.Users.UserEmail = @UserEmail) AND (site05.Users.UserPass = @UserPass COLLATE SQL_Latin1_General_CP1_CS_AS)

	--seasons of all items include ItemID
	SELECT        site05.Items.ItemID, site05.Seasons.SeasonID, site05.Seasons.SeasonName
	FROM            site05.Users INNER JOIN
                         site05.ItemsOfUsers ON site05.Users.UserID = site05.ItemsOfUsers.UserID INNER JOIN
                         site05.Items ON site05.ItemsOfUsers.ItemID = site05.Items.ItemID INNER JOIN
                         site05.SeasonsOfItems ON site05.Items.ItemID = site05.SeasonsOfItems.ItemID INNER JOIN
                         site05.Seasons ON site05.SeasonsOfItems.SeasonID = site05.Seasons.SeasonID
	WHERE        (site05.Users.UserEmail = @UserEmail) AND (site05.Users.UserPass = @UserPass COLLATE SQL_Latin1_General_CP1_CS_AS)

	--all items of user with all but colors and seasons
SELECT        TOP (100) PERCENT site05.Rates.RateID, site05.Rates.RateName, site05.Items.ItemID, site05.Items.ItemImg, site05.Items.ItemMeasure, site05.Items.ItemCompany, site05.Items.ItemComment, 
                         site05.Subcategories.SubcategoryID, site05.Subcategories.SubcategoryName, site05.Categories.CategoryID, site05.Categories.CategoryName
FROM            site05.Users INNER JOIN
                         site05.ItemsOfUsers ON site05.Users.UserID = site05.ItemsOfUsers.UserID INNER JOIN
                         site05.Items ON site05.ItemsOfUsers.ItemID = site05.Items.ItemID INNER JOIN
                         site05.Rates ON site05.Items.RateID = site05.Rates.RateID INNER JOIN
                         site05.Subcategories ON site05.Items.SubcategoryID = site05.Subcategories.SubcategoryID INNER JOIN
                         site05.SubcategoriesOfCategories ON site05.Subcategories.SubcategoryID = site05.SubcategoriesOfCategories.SubcategoryID INNER JOIN
                         site05.Categories ON site05.SubcategoriesOfCategories.CategoryID = site05.Categories.CategoryID
	WHERE				(site05.Users.UserEmail = @UserEmail) AND (site05.Users.UserPass = @UserPass COLLATE SQL_Latin1_General_CP1_CS_AS)
	ORDER BY site05.Items.ItemID DESC

	--all user's info
	SELECT  	site05.Users.UserID, site05.Users.UserEmail, site05.Users.UserPass, site05.Users.UserFirstName, site05.Users.UserLastName, site05.Genders.GenderID, site05.Genders.GenderName
	FROM 		site05.Users INNER JOIN site05.Genders ON site05.Users.GenderID = site05.Genders.GenderID
	WHERE       (site05.Users.UserEmail = @UserEmail) AND (site05.Users.UserPass = @UserPass COLLATE SQL_Latin1_General_CP1_CS_AS)
	
	--all categories and subcategories of user's gender
	SELECT        site05.Subcategories.SubcategoryID, site05.Subcategories.SubcategoryName, site05.Categories.CategoryID, site05.Categories.CategoryName
	FROM            site05.Genders INNER JOIN
                         site05.Users ON site05.Genders.GenderID = site05.Users.GenderID INNER JOIN
                         site05.Subcategories INNER JOIN
                         site05.SubcategoriesOfCategories ON site05.Subcategories.SubcategoryID = site05.SubcategoriesOfCategories.SubcategoryID INNER JOIN
                         site05.Categories INNER JOIN
                         site05.CategoriesByGender ON site05.Categories.CategoryID = site05.CategoriesByGender.CategoryID ON site05.SubcategoriesOfCategories.CategoryID = site05.Categories.CategoryID ON 
                         site05.Genders.GenderID = site05.CategoriesByGender.GenderID
	WHERE			(site05.Users.UserEmail = @UserEmail) AND (site05.Users.UserPass = @UserPass COLLATE SQL_Latin1_General_CP1_CS_AS)

	--all colors
	SELECT      ColorID, ColorName
	FROM        site05.Colors

	--all seasons
	SELECT      SeasonID, SeasonName
	FROM        site05.Seasons

	--all rates
	SELECT      RateID, RateName
	FROM        site05.Rates


	END
END
GO
/****** Object:  StoredProcedure [site05].[RegisterUser]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[RegisterUser]
@UserEmail varchar(100),
@UserPass varchar(30),
@UserFirstName nvarchar(15),
@UserLastName nvarchar(15),
@GenderID int
AS
BEGIN
	IF NOT EXISTS (SELECT UserEmail FROM site05.Users WHERE UserEmail = @UserEmail)
	BEGIN
		INSERT [site05].[Users] (UserEmail, UserPass, UserFirstName, UserLastName, GenderID) Values (@UserEmail,@UserPass,@UserFirstName,@UserLastName,@GenderID)
		SELECT		site05.Users.UserID, site05.Users.UserEmail, site05.Users.UserPass, site05.Users.UserFirstName, site05.Users.UserLastName, site05.Genders.GenderID, site05.Genders.GenderName
		FROM        site05.Users INNER JOIN
                    site05.Genders ON site05.Users.GenderID = site05.Genders.GenderID
		WHERE       site05.Users.UserEmail = @UserEmail

		--all categories and subcategories of user's gender
		SELECT        site05.Subcategories.SubcategoryID, site05.Subcategories.SubcategoryName, site05.Categories.CategoryID, site05.Categories.CategoryName
		FROM            site05.Genders INNER JOIN
                         site05.Users ON site05.Genders.GenderID = site05.Users.GenderID INNER JOIN
                         site05.Subcategories INNER JOIN
                         site05.SubcategoriesOfCategories ON site05.Subcategories.SubcategoryID = site05.SubcategoriesOfCategories.SubcategoryID INNER JOIN
                         site05.Categories INNER JOIN
                         site05.CategoriesByGender ON site05.Categories.CategoryID = site05.CategoriesByGender.CategoryID ON site05.SubcategoriesOfCategories.CategoryID = site05.Categories.CategoryID ON 
                         site05.Genders.GenderID = site05.CategoriesByGender.GenderID
		WHERE        site05.Users.UserEmail = @UserEmail

		--all colors
		SELECT      ColorID, ColorName
		FROM        site05.Colors

		--all seasons
		SELECT      SeasonID, SeasonName
		FROM        site05.Seasons

		--all rates
		SELECT      RateID, RateName
		FROM        site05.Rates
	END
END
GO
/****** Object:  StoredProcedure [site05].[RemoveColorsAndSeasonsFromItem]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[RemoveColorsAndSeasonsFromItem]
@ItemID int
AS
BEGIN
	DELETE FROM [site05].[ColorsOfItems] WHERE ItemID=@ItemID
	DELETE FROM [site05].[SeasonsOfItems] WHERE ItemID=@ItemID
END
GO
/****** Object:  StoredProcedure [site05].[RemoveColorsFromItem]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[RemoveColorsFromItem]
@ItemID int
AS
BEGIN
	DELETE FROM [site05].[ColorsOfItems] WHERE ItemID=@ItemID
END
GO
/****** Object:  StoredProcedure [site05].[RemoveSeasonsFromItem]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[RemoveSeasonsFromItem]
@ItemID int
AS
BEGIN
	DELETE FROM [site05].[SeasonsOfItems] WHERE ItemID=@ItemID
END
GO
/****** Object:  StoredProcedure [site05].[UpdateUser]    Script Date: 7/17/2018 1:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [site05].[UpdateUser]
@UserID int,
@UserEmail varchar(100),
@UserPass varchar(30),
@UserFirstName nvarchar(15),
@UserLastName nvarchar(15)
AS
BEGIN
	IF NOT EXISTS (SELECT UserEmail FROM site05.Users WHERE UserEmail = @UserEmail)
	BEGIN
		UPDATE [site05].[Users] SET UserEmail = @UserEmail, UserPass = @UserPass, UserFirstName = @UserFirstName, UserLastName = @UserLastName WHERE UserID = @UserID
		SELECT		site05.Users.UserID, site05.Users.UserEmail, site05.Users.UserPass, site05.Users.UserFirstName, site05.Users.UserLastName, site05.Genders.GenderID, site05.Genders.GenderName
		FROM        site05.Users INNER JOIN
					site05.Genders ON site05.Users.GenderID = site05.Genders.GenderID
		WHERE       site05.Users.UserEmail = @UserEmail
	END
	ELSE
	BEGIN
		IF ((SELECT UserEmail FROM site05.Users WHERE UserID = @UserID) = @UserEmail)
			BEGIN
				UPDATE [site05].[Users] SET UserEmail = @UserEmail, UserPass = @UserPass, UserFirstName = @UserFirstName, UserLastName = @UserLastName WHERE UserID = @UserID
				SELECT		site05.Users.UserID, site05.Users.UserEmail, site05.Users.UserPass, site05.Users.UserFirstName, site05.Users.UserLastName, site05.Genders.GenderID, site05.Genders.GenderName
				FROM        site05.Users INNER JOIN
							site05.Genders ON site05.Users.GenderID = site05.Genders.GenderID
				WHERE       site05.Users.UserEmail = @UserEmail
		END
	END
END
GO
USE [master]
GO
ALTER DATABASE [site05] SET  READ_WRITE 
GO
