USE [CollegeStudents]
GO

EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Students', @level2type=N'CONSTRAINT',@level2name=N'FK_Students_Majors'
GO

ALTER TABLE [dbo].[Students] DROP CONSTRAINT [FK_Students_Majors]
GO

/****** Object:  Table [dbo].[Students]    Script Date: 6/7/2018 11:10:34 AM ******/
DROP TABLE [dbo].[Students]
GO

/****** Object:  Table [dbo].[Students]    Script Date: 6/7/2018 11:10:34 AM ******/
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

ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Majors] FOREIGN KEY([major_id])
REFERENCES [dbo].[Majors] ([major_id])
GO

ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Majors]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Relate Students to Majors' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Students', @level2type=N'CONSTRAINT',@level2name=N'FK_Students_Majors'
GO


