/****** Object:  Table [dbo].[Majors]    Script Date: 6/7/2018 9:20:52 AM ******/
DROP TABLE [dbo].[Majors]
GO

/****** Object:  Table [dbo].[Majors]    Script Date: 6/7/2018 9:20:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Majors](
	[major_id] [int] NOT NULL,
	[major_title] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Majors] PRIMARY KEY CLUSTERED
(
	[major_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


