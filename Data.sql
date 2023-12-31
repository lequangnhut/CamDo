USE [master]
GO
/****** Object:  Database [CamDo]    Script Date: 8/31/2023 10:44:59 AM ******/
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
/****** Object:  Table [dbo].[Customer]    Script Date: 8/31/2023 10:44:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fullname] [nvarchar](100) NOT NULL,
	[phonenumber] [char](10) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Donglai]    Script Date: 8/31/2023 10:44:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donglai](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[makh_id] [int] NOT NULL,
	[phieucam_id] [int] NOT NULL,
	[ngaydonglai] [datetime] NOT NULL,
	[tiendonglai] [int] NOT NULL,
	[status] [nvarchar](100) NOT NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK_Donglai] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Historys]    Script Date: 8/31/2023 10:44:59 AM ******/
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
/****** Object:  Table [dbo].[Phantramlai]    Script Date: 8/31/2023 10:44:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phantramlai](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[phantram] [int] NOT NULL,
 CONSTRAINT [PK_LoanInterest] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phieucam]    Script Date: 8/31/2023 10:44:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phieucam](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[maphieu] [char](4) NOT NULL,
	[makh_id] [int] NOT NULL,
	[bienso] [char](10) NOT NULL,
	[tiengoc] [int] NOT NULL,
	[tienlai] [int] NOT NULL,
	[ngayvao] [date] NOT NULL,
	[ngayra] [date] NOT NULL,
	[status] [nvarchar](200) NOT NULL,
	[phantram] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
	[user_id] [int] NOT NULL,
	[phantramlai_id] [int] NOT NULL,
 CONSTRAINT [PK_PhieuCam] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/31/2023 10:44:59 AM ******/
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
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([id], [fullname], [phonenumber]) VALUES (1, N'Lê Quang Nhựt', N'0967363342')
INSERT [dbo].[Customer] ([id], [fullname], [phonenumber]) VALUES (3, N'Nguyễn Thị Thanh', N'0374124512')
INSERT [dbo].[Customer] ([id], [fullname], [phonenumber]) VALUES (4, N'Nguyễn Ngọc Hoàng', N'0374512634')
INSERT [dbo].[Customer] ([id], [fullname], [phonenumber]) VALUES (5, N'Nguyễn Ngọc Như Ý', N'0379757473')
INSERT [dbo].[Customer] ([id], [fullname], [phonenumber]) VALUES (6, N'Lê Thành Quai', N'0939285082')
INSERT [dbo].[Customer] ([id], [fullname], [phonenumber]) VALUES (7, N'Nguyễn Thanh Hiền', N'0345124446')
INSERT [dbo].[Customer] ([id], [fullname], [phonenumber]) VALUES (13, N'Nguyễn Thành Nhơn', N'0356124478')
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[Donglai] ON 

