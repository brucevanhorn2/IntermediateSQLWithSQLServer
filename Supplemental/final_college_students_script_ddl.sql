USE [master]
GO

/****** Object:  Database [CollegeStudents]    Script Date: 6/10/2018 2:45:00 PM ******/
PRINT('Dropping Database if it exists')
GO
DROP DATABASE IF EXISTS [CollegeStudents]
GO

/****** Object:  Database [CollegeStudents]    Script Date: 6/10/2018 2:45:00 PM ******/
CREATE DATABASE [CollegeStudents]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CollegeStudents', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\CollegeStudents.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CollegeStudents_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\CollegeStudents_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

PRINT('College Students Database Created')
GO

ALTER DATABASE [CollegeStudents] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CollegeStudents].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [CollegeStudents] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [CollegeStudents] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [CollegeStudents] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [CollegeStudents] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [CollegeStudents] SET ARITHABORT OFF 
GO

ALTER DATABASE [CollegeStudents] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [CollegeStudents] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [CollegeStudents] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [CollegeStudents] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [CollegeStudents] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [CollegeStudents] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [CollegeStudents] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [CollegeStudents] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [CollegeStudents] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [CollegeStudents] SET  DISABLE_BROKER 
GO

ALTER DATABASE [CollegeStudents] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [CollegeStudents] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [CollegeStudents] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [CollegeStudents] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [CollegeStudents] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [CollegeStudents] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [CollegeStudents] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [CollegeStudents] SET RECOVERY FULL 
GO

ALTER DATABASE [CollegeStudents] SET  MULTI_USER 
GO

ALTER DATABASE [CollegeStudents] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [CollegeStudents] SET DB_CHAINING OFF 
GO

ALTER DATABASE [CollegeStudents] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [CollegeStudents] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [CollegeStudents] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [CollegeStudents] SET QUERY_STORE = OFF
GO

USE [CollegeStudents]
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

ALTER DATABASE [CollegeStudents] SET  READ_WRITE 
GO

PRINT('Setting up the tables...')
GO

