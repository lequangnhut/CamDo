USE [master]
GO
/****** Object:  Database [CamDo]    Script Date: 8/24/2023 11:01:50 PM ******/
CREATE DATABASE [CamDo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CamDo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\CamDo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CamDo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\CamDo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CamDo] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CamDo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CamDo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CamDo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CamDo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CamDo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CamDo] SET ARITHABORT OFF 
GO
ALTER DATABASE [CamDo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CamDo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CamDo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CamDo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CamDo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CamDo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CamDo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CamDo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CamDo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CamDo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CamDo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CamDo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CamDo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CamDo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CamDo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CamDo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CamDo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CamDo] SET RECOVERY FULL 
GO
ALTER DATABASE [CamDo] SET  MULTI_USER 
GO
ALTER DATABASE [CamDo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CamDo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CamDo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CamDo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CamDo] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CamDo', N'ON'
GO
ALTER DATABASE [CamDo] SET QUERY_STORE = OFF
GO
USE [CamDo]
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
USE [CamDo]
GO
/****** Object:  Table [dbo].[Historys]    Script Date: 8/24/2023 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Historys](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userid] [int] NOT NULL,
	[ThoiGianTruyCap] [datetime] NOT NULL,
	[Hanhdong] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Laisuat]    Script Date: 8/24/2023 11:01:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Laisuat](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[phantram] [int] NOT NULL,
 CONSTRAINT [PK_LoanInterest] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phieucam]    Script Date: 8/24/2023 11:01:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phieucam](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[maphieu] [char](4) NOT NULL,
	[fullname] [nvarchar](150) NOT NULL,
	[phonenumber] [char](10) NOT NULL,
	[bienso] [char](11) NOT NULL,
	[giacamco] [int] NOT NULL,
	[tienlai] [int] NOT NULL,
	[ngaycam] [date] NOT NULL,
	[ngayhethan] [date] NOT NULL,
	[songaydonglai] [int] NOT NULL,
	[status] [nvarchar](200) NOT NULL,
	[user_id] [int] NOT NULL,
	[laisuat_id] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
 CONSTRAINT [PK_PhieuCam] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/24/2023 11:01:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fullname] [nvarchar](100) NOT NULL,
	[username] [char](20) NOT NULL,
	[password] [char](20) NOT NULL,
	[isAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_users_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Historys] ON 

INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (1, 1, CAST(N'2023-08-24T01:55:33.443' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (2, 1, CAST(N'2023-08-24T01:56:14.023' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (3, 2, CAST(N'2023-08-24T01:56:27.710' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (4, 1, CAST(N'2023-08-24T01:56:36.317' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (5, 1, CAST(N'2023-08-24T01:57:54.217' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (6, 1, CAST(N'2023-08-24T01:58:02.817' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (7, 1, CAST(N'2023-08-24T02:01:55.570' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (8, 1, CAST(N'2023-08-24T02:02:15.477' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (9, 1, CAST(N'2023-08-24T02:03:31.967' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (10, 1, CAST(N'2023-08-24T02:07:19.877' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (11, 1, CAST(N'2023-08-24T02:07:56.107' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (12, 1, CAST(N'2023-08-24T02:08:37.890' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (13, 1, CAST(N'2023-08-24T02:10:28.827' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (14, 1, CAST(N'2023-08-24T02:11:04.233' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (15, 1, CAST(N'2023-08-24T02:11:32.423' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (16, 1, CAST(N'2023-08-24T02:12:55.593' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (17, 1, CAST(N'2023-08-24T02:13:37.823' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (18, 1, CAST(N'2023-08-24T02:14:29.980' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (19, 1, CAST(N'2023-08-24T02:14:59.100' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (20, 1, CAST(N'2023-08-24T02:16:12.330' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (21, 1, CAST(N'2023-08-24T02:16:53.940' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (22, 1, CAST(N'2023-08-24T02:19:14.263' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (23, 1, CAST(N'2023-08-24T02:22:42.207' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (24, 1, CAST(N'2023-08-24T02:23:28.873' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (25, 1, CAST(N'2023-08-24T02:24:11.367' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (26, 1, CAST(N'2023-08-24T02:28:57.883' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (27, 1, CAST(N'2023-08-24T02:29:00.730' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (28, 1, CAST(N'2023-08-24T02:29:04.303' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (29, 1, CAST(N'2023-08-24T02:29:08.790' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (30, 1, CAST(N'2023-08-24T02:29:36.460' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (31, 1, CAST(N'2023-08-24T02:29:37.050' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (32, 1, CAST(N'2023-08-24T02:29:40.137' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (33, 1, CAST(N'2023-08-24T02:31:56.853' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (34, 1, CAST(N'2023-08-24T15:53:21.033' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (35, 1, CAST(N'2023-08-24T15:53:32.783' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (36, 1, CAST(N'2023-08-24T15:54:17.637' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (37, 1, CAST(N'2023-08-24T15:54:24.140' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (38, 1, CAST(N'2023-08-24T15:54:25.403' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (39, 2, CAST(N'2023-08-24T15:54:27.983' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (40, 2, CAST(N'2023-08-24T15:54:52.973' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (41, 2, CAST(N'2023-08-24T15:55:15.803' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (42, 2, CAST(N'2023-08-24T16:07:42.217' AS DateTime), N'Xoá biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (43, 2, CAST(N'2023-08-24T16:07:43.850' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (44, 1, CAST(N'2023-08-24T16:07:48.407' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (45, 1, CAST(N'2023-08-24T16:08:05.520' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (46, 1, CAST(N'2023-08-24T16:10:16.847' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (47, 1, CAST(N'2023-08-24T16:10:40.363' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (48, 1, CAST(N'2023-08-24T16:10:51.497' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (49, 1, CAST(N'2023-08-24T16:10:54.900' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (50, 1, CAST(N'2023-08-24T16:11:02.013' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (51, 1, CAST(N'2023-08-24T16:11:06.903' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (52, 1, CAST(N'2023-08-24T16:11:14.173' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (53, 1, CAST(N'2023-08-24T16:12:14.617' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (54, 1, CAST(N'2023-08-24T16:12:30.040' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (55, 1, CAST(N'2023-08-24T16:17:53.023' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (56, 1, CAST(N'2023-08-24T16:18:18.023' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (57, 1, CAST(N'2023-08-24T16:19:14.803' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (58, 1, CAST(N'2023-08-24T16:20:13.447' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (59, 1, CAST(N'2023-08-24T16:20:58.647' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (60, 1, CAST(N'2023-08-24T16:21:30.087' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (61, 1, CAST(N'2023-08-24T16:26:47.967' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (62, 1, CAST(N'2023-08-24T16:37:31.823' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (63, 1, CAST(N'2023-08-24T16:38:14.123' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (64, 1, CAST(N'2023-08-24T16:45:49.377' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (65, 1, CAST(N'2023-08-24T17:04:20.067' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (66, 1, CAST(N'2023-08-24T17:05:44.477' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (67, 1, CAST(N'2023-08-24T17:05:52.230' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (68, 1, CAST(N'2023-08-24T17:05:52.940' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (69, 1, CAST(N'2023-08-24T17:11:21.647' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (70, 1, CAST(N'2023-08-24T17:11:41.960' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (71, 1, CAST(N'2023-08-24T17:14:20.470' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (72, 1, CAST(N'2023-08-24T17:18:22.967' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (73, 1, CAST(N'2023-08-24T17:21:54.343' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (74, 1, CAST(N'2023-08-24T17:24:13.897' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (75, 1, CAST(N'2023-08-24T17:24:34.133' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (76, 1, CAST(N'2023-08-24T17:26:26.003' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (77, 1, CAST(N'2023-08-24T17:27:11.257' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (78, 1, CAST(N'2023-08-24T17:37:05.297' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (79, 1, CAST(N'2023-08-24T17:37:20.647' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (80, 1, CAST(N'2023-08-24T17:37:36.390' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (81, 1, CAST(N'2023-08-24T17:37:59.130' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (82, 1, CAST(N'2023-08-24T17:38:24.397' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (83, 1, CAST(N'2023-08-24T17:42:54.000' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (84, 1, CAST(N'2023-08-24T17:43:33.867' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (85, 1, CAST(N'2023-08-24T17:46:48.860' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (86, 1, CAST(N'2023-08-24T17:47:27.020' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (87, 1, CAST(N'2023-08-24T17:47:45.207' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (88, 1, CAST(N'2023-08-24T19:24:16.550' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (89, 1, CAST(N'2023-08-24T19:24:36.027' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (90, 1, CAST(N'2023-08-24T19:25:24.283' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (91, 1, CAST(N'2023-08-24T19:25:48.130' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (92, 1, CAST(N'2023-08-24T19:27:04.743' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (93, 1, CAST(N'2023-08-24T19:27:38.827' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (94, 1, CAST(N'2023-08-24T19:28:19.103' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (95, 1, CAST(N'2023-08-24T19:29:17.767' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (96, 1, CAST(N'2023-08-24T19:34:57.953' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (97, 1, CAST(N'2023-08-24T19:36:49.397' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (98, 1, CAST(N'2023-08-24T19:37:25.873' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (99, 1, CAST(N'2023-08-24T19:38:41.023' AS DateTime), N'Đăng nhập')
GO
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (100, 1, CAST(N'2023-08-24T19:39:16.257' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (101, 1, CAST(N'2023-08-24T19:41:34.597' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (102, 1, CAST(N'2023-08-24T19:41:36.133' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (103, 1, CAST(N'2023-08-24T19:41:42.480' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (104, 1, CAST(N'2023-08-24T19:42:54.703' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (105, 1, CAST(N'2023-08-24T19:44:00.433' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (106, 1, CAST(N'2023-08-24T19:44:39.337' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (107, 1, CAST(N'2023-08-24T19:45:09.680' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (108, 1, CAST(N'2023-08-24T19:47:18.567' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (109, 1, CAST(N'2023-08-24T19:47:22.080' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (110, 1, CAST(N'2023-08-24T19:47:35.683' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (111, 1, CAST(N'2023-08-24T19:55:53.157' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (112, 1, CAST(N'2023-08-24T19:58:55.593' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (113, 1, CAST(N'2023-08-24T20:02:51.793' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (114, 1, CAST(N'2023-08-24T20:13:17.910' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (115, 1, CAST(N'2023-08-24T20:14:08.317' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (116, 1, CAST(N'2023-08-24T20:14:17.633' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (117, 1, CAST(N'2023-08-24T20:14:22.437' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (118, 1, CAST(N'2023-08-24T20:14:22.990' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (119, 1, CAST(N'2023-08-24T20:48:48.207' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (120, 1, CAST(N'2023-08-24T20:50:40.347' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (121, 1, CAST(N'2023-08-24T20:56:37.707' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (122, 1, CAST(N'2023-08-24T21:05:08.727' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (123, 1, CAST(N'2023-08-24T21:05:33.563' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (124, 1, CAST(N'2023-08-24T21:12:04.967' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (125, 1, CAST(N'2023-08-24T21:13:22.557' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (126, 1, CAST(N'2023-08-24T21:14:14.357' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (127, 1, CAST(N'2023-08-24T21:19:27.990' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (128, 1, CAST(N'2023-08-24T21:20:16.433' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (129, 1, CAST(N'2023-08-24T21:22:17.823' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (130, 1, CAST(N'2023-08-24T21:22:50.947' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (131, 1, CAST(N'2023-08-24T21:33:16.327' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (132, 1, CAST(N'2023-08-24T21:33:22.570' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (133, 1, CAST(N'2023-08-24T21:34:09.047' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (134, 1, CAST(N'2023-08-24T21:34:37.150' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (135, 1, CAST(N'2023-08-24T21:34:37.670' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (136, 1, CAST(N'2023-08-24T21:34:52.030' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (137, 1, CAST(N'2023-08-24T21:35:02.757' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (138, 1, CAST(N'2023-08-24T21:38:13.657' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (139, 1, CAST(N'2023-08-24T21:38:16.887' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (140, 1, CAST(N'2023-08-24T21:38:21.260' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (141, 1, CAST(N'2023-08-24T21:38:24.587' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (142, 1, CAST(N'2023-08-24T21:38:42.017' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (143, 1, CAST(N'2023-08-24T21:38:59.787' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (144, 1, CAST(N'2023-08-24T21:39:00.700' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (145, 1, CAST(N'2023-08-24T21:39:07.393' AS DateTime), N'Xoá biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (146, 1, CAST(N'2023-08-24T21:39:28.820' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (147, 1, CAST(N'2023-08-24T21:39:56.437' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (148, 1, CAST(N'2023-08-24T21:40:01.103' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (149, 1, CAST(N'2023-08-24T21:41:11.227' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (150, 1, CAST(N'2023-08-24T21:41:53.437' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (151, 1, CAST(N'2023-08-24T21:42:11.317' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (152, 1, CAST(N'2023-08-24T21:42:30.257' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (153, 1, CAST(N'2023-08-24T21:42:36.920' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (154, 1, CAST(N'2023-08-24T21:42:37.377' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (155, 1, CAST(N'2023-08-24T21:43:41.073' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (156, 1, CAST(N'2023-08-24T21:44:03.247' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (157, 1, CAST(N'2023-08-24T21:44:13.123' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (158, 1, CAST(N'2023-08-24T21:44:41.227' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (159, 1, CAST(N'2023-08-24T21:46:13.533' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (160, 1, CAST(N'2023-08-24T21:46:21.533' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (161, 1, CAST(N'2023-08-24T21:46:36.750' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (162, 1, CAST(N'2023-08-24T21:46:37.213' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (163, 1, CAST(N'2023-08-24T21:47:21.567' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (164, 1, CAST(N'2023-08-24T22:01:30.310' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (165, 1, CAST(N'2023-08-24T22:02:28.923' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (166, 1, CAST(N'2023-08-24T22:03:30.920' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (167, 1, CAST(N'2023-08-24T22:03:47.490' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (168, 1, CAST(N'2023-08-24T22:04:25.317' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (169, 1, CAST(N'2023-08-24T22:09:47.437' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (170, 1, CAST(N'2023-08-24T22:10:14.840' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (171, 1, CAST(N'2023-08-24T22:10:33.707' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (172, 1, CAST(N'2023-08-24T22:10:41.247' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (173, 1, CAST(N'2023-08-24T22:10:41.840' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (174, 1, CAST(N'2023-08-24T22:10:48.243' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (175, 1, CAST(N'2023-08-24T22:14:59.990' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (176, 1, CAST(N'2023-08-24T22:15:03.057' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (177, 1, CAST(N'2023-08-24T22:15:03.870' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (178, 1, CAST(N'2023-08-24T22:15:06.400' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (179, 1, CAST(N'2023-08-24T22:16:21.587' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (180, 1, CAST(N'2023-08-24T22:16:34.053' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (181, 1, CAST(N'2023-08-24T22:16:40.997' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (182, 1, CAST(N'2023-08-24T22:16:41.540' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (183, 1, CAST(N'2023-08-24T22:17:01.557' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (184, 1, CAST(N'2023-08-24T22:17:18.237' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (185, 1, CAST(N'2023-08-24T22:17:21.220' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (186, 1, CAST(N'2023-08-24T22:17:31.757' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (187, 1, CAST(N'2023-08-24T22:17:37.810' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (188, 1, CAST(N'2023-08-24T22:17:38.570' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (189, 1, CAST(N'2023-08-24T22:19:23.477' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (190, 1, CAST(N'2023-08-24T22:25:27.853' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (191, 1, CAST(N'2023-08-24T22:26:48.287' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (192, 1, CAST(N'2023-08-24T22:27:01.193' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (193, 1, CAST(N'2023-08-24T22:27:18.290' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (194, 1, CAST(N'2023-08-24T22:27:47.683' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (195, 1, CAST(N'2023-08-24T22:28:02.537' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (196, 1, CAST(N'2023-08-24T22:28:57.240' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (197, 1, CAST(N'2023-08-24T22:31:53.677' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (198, 2, CAST(N'2023-08-24T22:31:56.687' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (199, 2, CAST(N'2023-08-24T22:32:02.647' AS DateTime), N'Đăng xuất')
GO
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (200, 2, CAST(N'2023-08-24T22:32:45.067' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (201, 2, CAST(N'2023-08-24T22:44:09.370' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (202, 2, CAST(N'2023-08-24T22:49:19.910' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (203, 2, CAST(N'2023-08-24T22:49:34.697' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (204, 2, CAST(N'2023-08-24T22:50:03.983' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (205, 2, CAST(N'2023-08-24T22:50:33.367' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (206, 2, CAST(N'2023-08-24T22:50:44.233' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (207, 2, CAST(N'2023-08-24T22:50:53.380' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (208, 1, CAST(N'2023-08-24T22:52:58.700' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (209, 1, CAST(N'2023-08-24T22:53:12.217' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (210, 1, CAST(N'2023-08-24T22:53:30.870' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (211, 1, CAST(N'2023-08-24T22:54:02.097' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (212, 1, CAST(N'2023-08-24T22:54:24.980' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (213, 1, CAST(N'2023-08-24T22:56:14.167' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (214, 1, CAST(N'2023-08-24T22:58:05.167' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (215, 1, CAST(N'2023-08-24T22:58:25.083' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (216, 1, CAST(N'2023-08-24T22:58:35.533' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (217, 1, CAST(N'2023-08-24T22:58:37.083' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (218, 1, CAST(N'2023-08-24T22:58:57.870' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (219, 1, CAST(N'2023-08-24T22:59:10.183' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (220, 1, CAST(N'2023-08-24T23:00:25.507' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (221, 1, CAST(N'2023-08-24T23:00:38.207' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (222, 1, CAST(N'2023-08-24T23:00:47.207' AS DateTime), N'Đăng nhập')
SET IDENTITY_INSERT [dbo].[Historys] OFF
SET IDENTITY_INSERT [dbo].[Laisuat] ON 

INSERT [dbo].[Laisuat] ([id], [phantram]) VALUES (1, 6)
SET IDENTITY_INSERT [dbo].[Laisuat] OFF
SET IDENTITY_INSERT [dbo].[Phieucam] ON 

INSERT [dbo].[Phieucam] ([id], [maphieu], [fullname], [phonenumber], [bienso], [giacamco], [tienlai], [ngaycam], [ngayhethan], [songaydonglai], [status], [user_id], [laisuat_id], [isActive]) VALUES (1, N'0001', N'Nguyen Van A', N'0905154120', N'64A1-039.75', 1000000, 50000, CAST(N'2023-08-21' AS Date), CAST(N'2023-09-21' AS Date), 30, N'Đang cầm', 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [fullname], [phonenumber], [bienso], [giacamco], [tienlai], [ngaycam], [ngayhethan], [songaydonglai], [status], [user_id], [laisuat_id], [isActive]) VALUES (2, N'0002', N'Lê Quang Nhựt', N'0905015900', N'67M1-548.89', 3500000, 210000, CAST(N'2023-08-22' AS Date), CAST(N'2023-09-20' AS Date), 30, N'Đang cầm', 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [fullname], [phonenumber], [bienso], [giacamco], [tienlai], [ngaycam], [ngayhethan], [songaydonglai], [status], [user_id], [laisuat_id], [isActive]) VALUES (3, N'0003', N'Nguyễn Ngọc Như Ý', N'0379757473', N'67M1-123.45', 1000000, 60000, CAST(N'2023-08-22' AS Date), CAST(N'2023-09-22' AS Date), 30, N'Đang cầm', 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [fullname], [phonenumber], [bienso], [giacamco], [tienlai], [ngaycam], [ngayhethan], [songaydonglai], [status], [user_id], [laisuat_id], [isActive]) VALUES (4, N'0004', N'Nguyễn Ngọc Hoàng', N'0905015900', N'65M1-355.26', 25000000, 1500000, CAST(N'2023-08-22' AS Date), CAST(N'2023-09-22' AS Date), 30, N'Đang cầm', 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [fullname], [phonenumber], [bienso], [giacamco], [tienlai], [ngaycam], [ngayhethan], [songaydonglai], [status], [user_id], [laisuat_id], [isActive]) VALUES (6, N'0005', N'Lê Quang Nhựt ', N'0905015900', N'67M1-225.28', 1500000, 90000, CAST(N'2023-08-23' AS Date), CAST(N'2023-09-23' AS Date), 30, N'Đang cầm', 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [fullname], [phonenumber], [bienso], [giacamco], [tienlai], [ngaycam], [ngayhethan], [songaydonglai], [status], [user_id], [laisuat_id], [isActive]) VALUES (7, N'0006', N'Nguyễn Ngọc Như Hồng ', N'0901815102', N'67M1-235.21', 2300000, 138000, CAST(N'2023-08-23' AS Date), CAST(N'2023-09-23' AS Date), 30, N'Đang cầm', 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [fullname], [phonenumber], [bienso], [giacamco], [tienlai], [ngaycam], [ngayhethan], [songaydonglai], [status], [user_id], [laisuat_id], [isActive]) VALUES (8, N'0007', N'Nguyễn Long Hận', N'0934124245', N'67M1-451.54', 3500000, 210000, CAST(N'2023-08-23' AS Date), CAST(N'2023-09-23' AS Date), 30, N'Đang cầm', 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [fullname], [phonenumber], [bienso], [giacamco], [tienlai], [ngaycam], [ngayhethan], [songaydonglai], [status], [user_id], [laisuat_id], [isActive]) VALUES (9, N'0008', N'Trần Thanh Nhàn ', N'0379774124', N'68HA-124.21', 4000000, 240000, CAST(N'2023-08-23' AS Date), CAST(N'2023-09-23' AS Date), 30, N'Đang cầm', 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [fullname], [phonenumber], [bienso], [giacamco], [tienlai], [ngaycam], [ngayhethan], [songaydonglai], [status], [user_id], [laisuat_id], [isActive]) VALUES (10, N'0009', N'Ngọc Hường', N'0345712485', N'71B2-145.12', 6000000, 360000, CAST(N'2023-08-23' AS Date), CAST(N'2023-09-23' AS Date), 30, N'Đang cầm', 1, 1, 0)
INSERT [dbo].[Phieucam] ([id], [maphieu], [fullname], [phonenumber], [bienso], [giacamco], [tienlai], [ngaycam], [ngayhethan], [songaydonglai], [status], [user_id], [laisuat_id], [isActive]) VALUES (11, N'0010', N'Ngọc Hường', N'0967154145', N'67A1-123.41', 2500000, 150000, CAST(N'2023-07-23' AS Date), CAST(N'2023-07-23' AS Date), 30, N'Đã quá hạn 32 Ngày', 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [fullname], [phonenumber], [bienso], [giacamco], [tienlai], [ngaycam], [ngayhethan], [songaydonglai], [status], [user_id], [laisuat_id], [isActive]) VALUES (20, N'0011', N'Lê Nhựt', N'0916751444', N'67A1-123.12', 21000000, 1260000, CAST(N'2023-08-24' AS Date), CAST(N'2023-09-24' AS Date), 31, N'Đang cầm', 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [fullname], [phonenumber], [bienso], [giacamco], [tienlai], [ngaycam], [ngayhethan], [songaydonglai], [status], [user_id], [laisuat_id], [isActive]) VALUES (21, N'0012', N'Huỳnh Thanh Ngân', N'0374544444', N'92M1-456.21', 12000000, 720000, CAST(N'2023-08-24' AS Date), CAST(N'2023-08-24' AS Date), 31, N'Đang cầm', 1, 1, 1)
SET IDENTITY_INSERT [dbo].[Phieucam] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [fullname], [username], [password], [isAdmin]) VALUES (1, N'Nguyễn Thị Thanh Tuyền', N'admin               ', N'123123              ', 1)
INSERT [dbo].[Users] ([id], [fullname], [username], [password], [isAdmin]) VALUES (2, N'Nguyễn Ngọc Hoàng', N'user                ', N'123123              ', 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[Historys]  WITH CHECK ADD  CONSTRAINT [FK_Historys_Users] FOREIGN KEY([userid])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Historys] CHECK CONSTRAINT [FK_Historys_Users]
GO
ALTER TABLE [dbo].[Phieucam]  WITH CHECK ADD  CONSTRAINT [FK_Phieucam_Laisuat] FOREIGN KEY([laisuat_id])
REFERENCES [dbo].[Laisuat] ([id])
GO
ALTER TABLE [dbo].[Phieucam] CHECK CONSTRAINT [FK_Phieucam_Laisuat]
GO
ALTER TABLE [dbo].[Phieucam]  WITH CHECK ADD  CONSTRAINT [FK_Phieucam_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Phieucam] CHECK CONSTRAINT [FK_Phieucam_Users]
GO
USE [master]
GO
ALTER DATABASE [CamDo] SET  READ_WRITE 
GO