INSERT [dbo].[Donglai] ([id], [makh_id], [phieucam_id], [ngaydonglai], [tiendonglai], [status], [isActive]) VALUES (2, 5, 25, CAST(N'2023-08-27T14:44:22.967' AS DateTime), 840000, N'Đang cầm', 1)
INSERT [dbo].[Donglai] ([id], [makh_id], [phieucam_id], [ngaydonglai], [tiendonglai], [status], [isActive]) VALUES (3, 5, 25, CAST(N'2023-08-27T14:44:33.780' AS DateTime), 840000, N'Đang cầm', 1)
INSERT [dbo].[Donglai] ([id], [makh_id], [phieucam_id], [ngaydonglai], [tiendonglai], [status], [isActive]) VALUES (4, 7, 36, CAST(N'2023-08-29T22:15:19.910' AS DateTime), 180000, N'Đang cầm', 1)
INSERT [dbo].[Donglai] ([id], [makh_id], [phieucam_id], [ngaydonglai], [tiendonglai], [status], [isActive]) VALUES (5, 7, 36, CAST(N'2023-08-29T22:15:22.330' AS DateTime), 180000, N'Đang cầm', 1)
INSERT [dbo].[Donglai] ([id], [makh_id], [phieucam_id], [ngaydonglai], [tiendonglai], [status], [isActive]) VALUES (6, 5, 25, CAST(N'2023-08-29T22:32:21.067' AS DateTime), 840000, N'Đang cầm', 1)
INSERT [dbo].[Donglai] ([id], [makh_id], [phieucam_id], [ngaydonglai], [tiendonglai], [status], [isActive]) VALUES (7, 5, 28, CAST(N'2023-08-29T22:33:32.973' AS DateTime), 840000, N'Đang cầm', 1)
INSERT [dbo].[Donglai] ([id], [makh_id], [phieucam_id], [ngaydonglai], [tiendonglai], [status], [isActive]) VALUES (8, 5, 34, CAST(N'2023-08-29T22:39:39.957' AS DateTime), 840000, N'Đang cầm', 1)
INSERT [dbo].[Donglai] ([id], [makh_id], [phieucam_id], [ngaydonglai], [tiendonglai], [status], [isActive]) VALUES (9, 5, 29, CAST(N'2023-08-29T22:40:01.103' AS DateTime), 840000, N'Đang cầm', 1)
INSERT [dbo].[Donglai] ([id], [makh_id], [phieucam_id], [ngaydonglai], [tiendonglai], [status], [isActive]) VALUES (10, 1, 2, CAST(N'2023-08-29T22:44:13.383' AS DateTime), 600000, N'Đang cầm', 1)
INSERT [dbo].[Donglai] ([id], [makh_id], [phieucam_id], [ngaydonglai], [tiendonglai], [status], [isActive]) VALUES (11, 1, 2, CAST(N'2023-08-29T22:51:54.083' AS DateTime), 720000, N'Đang cầm', 1)
SET IDENTITY_INSERT [dbo].[Donglai] OFF
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
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (223, 1, CAST(N'2023-08-25T00:09:42.653' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (224, 1, CAST(N'2023-08-25T12:11:55.807' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (225, 1, CAST(N'2023-08-25T12:21:29.640' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (226, 1, CAST(N'2023-08-25T12:21:46.107' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (227, 1, CAST(N'2023-08-25T12:22:11.537' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (228, 1, CAST(N'2023-08-25T12:22:22.507' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (229, 1, CAST(N'2023-08-25T12:23:24.677' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (230, 1, CAST(N'2023-08-25T12:23:34.927' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (231, 1, CAST(N'2023-08-25T12:23:45.360' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (232, 1, CAST(N'2023-08-25T12:23:54.153' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (233, 2, CAST(N'2023-08-25T12:23:57.357' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (234, 2, CAST(N'2023-08-25T12:28:02.630' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (235, 2, CAST(N'2023-08-25T12:29:19.693' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (236, 2, CAST(N'2023-08-25T12:30:17.103' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (237, 2, CAST(N'2023-08-25T12:31:46.367' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (238, 2, CAST(N'2023-08-25T12:32:44.420' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (239, 2, CAST(N'2023-08-25T12:35:43.633' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (240, 2, CAST(N'2023-08-25T12:36:40.907' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (241, 2, CAST(N'2023-08-25T12:37:08.677' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (242, 2, CAST(N'2023-08-25T12:37:37.287' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (243, 1, CAST(N'2023-08-25T12:37:40.933' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (244, 1, CAST(N'2023-08-25T13:01:01.910' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (245, 1, CAST(N'2023-08-25T13:01:04.680' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (246, 1, CAST(N'2023-08-25T13:04:34.573' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (247, 1, CAST(N'2023-08-25T13:04:37.007' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (248, 1, CAST(N'2023-08-25T13:05:49.307' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (249, 1, CAST(N'2023-08-25T13:05:54.140' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (250, 1, CAST(N'2023-08-25T13:05:55.020' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (251, 1, CAST(N'2023-08-25T13:05:57.140' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (252, 1, CAST(N'2023-08-25T13:06:50.437' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (253, 1, CAST(N'2023-08-25T13:08:49.453' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (254, 1, CAST(N'2023-08-25T13:08:53.043' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (255, 1, CAST(N'2023-08-25T13:09:23.673' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (256, 1, CAST(N'2023-08-25T13:09:25.697' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (257, 1, CAST(N'2023-08-25T13:09:42.020' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (258, 1, CAST(N'2023-08-25T13:09:55.650' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (259, 1, CAST(N'2023-08-25T13:10:32.923' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (260, 1, CAST(N'2023-08-25T13:10:39.850' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (261, 1, CAST(N'2023-08-25T13:11:31.520' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (262, 1, CAST(N'2023-08-25T13:12:18.883' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (263, 1, CAST(N'2023-08-25T13:12:21.027' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (264, 1, CAST(N'2023-08-25T13:13:08.027' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (265, 1, CAST(N'2023-08-25T13:14:49.860' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (266, 1, CAST(N'2023-08-25T13:16:29.913' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (267, 1, CAST(N'2023-08-25T13:16:58.753' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (268, 1, CAST(N'2023-08-25T13:32:46.997' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (269, 1, CAST(N'2023-08-25T13:32:49.017' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (270, 1, CAST(N'2023-08-25T13:33:45.243' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (271, 1, CAST(N'2023-08-25T13:33:47.397' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (272, 1, CAST(N'2023-08-25T13:34:10.840' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (273, 1, CAST(N'2023-08-25T13:34:13.050' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (274, 1, CAST(N'2023-08-25T13:35:05.760' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (275, 1, CAST(N'2023-08-25T13:35:08.397' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (276, 1, CAST(N'2023-08-25T13:36:12.307' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (277, 1, CAST(N'2023-08-25T13:36:29.580' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (278, 1, CAST(N'2023-08-25T13:38:40.433' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (279, 1, CAST(N'2023-08-25T13:39:30.377' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (280, 1, CAST(N'2023-08-25T13:40:26.477' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (281, 1, CAST(N'2023-08-25T13:41:11.710' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (282, 1, CAST(N'2023-08-25T13:48:45.953' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (283, 1, CAST(N'2023-08-25T13:49:45.683' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (284, 1, CAST(N'2023-08-25T13:53:09.700' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (285, 1, CAST(N'2023-08-25T13:53:44.647' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (286, 1, CAST(N'2023-08-25T13:55:56.557' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (287, 1, CAST(N'2023-08-25T13:56:40.280' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (288, 1, CAST(N'2023-08-25T13:58:42.300' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (289, 1, CAST(N'2023-08-25T13:59:07.233' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (290, 1, CAST(N'2023-08-25T14:00:37.663' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (291, 1, CAST(N'2023-08-25T14:00:57.290' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (292, 1, CAST(N'2023-08-25T14:02:27.930' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (293, 1, CAST(N'2023-08-25T14:03:04.620' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (294, 1, CAST(N'2023-08-25T14:05:15.703' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (295, 1, CAST(N'2023-08-25T14:06:24.620' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (296, 1, CAST(N'2023-08-25T14:09:37.127' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (297, 1, CAST(N'2023-08-25T14:09:38.207' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (298, 1, CAST(N'2023-08-25T14:10:18.213' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (299, 1, CAST(N'2023-08-25T14:10:44.263' AS DateTime), N'Đăng xuất')
GO
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (300, 1, CAST(N'2023-08-25T14:10:45.143' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (301, 1, CAST(N'2023-08-25T14:10:52.960' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (302, 1, CAST(N'2023-08-25T14:10:53.813' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (303, 1, CAST(N'2023-08-25T14:11:23.573' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (304, 1, CAST(N'2023-08-25T14:12:02.627' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (305, 1, CAST(N'2023-08-25T14:12:03.487' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (306, 1, CAST(N'2023-08-25T14:12:23.693' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (307, 1, CAST(N'2023-08-25T14:12:24.523' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (308, 1, CAST(N'2023-08-25T14:12:46.990' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (309, 1, CAST(N'2023-08-25T14:13:20.800' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (310, 1, CAST(N'2023-08-25T14:15:40.553' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (311, 1, CAST(N'2023-08-25T14:15:41.370' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (312, 1, CAST(N'2023-08-25T14:15:57.757' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (313, 1, CAST(N'2023-08-25T14:16:00.377' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (314, 1, CAST(N'2023-08-25T14:16:01.150' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (315, 1, CAST(N'2023-08-25T14:16:55.767' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (316, 1, CAST(N'2023-08-25T14:17:29.037' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (317, 1, CAST(N'2023-08-25T14:17:34.847' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (318, 1, CAST(N'2023-08-25T14:17:50.893' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (319, 1, CAST(N'2023-08-25T14:20:31.340' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (320, 1, CAST(N'2023-08-25T14:20:36.753' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (321, 1, CAST(N'2023-08-25T14:21:29.477' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (322, 1, CAST(N'2023-08-25T14:22:07.987' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (323, 1, CAST(N'2023-08-25T14:22:08.837' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (324, 1, CAST(N'2023-08-25T14:33:13.493' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (325, 1, CAST(N'2023-08-25T14:35:40.520' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (326, 1, CAST(N'2023-08-25T14:36:44.023' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (327, 1, CAST(N'2023-08-25T14:39:56.850' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (328, 1, CAST(N'2023-08-25T14:43:25.013' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (329, 1, CAST(N'2023-08-25T14:44:07.170' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (330, 1, CAST(N'2023-08-25T14:44:24.107' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (331, 1, CAST(N'2023-08-25T14:45:28.910' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (332, 1, CAST(N'2023-08-25T14:49:07.950' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (333, 1, CAST(N'2023-08-25T14:53:41.653' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (334, 1, CAST(N'2023-08-25T14:55:13.117' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (335, 1, CAST(N'2023-08-25T14:58:09.107' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (336, 1, CAST(N'2023-08-25T15:05:28.357' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (337, 1, CAST(N'2023-08-25T15:06:40.513' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (338, 1, CAST(N'2023-08-25T15:07:33.663' AS DateTime), N'Xoá biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (339, 1, CAST(N'2023-08-25T15:07:48.477' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (340, 1, CAST(N'2023-08-25T15:07:49.327' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (341, 1, CAST(N'2023-08-25T15:08:52.520' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (342, 1, CAST(N'2023-08-25T15:11:22.040' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (343, 1, CAST(N'2023-08-25T15:12:10.173' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (344, 1, CAST(N'2023-08-25T15:26:23.957' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (345, 1, CAST(N'2023-08-25T15:27:03.157' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (346, 1, CAST(N'2023-08-25T15:27:45.140' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (347, 1, CAST(N'2023-08-25T15:27:49.370' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (348, 1, CAST(N'2023-08-25T15:27:50.170' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (349, 1, CAST(N'2023-08-25T15:29:44.437' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (350, 1, CAST(N'2023-08-25T15:36:43.027' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (351, 1, CAST(N'2023-08-25T15:38:10.480' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (352, 1, CAST(N'2023-08-25T15:40:08.277' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (353, 1, CAST(N'2023-08-25T15:42:45.437' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (354, 1, CAST(N'2023-08-25T15:44:22.153' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (355, 1, CAST(N'2023-08-25T15:45:18.463' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (356, 1, CAST(N'2023-08-25T15:46:57.437' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (357, 1, CAST(N'2023-08-25T15:47:12.427' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (358, 1, CAST(N'2023-08-25T15:47:43.043' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (359, 1, CAST(N'2023-08-25T15:55:45.510' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (360, 1, CAST(N'2023-08-25T15:58:41.390' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (361, 1, CAST(N'2023-08-25T15:58:42.980' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (362, 2, CAST(N'2023-08-25T15:58:46.743' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (363, 2, CAST(N'2023-08-25T15:59:10.190' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (364, 2, CAST(N'2023-08-25T16:00:33.110' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (365, 2, CAST(N'2023-08-26T12:47:27.580' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (366, 2, CAST(N'2023-08-26T12:48:29.340' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (367, 2, CAST(N'2023-08-26T12:49:08.403' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (368, 2, CAST(N'2023-08-26T12:49:32.543' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (369, 2, CAST(N'2023-08-26T12:49:53.987' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (370, 2, CAST(N'2023-08-26T12:49:54.870' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (371, 2, CAST(N'2023-08-26T12:50:42.670' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (372, 2, CAST(N'2023-08-26T12:50:51.500' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (373, 2, CAST(N'2023-08-26T12:52:35.817' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (374, 2, CAST(N'2023-08-26T12:52:44.830' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (375, 2, CAST(N'2023-08-26T12:53:37.507' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (376, 2, CAST(N'2023-08-26T12:54:52.747' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (377, 2, CAST(N'2023-08-26T12:54:56.520' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (378, 1, CAST(N'2023-08-26T12:57:23.240' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (379, 1, CAST(N'2023-08-26T12:57:29.757' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (380, 1, CAST(N'2023-08-26T12:57:35.507' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (381, 1, CAST(N'2023-08-26T13:00:17.983' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (382, 1, CAST(N'2023-08-26T13:01:35.310' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (383, 1, CAST(N'2023-08-26T13:01:40.037' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (384, 1, CAST(N'2023-08-26T13:02:38.303' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (385, 1, CAST(N'2023-08-26T13:02:53.287' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (386, 1, CAST(N'2023-08-26T13:04:41.207' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (387, 1, CAST(N'2023-08-26T13:04:54.863' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (388, 1, CAST(N'2023-08-26T13:06:07.870' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (389, 1, CAST(N'2023-08-26T13:07:58.483' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (390, 1, CAST(N'2023-08-26T13:08:01.267' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (391, 1, CAST(N'2023-08-26T13:08:11.280' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (392, 1, CAST(N'2023-08-26T13:08:26.700' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (393, 1, CAST(N'2023-08-26T13:08:28.437' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (394, 1, CAST(N'2023-08-26T13:09:42.880' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (395, 1, CAST(N'2023-08-26T13:11:33.610' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (396, 1, CAST(N'2023-08-26T13:12:03.550' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (397, 1, CAST(N'2023-08-26T13:13:27.717' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (398, 1, CAST(N'2023-08-26T14:13:48.780' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (399, 1, CAST(N'2023-08-26T14:15:01.323' AS DateTime), N'Đăng nhập')
GO
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (400, 1, CAST(N'2023-08-26T14:15:13.297' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (401, 1, CAST(N'2023-08-26T14:15:29.983' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (402, 1, CAST(N'2023-08-26T14:19:38.127' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (403, 1, CAST(N'2023-08-26T14:20:41.263' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (404, 1, CAST(N'2023-08-26T14:22:08.123' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (405, 1, CAST(N'2023-08-26T14:22:26.977' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (406, 1, CAST(N'2023-08-26T14:23:40.307' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (407, 1, CAST(N'2023-08-26T14:23:50.130' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (408, 1, CAST(N'2023-08-26T14:27:40.653' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (409, 1, CAST(N'2023-08-26T14:28:59.877' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (410, 1, CAST(N'2023-08-26T14:29:33.267' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (411, 1, CAST(N'2023-08-26T14:30:20.710' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (412, 1, CAST(N'2023-08-26T14:31:12.430' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (413, 1, CAST(N'2023-08-26T14:31:49.100' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (414, 1, CAST(N'2023-08-26T14:33:39.563' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (415, 1, CAST(N'2023-08-26T14:33:42.403' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (416, 1, CAST(N'2023-08-26T14:33:45.937' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (417, 1, CAST(N'2023-08-26T14:33:57.137' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (418, 1, CAST(N'2023-08-26T14:34:19.253' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (419, 1, CAST(N'2023-08-26T14:34:26.307' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (420, 1, CAST(N'2023-08-26T14:38:07.367' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (421, 1, CAST(N'2023-08-26T14:38:10.490' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (422, 1, CAST(N'2023-08-26T14:40:35.117' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (423, 1, CAST(N'2023-08-26T14:40:38.990' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (424, 1, CAST(N'2023-08-26T14:40:42.737' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (425, 1, CAST(N'2023-08-26T14:40:46.127' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (426, 1, CAST(N'2023-08-26T14:41:57.807' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (427, 1, CAST(N'2023-08-26T14:42:05.043' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (428, 1, CAST(N'2023-08-26T14:42:10.677' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (429, 1, CAST(N'2023-08-26T14:42:36.960' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (430, 1, CAST(N'2023-08-26T14:42:40.183' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (431, 1, CAST(N'2023-08-26T14:43:10.230' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (432, 1, CAST(N'2023-08-26T14:43:46.743' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (433, 1, CAST(N'2023-08-26T14:44:04.830' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (434, 1, CAST(N'2023-08-26T14:44:05.610' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (435, 1, CAST(N'2023-08-26T14:44:25.330' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (436, 1, CAST(N'2023-08-26T14:44:33.210' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (437, 1, CAST(N'2023-08-26T14:44:53.917' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (438, 1, CAST(N'2023-08-26T14:44:54.763' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (439, 1, CAST(N'2023-08-26T14:45:21.437' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (440, 1, CAST(N'2023-08-26T14:57:18.600' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (441, 1, CAST(N'2023-08-26T14:57:51.797' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (442, 1, CAST(N'2023-08-26T15:02:21.387' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (443, 1, CAST(N'2023-08-26T15:05:13.707' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (444, 1, CAST(N'2023-08-26T15:05:42.503' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (445, 1, CAST(N'2023-08-26T15:05:43.373' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (446, 1, CAST(N'2023-08-26T15:10:17.693' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (447, 1, CAST(N'2023-08-26T15:13:23.910' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (448, 1, CAST(N'2023-08-26T15:14:01.610' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (449, 1, CAST(N'2023-08-26T15:15:04.527' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (450, 1, CAST(N'2023-08-26T15:23:19.300' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (451, 1, CAST(N'2023-08-26T15:24:47.863' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (452, 1, CAST(N'2023-08-26T15:35:56.177' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (453, 1, CAST(N'2023-08-26T15:40:11.520' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (454, 1, CAST(N'2023-08-26T15:40:28.780' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (455, 1, CAST(N'2023-08-26T15:42:11.183' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (456, 1, CAST(N'2023-08-26T15:43:02.533' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (457, 1, CAST(N'2023-08-26T15:43:59.827' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (458, 1, CAST(N'2023-08-26T15:44:16.257' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (459, 1, CAST(N'2023-08-26T15:44:58.287' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (460, 1, CAST(N'2023-08-26T15:46:18.427' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (461, 1, CAST(N'2023-08-26T15:48:16.090' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (462, 1, CAST(N'2023-08-26T15:48:23.987' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (463, 1, CAST(N'2023-08-26T15:48:41.923' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (464, 1, CAST(N'2023-08-26T15:49:36.833' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (465, 1, CAST(N'2023-08-26T15:51:33.660' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (466, 1, CAST(N'2023-08-26T15:52:00.730' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (467, 1, CAST(N'2023-08-26T15:52:25.437' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (468, 1, CAST(N'2023-08-26T15:53:27.030' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (469, 1, CAST(N'2023-08-26T15:54:22.933' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (470, 1, CAST(N'2023-08-26T15:54:23.757' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (471, 1, CAST(N'2023-08-26T15:55:11.330' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (472, 1, CAST(N'2023-08-26T15:56:27.383' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (473, 1, CAST(N'2023-08-26T15:56:40.243' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (474, 1, CAST(N'2023-08-26T15:56:58.077' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (475, 1, CAST(N'2023-08-26T15:57:08.737' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (476, 1, CAST(N'2023-08-26T15:57:11.590' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (477, 1, CAST(N'2023-08-26T15:57:12.420' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (478, 1, CAST(N'2023-08-26T15:57:20.597' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (479, 1, CAST(N'2023-08-26T15:58:51.613' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (480, 1, CAST(N'2023-08-26T15:58:52.393' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (481, 1, CAST(N'2023-08-26T15:59:25.787' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (482, 1, CAST(N'2023-08-26T16:00:05.977' AS DateTime), N'Xoá biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (483, 1, CAST(N'2023-08-26T16:00:19.987' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (484, 1, CAST(N'2023-08-26T16:01:32.127' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (485, 1, CAST(N'2023-08-26T16:01:36.037' AS DateTime), N'Xoá biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (486, 1, CAST(N'2023-08-26T16:01:40.130' AS DateTime), N'Xoá biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (487, 1, CAST(N'2023-08-26T16:03:06.997' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (488, 1, CAST(N'2023-08-26T16:04:10.613' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (489, 1, CAST(N'2023-08-26T16:04:30.427' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (490, 1, CAST(N'2023-08-26T16:06:56.137' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (491, 1, CAST(N'2023-08-26T16:07:10.887' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (492, 1, CAST(N'2023-08-26T16:07:14.680' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (493, 1, CAST(N'2023-08-26T16:07:17.237' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (494, 1, CAST(N'2023-08-26T16:07:50.720' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (495, 1, CAST(N'2023-08-26T16:09:29.103' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (496, 1, CAST(N'2023-08-26T16:09:56.973' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (497, 1, CAST(N'2023-08-26T16:10:35.457' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (498, 1, CAST(N'2023-08-26T16:11:33.793' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (499, 1, CAST(N'2023-08-26T16:12:10.367' AS DateTime), N'Đăng nhập')
GO
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (500, 1, CAST(N'2023-08-26T16:12:24.697' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (501, 1, CAST(N'2023-08-26T16:12:25.560' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (503, 1, CAST(N'2023-08-26T16:12:44.613' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (504, 1, CAST(N'2023-08-26T16:12:59.867' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (505, 1, CAST(N'2023-08-26T16:13:05.403' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (506, 1, CAST(N'2023-08-26T16:13:08.550' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (507, 1, CAST(N'2023-08-26T16:13:12.220' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (508, 1, CAST(N'2023-08-26T16:13:13.027' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (509, 1, CAST(N'2023-08-26T16:13:30.587' AS DateTime), N'Xoá biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (510, 1, CAST(N'2023-08-26T16:13:45.763' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (511, 1, CAST(N'2023-08-26T16:13:46.573' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (512, 1, CAST(N'2023-08-26T16:14:25.300' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (513, 1, CAST(N'2023-08-26T16:14:41.357' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (514, 1, CAST(N'2023-08-26T16:14:42.180' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (515, 1, CAST(N'2023-08-26T16:15:09.433' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (516, 1, CAST(N'2023-08-26T16:20:32.587' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (517, 1, CAST(N'2023-08-26T16:20:36.493' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (518, 1, CAST(N'2023-08-26T16:21:15.140' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (519, 1, CAST(N'2023-08-26T16:23:02.867' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (520, 1, CAST(N'2023-08-26T16:25:49.257' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (521, 1, CAST(N'2023-08-26T16:36:21.740' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (522, 1, CAST(N'2023-08-26T16:37:22.557' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (523, 1, CAST(N'2023-08-26T16:37:46.003' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (524, 1, CAST(N'2023-08-26T16:39:07.580' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (525, 1, CAST(N'2023-08-26T16:39:49.817' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (526, 1, CAST(N'2023-08-26T16:41:24.327' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (527, 1, CAST(N'2023-08-26T16:41:29.373' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (528, 1, CAST(N'2023-08-26T16:41:53.287' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (529, 1, CAST(N'2023-08-26T16:41:58.437' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (530, 1, CAST(N'2023-08-26T16:48:32.723' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (531, 1, CAST(N'2023-08-26T16:50:15.193' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (532, 1, CAST(N'2023-08-26T16:50:59.500' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (533, 1, CAST(N'2023-08-26T16:51:26.837' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (534, 1, CAST(N'2023-08-26T16:51:27.673' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (535, 1, CAST(N'2023-08-26T16:52:42.863' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (536, 1, CAST(N'2023-08-26T16:52:58.380' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (537, 1, CAST(N'2023-08-26T16:53:23.130' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (538, 1, CAST(N'2023-08-26T16:58:17.473' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (539, 1, CAST(N'2023-08-26T17:03:11.813' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (540, 1, CAST(N'2023-08-26T17:07:10.273' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (541, 1, CAST(N'2023-08-26T17:08:48.407' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (542, 1, CAST(N'2023-08-26T17:10:24.630' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (543, 1, CAST(N'2023-08-26T17:12:22.317' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (544, 1, CAST(N'2023-08-26T17:15:02.323' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (545, 1, CAST(N'2023-08-26T17:16:22.770' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (546, 1, CAST(N'2023-08-26T17:17:14.567' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (547, 1, CAST(N'2023-08-26T17:19:54.050' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (548, 1, CAST(N'2023-08-26T17:47:25.517' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (549, 1, CAST(N'2023-08-26T17:47:33.343' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (550, 1, CAST(N'2023-08-26T17:47:38.343' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (551, 1, CAST(N'2023-08-27T13:32:07.107' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (552, 1, CAST(N'2023-08-27T13:32:31.680' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (553, 1, CAST(N'2023-08-27T13:32:34.247' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (554, 1, CAST(N'2023-08-27T13:32:35.430' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (555, 1, CAST(N'2023-08-27T13:32:44.257' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (556, 1, CAST(N'2023-08-27T13:32:45.593' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (557, 1, CAST(N'2023-08-27T13:35:18.867' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (558, 1, CAST(N'2023-08-27T13:53:40.883' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (559, 1, CAST(N'2023-08-27T13:56:05.080' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (560, 1, CAST(N'2023-08-27T13:56:57.797' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (561, 1, CAST(N'2023-08-27T13:58:11.313' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (562, 1, CAST(N'2023-08-27T14:00:39.707' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (563, 1, CAST(N'2023-08-27T14:01:08.227' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (564, 1, CAST(N'2023-08-27T14:01:35.393' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (565, 1, CAST(N'2023-08-27T14:02:24.680' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (566, 1, CAST(N'2023-08-27T14:08:48.610' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (567, 1, CAST(N'2023-08-27T14:36:54.933' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (568, 1, CAST(N'2023-08-27T14:39:29.027' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (569, 1, CAST(N'2023-08-27T14:39:56.723' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (570, 1, CAST(N'2023-08-27T14:40:55.967' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (571, 1, CAST(N'2023-08-27T14:44:19.963' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (572, 1, CAST(N'2023-08-29T22:14:58.600' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (573, 1, CAST(N'2023-08-29T22:15:16.950' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (574, 1, CAST(N'2023-08-29T22:24:45.460' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (575, 1, CAST(N'2023-08-29T22:25:46.133' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (576, 1, CAST(N'2023-08-29T22:26:02.083' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (577, 1, CAST(N'2023-08-29T22:26:15.287' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (578, 1, CAST(N'2023-08-29T22:26:24.410' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (579, 1, CAST(N'2023-08-29T22:26:59.487' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (580, 1, CAST(N'2023-08-29T22:27:36.867' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (581, 1, CAST(N'2023-08-29T22:28:56.607' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (582, 1, CAST(N'2023-08-29T22:29:18.487' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (583, 1, CAST(N'2023-08-29T22:30:48.563' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (584, 1, CAST(N'2023-08-29T22:31:34.757' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (585, 1, CAST(N'2023-08-29T22:31:56.860' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (586, 1, CAST(N'2023-08-29T22:32:18.440' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (587, 1, CAST(N'2023-08-29T22:33:30.853' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (588, 1, CAST(N'2023-08-29T22:35:36.827' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (589, 1, CAST(N'2023-08-29T22:35:54.083' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (590, 1, CAST(N'2023-08-29T22:36:26.573' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (591, 1, CAST(N'2023-08-29T22:37:51.677' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (592, 1, CAST(N'2023-08-29T22:38:27.513' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (593, 1, CAST(N'2023-08-29T22:39:14.440' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (594, 1, CAST(N'2023-08-29T22:39:32.737' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (595, 1, CAST(N'2023-08-29T22:39:57.383' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (596, 1, CAST(N'2023-08-29T22:40:20.703' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (597, 1, CAST(N'2023-08-29T22:41:01.873' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (598, 1, CAST(N'2023-08-29T22:42:58.380' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (599, 1, CAST(N'2023-08-29T22:43:59.853' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (600, 1, CAST(N'2023-08-29T22:51:02.063' AS DateTime), N'Đăng nhập')
GO
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (601, 1, CAST(N'2023-08-29T22:51:45.903' AS DateTime), N'Cập nhật biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (602, 1, CAST(N'2023-08-29T22:52:55.887' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (603, 1, CAST(N'2023-08-29T22:53:01.037' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (604, 1, CAST(N'2023-08-29T22:56:45.777' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (605, 1, CAST(N'2023-08-29T22:57:22.320' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (606, 1, CAST(N'2023-08-29T23:01:30.180' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (607, 1, CAST(N'2023-08-29T23:08:10.813' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (608, 1, CAST(N'2023-08-29T23:08:36.760' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (609, 1, CAST(N'2023-08-29T23:09:31.597' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (610, 1, CAST(N'2023-08-29T23:10:02.867' AS DateTime), N'Thêm biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (611, 1, CAST(N'2023-08-29T23:11:23.570' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (612, 1, CAST(N'2023-08-29T23:11:43.330' AS DateTime), N'Xoá biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (613, 1, CAST(N'2023-08-29T23:11:47.990' AS DateTime), N'Xoá biên lai')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (614, 1, CAST(N'2023-08-29T23:11:51.813' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (615, 1, CAST(N'2023-08-29T23:12:09.623' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (616, 1, CAST(N'2023-08-29T23:14:04.557' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (617, 1, CAST(N'2023-08-29T23:15:06.113' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (618, 1, CAST(N'2023-08-29T23:16:10.183' AS DateTime), N'Đăng xuất')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (619, 1, CAST(N'2023-08-29T23:16:11.327' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (620, 1, CAST(N'2023-08-29T23:17:22.947' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (621, 1, CAST(N'2023-08-29T23:17:42.790' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (622, 1, CAST(N'2023-08-29T23:20:43.693' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (623, 1, CAST(N'2023-08-29T23:21:00.663' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (624, 1, CAST(N'2023-08-29T23:21:32.057' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (625, 1, CAST(N'2023-08-29T23:22:22.227' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (626, 1, CAST(N'2023-08-31T10:43:41.230' AS DateTime), N'Đăng nhập')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (627, 1, CAST(N'2023-08-31T10:44:07.357' AS DateTime), N'Truy cập vào lịch sử hoạt động')
INSERT [dbo].[Historys] ([id], [userid], [ThoiGianTruyCap], [Hanhdong]) VALUES (628, 1, CAST(N'2023-08-31T10:44:09.913' AS DateTime), N'Đăng xuất')
SET IDENTITY_INSERT [dbo].[Historys] OFF
SET IDENTITY_INSERT [dbo].[Phantramlai] ON 

INSERT [dbo].[Phantramlai] ([id], [phantram]) VALUES (1, 6)
SET IDENTITY_INSERT [dbo].[Phantramlai] OFF
SET IDENTITY_INSERT [dbo].[Phieucam] ON 

INSERT [dbo].[Phieucam] ([id], [maphieu], [makh_id], [bienso], [tiengoc], [tienlai], [ngayvao], [ngayra], [status], [phantram], [isActive], [user_id], [phantramlai_id]) VALUES (2, N'0001', 1, N'67M1-45613', 12000000, 720000, CAST(N'2023-08-26' AS Date), CAST(N'2023-09-26' AS Date), N'Đang cầm', 6, 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [makh_id], [bienso], [tiengoc], [tienlai], [ngayvao], [ngayra], [status], [phantram], [isActive], [user_id], [phantramlai_id]) VALUES (3, N'0002', 3, N'67H3-4412 ', 3400000, 204000, CAST(N'2023-08-26' AS Date), CAST(N'2023-09-26' AS Date), N'Đang cầm', 6, 0, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [makh_id], [bienso], [tiengoc], [tienlai], [ngayvao], [ngayra], [status], [phantram], [isActive], [user_id], [phantramlai_id]) VALUES (4, N'0003', 4, N'67M1-45000', 35000000, 2100000, CAST(N'2023-08-26' AS Date), CAST(N'2023-09-26' AS Date), N'Đang cầm', 6, 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [makh_id], [bienso], [tiengoc], [tienlai], [ngayvao], [ngayra], [status], [phantram], [isActive], [user_id], [phantramlai_id]) VALUES (25, N'0024', 3, N'67MA-14561', 14000000, 840000, CAST(N'2023-08-26' AS Date), CAST(N'2023-09-26' AS Date), N'Đang cầm', 6, 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [makh_id], [bienso], [tiengoc], [tienlai], [ngayvao], [ngayra], [status], [phantram], [isActive], [user_id], [phantramlai_id]) VALUES (28, N'0027', 5, N'67MA-14561', 14000000, 840000, CAST(N'2023-08-26' AS Date), CAST(N'2023-09-26' AS Date), N'Đang cầm', 6, 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [makh_id], [bienso], [tiengoc], [tienlai], [ngayvao], [ngayra], [status], [phantram], [isActive], [user_id], [phantramlai_id]) VALUES (29, N'0028', 5, N'67MA-14561', 14000000, 840000, CAST(N'2023-08-26' AS Date), CAST(N'2023-09-26' AS Date), N'Đang cầm', 6, 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [makh_id], [bienso], [tiengoc], [tienlai], [ngayvao], [ngayra], [status], [phantram], [isActive], [user_id], [phantramlai_id]) VALUES (34, N'0033', 5, N'67MA-14561', 14000000, 840000, CAST(N'2023-08-26' AS Date), CAST(N'2023-09-26' AS Date), N'Đang cầm', 6, 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [makh_id], [bienso], [tiengoc], [tienlai], [ngayvao], [ngayra], [status], [phantram], [isActive], [user_id], [phantramlai_id]) VALUES (35, N'0034', 6, N'67B2-45134', 23600000, 1416000, CAST(N'2023-08-26' AS Date), CAST(N'2023-09-26' AS Date), N'Đang cầm', 6, 1, 1, 1)
INSERT [dbo].[Phieucam] ([id], [maphieu], [makh_id], [bienso], [tiengoc], [tienlai], [ngayvao], [ngayra], [status], [phantram], [isActive], [user_id], [phantramlai_id]) VALUES (36, N'0035', 7, N'67B2-44512', 3000000, 180000, CAST(N'2023-08-26' AS Date), CAST(N'2023-09-26' AS Date), N'Đang cầm', 6, 1, 1, 1)
SET IDENTITY_INSERT [dbo].[Phieucam] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [fullname], [username], [password], [isAdmin]) VALUES (1, N'Nguyễn Thị Thanh Tuyền', N'admin               ', N'123123              ', 1)
INSERT [dbo].[Users] ([id], [fullname], [username], [password], [isAdmin]) VALUES (2, N'Nguyễn Ngọc Hoàng', N'user                ', N'123123              ', 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[Donglai]  WITH CHECK ADD  CONSTRAINT [FK_Donglai_Customer1] FOREIGN KEY([makh_id])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Donglai] CHECK CONSTRAINT [FK_Donglai_Customer1]
GO
ALTER TABLE [dbo].[Donglai]  WITH CHECK ADD  CONSTRAINT [FK_Donglai_Phieucam1] FOREIGN KEY([phieucam_id])
REFERENCES [dbo].[Phieucam] ([id])
GO
ALTER TABLE [dbo].[Donglai] CHECK CONSTRAINT [FK_Donglai_Phieucam1]
GO
ALTER TABLE [dbo].[Historys]  WITH CHECK ADD  CONSTRAINT [FK_Historys_Users] FOREIGN KEY([userid])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Historys] CHECK CONSTRAINT [FK_Historys_Users]
GO
ALTER TABLE [dbo].[Phieucam]  WITH CHECK ADD  CONSTRAINT [FK_Phieucam_Customer1] FOREIGN KEY([makh_id])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Phieucam] CHECK CONSTRAINT [FK_Phieucam_Customer1]
GO
ALTER TABLE [dbo].[Phieucam]  WITH CHECK ADD  CONSTRAINT [FK_Phieucam_Laisuat] FOREIGN KEY([phantramlai_id])
REFERENCES [dbo].[Phantramlai] ([id])
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