-- SET UP THE TABLES
/****** Object:  Table [dbo].[Students]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[student_id] [int] IDENTITY(1,1) NOT NULL,
	[student_number] [varchar](10) NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[major_id] [int] NOT NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Majors]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Majors](
	[major_id] [int] IDENTITY(1,1) NOT NULL,
	[major_number] [int] NOT NULL,
	[major_title] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Majors] PRIMARY KEY CLUSTERED 
(
	[major_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  View [dbo].[vwStudentsMajors]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwStudentsMajors]
AS
SELECT        s.student_number, s.first_name, s.last_name, m.major_number, m.major_title
FROM            dbo.Students AS s INNER JOIN
                         dbo.Majors AS m ON s.major_id = m.major_id
GO
/****** Object:  Table [dbo].[Buildings]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Buildings](
	[building_id] [int] IDENTITY(1,1) NOT NULL,
	[building_name] [varchar](100) NOT NULL,
	[address1] [varchar](255) NOT NULL,
	[address2] [varchar](255) NULL,
	[city] [varchar](100) NOT NULL,
	[state] [char](2) NOT NULL,
	[zip] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Buildings] PRIMARY KEY CLUSTERED 
(
	[building_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Courses]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[course_id] [int] IDENTITY(1,1) NOT NULL,
	[course_number] [varchar](10) NOT NULL,
	[course_title] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Faculty]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faculty](
	[faculty_id] [int] IDENTITY(1,1) NOT NULL,
	[faculty_number] [varchar](10) NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[faculty_type] [int] NOT NULL,
 CONSTRAINT [PK_Faculty] PRIMARY KEY CLUSTERED 
(
	[faculty_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacultyTypes]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacultyTypes](
	[faculty_type_id] [int] IDENTITY(1,1) NOT NULL,
	[faculty_title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_FacultyTypes] PRIMARY KEY CLUSTERED 
(
	[faculty_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[location_id] [int] IDENTITY(1,1) NOT NULL,
	[building_id] [int] NOT NULL,
	[room_number] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[location_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MeetingTimes]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeetingTimes](
	[meeting_time_id] [int] IDENTITY(1,1) NOT NULL,
	[section_id] [int] NOT NULL,
	[start_time] [time](7) NOT NULL,
	[end_time] [time](7) NOT NULL,
	[location_id] [int] NOT NULL,
 CONSTRAINT [PK_MeetingTimes] PRIMARY KEY CLUSTERED 
(
	[meeting_time_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prerequisites]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prerequisites](
	[prerequisite_id] [int] IDENTITY(1,1) NOT NULL,
	[course_id] [int] NOT NULL,
	[prerequisite_course_id] [int] NOT NULL,
 CONSTRAINT [PK_Prerequisites] PRIMARY KEY CLUSTERED 
(
	[prerequisite_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sections]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sections](
	[section_id] [int] IDENTITY(1,1) NOT NULL,
	[section_number] [varchar](10) NOT NULL,
	[course_id] [int] NOT NULL,
	[faculty_id] [int] NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[day_code] [char](1) NULL,
 CONSTRAINT [PK_Sections] PRIMARY KEY CLUSTERED 
(
	[section_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentsSectionsMap]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentsSectionsMap](
	[student_sections_map_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[section_id] [int] NOT NULL,
	[final_average] [float](4) NULL,
 CONSTRAINT [PK_StudentsSectionsMap] PRIMARY KEY CLUSTERED 
(
	[student_sections_map_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Faculty]  WITH CHECK ADD  CONSTRAINT [FK_Faculty_FacultyTypes] FOREIGN KEY([faculty_type])
REFERENCES [dbo].[FacultyTypes] ([faculty_type_id])
GO
ALTER TABLE [dbo].[Faculty] CHECK CONSTRAINT [FK_Faculty_FacultyTypes]
GO
ALTER TABLE [dbo].[Locations]  WITH CHECK ADD  CONSTRAINT [FK_Locations_Buildings] FOREIGN KEY([building_id])
REFERENCES [dbo].[Buildings] ([building_id])
GO
ALTER TABLE [dbo].[Locations] CHECK CONSTRAINT [FK_Locations_Buildings]
GO
ALTER TABLE [dbo].[MeetingTimes]  WITH CHECK ADD  CONSTRAINT [FK_MeetingTimes_Locations] FOREIGN KEY([location_id])
REFERENCES [dbo].[Locations] ([location_id])
GO
ALTER TABLE [dbo].[MeetingTimes] CHECK CONSTRAINT [FK_MeetingTimes_Locations]
GO
ALTER TABLE [dbo].[MeetingTimes]  WITH CHECK ADD  CONSTRAINT [FK_MeetingTimes_Sections] FOREIGN KEY([section_id])
REFERENCES [dbo].[Sections] ([section_id])
GO
ALTER TABLE [dbo].[MeetingTimes] CHECK CONSTRAINT [FK_MeetingTimes_Sections]
GO
ALTER TABLE [dbo].[Prerequisites]  WITH CHECK ADD  CONSTRAINT [FK_Prerequisites_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([course_id])
GO
ALTER TABLE [dbo].[Prerequisites] CHECK CONSTRAINT [FK_Prerequisites_Courses]
GO
ALTER TABLE [dbo].[Sections]  WITH CHECK ADD  CONSTRAINT [FK_Sections_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([course_id])
GO
ALTER TABLE [dbo].[Sections] CHECK CONSTRAINT [FK_Sections_Courses]
GO
ALTER TABLE [dbo].[Sections]  WITH CHECK ADD  CONSTRAINT [FK_Sections_Faculty] FOREIGN KEY([faculty_id])
REFERENCES [dbo].[Faculty] ([faculty_id])
GO
ALTER TABLE [dbo].[Sections] CHECK CONSTRAINT [FK_Sections_Faculty]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Majors] FOREIGN KEY([major_id])
REFERENCES [dbo].[Majors] ([major_id])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Majors]
GO
ALTER TABLE [dbo].[StudentsSectionsMap]  WITH CHECK ADD  CONSTRAINT [FK_StudentsSectionsMap_Sections] FOREIGN KEY([section_id])
REFERENCES [dbo].[Sections] ([section_id])
GO
ALTER TABLE [dbo].[StudentsSectionsMap] CHECK CONSTRAINT [FK_StudentsSectionsMap_Sections]
GO
ALTER TABLE [dbo].[StudentsSectionsMap]  WITH CHECK ADD  CONSTRAINT [FK_StudentsSectionsMap_Students] FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[StudentsSectionsMap] CHECK CONSTRAINT [FK_StudentsSectionsMap_Students]
GO

-- STORED PROCEDURES
PRINT('Creating stored procs')
GO
/****** Object:  StoredProcedure [dbo].[CourseDetail]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bruce Van Horn
-- Create date: 6/7/2018
-- Description:	Gets the details for a specific course id.
-- =============================================
CREATE PROCEDURE [dbo].[CourseDetail] 
	-- Add the parameters for the stored procedure here
	@CourseId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select * from courses where course_id = @CourseId
END
GO
/****** Object:  StoredProcedure [dbo].[CreateCourse]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bruce Van Horn
-- Create date: 6/7/2018
-- Description:	Adds a course to the course table
-- =============================================
CREATE PROCEDURE [dbo].[CreateCourse]
	@CourseNumber varchar(10), 
	@CourseTitle varchar(100)
AS
BEGIN
	insert into courses ([course_number], [course_title]) values (@CourseNumber, @CourseTitle)
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteCourse]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bruce Van Horn
-- Create date: 6/7/2018
-- Description:	Updates a course record
-- =============================================
CREATE PROCEDURE [dbo].[DeleteCourse]
	@CourseId int
AS
BEGIN
	delete from courses where course_id = @CourseId
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateCourse]    Script Date: 6/10/2018 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bruce Van Horn
-- Create date: 6/7/2018
-- Description:	Updates a course record
-- =============================================
CREATE PROCEDURE [dbo].[UpdateCourse]
	@CourseId int,
	@CourseNumber varchar(10),
	@CourseTitle varchar(100)
AS
BEGIN
	
	update courses set course_number = @CourseNumber, course_title=@CourseTitle where course_id = @CourseId
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "m"
            Begin Extent = 
               Top = 6
               Left = 252
               Bottom = 119
               Right = 422
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwStudentsMajors'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwStudentsMajors'
GO
