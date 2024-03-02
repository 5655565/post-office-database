USE [master]
GO
/****** Object:  Database [post-office]    Script Date: 3/1/2024 11:00:44 PM ******/
CREATE DATABASE [post-office]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'post-office', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\post-office.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'post-office_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\post-office_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [post-office] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [post-office].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [post-office] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [post-office] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [post-office] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [post-office] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [post-office] SET ARITHABORT OFF 
GO
ALTER DATABASE [post-office] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [post-office] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [post-office] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [post-office] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [post-office] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [post-office] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [post-office] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [post-office] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [post-office] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [post-office] SET  DISABLE_BROKER 
GO
ALTER DATABASE [post-office] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [post-office] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [post-office] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [post-office] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [post-office] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [post-office] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [post-office] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [post-office] SET RECOVERY FULL 
GO
ALTER DATABASE [post-office] SET  MULTI_USER 
GO
ALTER DATABASE [post-office] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [post-office] SET DB_CHAINING OFF 
GO
ALTER DATABASE [post-office] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [post-office] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [post-office] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [post-office] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'post-office', N'ON'
GO
ALTER DATABASE [post-office] SET QUERY_STORE = ON
GO
ALTER DATABASE [post-office] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [post-office]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 3/1/2024 11:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[AdminID] [varchar](10) NOT NULL,
	[Fname] [varchar](50) NOT NULL,
	[Minit] [varchar](1) NULL,
	[Lname] [varchar](50) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[Phone] [varchar](10) NOT NULL,
	[AdminUser] [varchar](255) NOT NULL,
	[AdminPass] [varchar](255) NOT NULL,
	[Address] [varchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Branches]    Script Date: 3/1/2024 11:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branches](
	[BranchesID] [varchar](10) NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[ManagerID] [varchar](10) NOT NULL,
	[OperatingHours] [varchar](50) NOT NULL,
	[Schedule] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 3/1/2024 11:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [varchar](10) NOT NULL,
	[Fname] [varchar](50) NOT NULL,
	[Minit] [varchar](1) NULL,
	[Lname] [varchar](50) NOT NULL,
	[Phone] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer User]    Script Date: 3/1/2024 11:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer User](
	[UserID] [varchar](10) NOT NULL,
	[CustomerUser] [varchar](255) NOT NULL,
	[CustomerPass] [varchar](255) NOT NULL,
	[CustomerID] [varchar](10) NOT NULL,
	[Email] [varchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 3/1/2024 11:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[DepartmentID] [varchar](10) NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[OperatingHours] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 3/1/2024 11:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [varchar](10) NOT NULL,
	[Fname] [varchar](50) NOT NULL,
	[Minit] [varchar](1) NULL,
	[Lname] [varchar](50) NOT NULL,
	[Ssn] [varchar](9) NOT NULL,
	[Dob] [date] NOT NULL,
	[Phone] [varchar](10) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[Sex] [varchar](10) NOT NULL,
	[Salary] [decimal](18, 0) NOT NULL,
	[Role] [varchar](50) NOT NULL,
	[HireDate] [date] NOT NULL,
	[Schedule] [varchar](10) NOT NULL,
	[DepartmentID] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Package]    Script Date: 3/1/2024 11:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Package](
	[PackageID] [varchar](10) NOT NULL,
	[SenderID] [varchar](10) NOT NULL,
	[ReceiverID] [varchar](10) NOT NULL,
	[Weight] [decimal](18, 0) NOT NULL,
	[Dimensions] [decimal](18, 0) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[DateSent] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Store Item]    Script Date: 3/1/2024 11:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store Item](
	[ItemID] [varchar](10) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Cost] [decimal](18, 0) NOT NULL,
	[Inventory] [int] NOT NULL,
	[PostOfficeID] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tracking History]    Script Date: 3/1/2024 11:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tracking History](
	[TrackingID] [varchar](10) NOT NULL,
	[PackageID] [varchar](10) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[Location] [varchar](50) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[EstimatedDeliveryTime] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 3/1/2024 11:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[TransactionID] [varchar](10) NOT NULL,
	[TransactionType] [varchar](50) NOT NULL,
	[PackageID] [varchar](10) NOT NULL,
	[Date] [datetime] NOT NULL,
	[TotalAmount] [decimal](18, 0) NOT NULL,
	[ItemID] [varchar](10) NOT NULL,
	[PaymentType] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicles]    Script Date: 3/1/2024 11:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicles](
	[VehiclesID] [varchar](10) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[Location] [varchar](50) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[Unit] [varchar](50) NOT NULL,
	[PackageID] [varchar](10) NOT NULL,
	[EmployeeID] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [post-office] SET  READ_WRITE 
GO
