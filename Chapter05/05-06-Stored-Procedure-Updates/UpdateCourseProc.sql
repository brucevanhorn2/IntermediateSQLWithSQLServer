-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters
-- command (Ctrl-Shift-M) to fill in the parameter
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bruce Van Horn
-- Create date: 6/7/2018
-- Description:	Updates a course record
-- =============================================
CREATE PROCEDURE DeleteCourse
	@CourseId int
AS
BEGIN
	delete from courses where course_id = @CourseId
END
GO
