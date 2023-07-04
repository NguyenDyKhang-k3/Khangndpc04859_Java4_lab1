USE [master]
GO
/****** Object:  Database [Asm_web_phim]    Script Date: 4/11/2023 4:04:13 PM ******/
CREATE DATABASE [Asm_web_phim]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Asm_web_phim', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Asm_web_phim.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Asm_web_phim_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Asm_web_phim_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Asm_web_phim] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Asm_web_phim].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Asm_web_phim] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Asm_web_phim] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Asm_web_phim] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Asm_web_phim] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Asm_web_phim] SET ARITHABORT OFF 
GO
ALTER DATABASE [Asm_web_phim] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Asm_web_phim] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Asm_web_phim] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Asm_web_phim] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Asm_web_phim] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Asm_web_phim] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Asm_web_phim] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Asm_web_phim] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Asm_web_phim] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Asm_web_phim] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Asm_web_phim] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Asm_web_phim] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Asm_web_phim] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Asm_web_phim] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Asm_web_phim] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Asm_web_phim] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Asm_web_phim] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Asm_web_phim] SET RECOVERY FULL 
GO
ALTER DATABASE [Asm_web_phim] SET  MULTI_USER 
GO
ALTER DATABASE [Asm_web_phim] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Asm_web_phim] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Asm_web_phim] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Asm_web_phim] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Asm_web_phim] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Asm_web_phim', N'ON'
GO
ALTER DATABASE [Asm_web_phim] SET QUERY_STORE = OFF
GO
USE [Asm_web_phim]
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
USE [Asm_web_phim]
GO
/****** Object:  Table [dbo].[HOADON]    Script Date: 4/11/2023 4:04:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create table [user]
(
	id				int				primary key identity,
	username		varchar(50)		unique not null,
	[password]		varchar(50)		not null,
	email			varchar(50)		unique not null,
	isAdmin			bit				not null default 0,
	isActive		bit				not null default 1
)
go
create table video
(
	id				int				primary key identity,
	title			nvarchar(255)	not null,
	href			varchar(50)		unique not null,
	poster			varchar(255)	null,
	[views]			int				not null default 0,
	shares			int				not null default 0,
	[description]	nvarchar(255)	not null,
	isActive		bit				not null default 1
)
go
create table history
(
	id				int				primary key identity,
	userId			int				foreign key references [user] (id),
	videoId			int				foreign key references video (id),
	viewedDate		datetime		not null default getDate(),
	isLiked			int				not null default 0,
	likeDate		datetime		null
)
go
INSERT INTO [user] (username, [password], email, isAdmin)
VALUES
    ('khangnd', '123', 'khangnd@gmail.com', 1),
    ('tungbv', '456', 'tungbv@gmail.com', 0 ),
    ('thaipq', '789', 'thaipq@gmail.com',0)
go
INSERT INTO video (title, href, [views], shares, [description], isActive)
VALUES
    (N'Naruto Tập 1 - Ta Đây! Uzumaki Naruto', '-SBBef-OEiE&ab_channel=POPSAnime', 100, 50, N'Trọn Bộ Naruto Lồng Tiếng', 1),
    (N'One Piece Tập 1 - Tôi Là Luffy! Tôi Nhất Định Sẽ Trở Thành Vua Hải Tặc!', 'AeaD3Q-bFjU&ab_channel=POPSAnime', 200, 70, N'One Piece', 1),
    (N'Phim Anime 7 Viên Ngọc Rồng Z -Cuộc Chiến Của Các Vị Thần', 'vwaeaSXl1IE&ab_channel=SuHàoPhimTV',  150, 60, N'Dragon Ball Z', 1)
go

INSERT INTO history (userId, videoId, viewedDate, isLiked, likeDate)
VALUES
    (1, 1, '2023-06-01 10:00:00', 1, '2023-06-01 10:30:00'),
    (2, 1, '2023-06-02 09:00:00', 0, NULL),
    (3, 2, '2023-06-02 15:00:00', 1, '2023-06-02 15:30:00'),
    (1, 3, '2023-06-03 11:00:00', 0, NULL),
    (2, 3, '2023-06-03 16:00:00', 1, '2023-06-03 16:30:00')
	