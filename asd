USE [VictorTest]
GO
/****** Object:  Table [dbo].[tblTeacher]    Script Date: 05/26/2014 17:41:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTeacher](
	[ID] [uniqueidentifier] NULL,
	[FirstName] [nvarchar](16) NULL,
	[LastName] [nvarchar](16) NULL,
	[MobileNo] [nvarchar](20) NULL,
	[Email] [nvarchar](64) NULL,
	[Avatar] [varbinary](max) NULL,
	[Des] [nvarchar](max) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_tblTeacher_ID] ON [dbo].[tblTeacher] 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblComment]    Script Date: 05/26/2014 17:41:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblComment](
	[ID] [uniqueidentifier] NULL,
	[C_ID] [uniqueidentifier] NULL,
	[T_ID] [uniqueidentifier] NULL,
	[C1] [tinyint] NULL,
	[C2] [tinyint] NULL,
	[C3] [tinyint] NULL,
	[C4] [tinyint] NULL,
	[C5] [tinyint] NULL,
	[T1] [tinyint] NULL,
	[T2] [tinyint] NULL,
	[T3] [tinyint] NULL,
	[T4] [tinyint] NULL,
	[T5] [tinyint] NULL,
	[C_Des] [nvarchar](max) NULL,
	[T_Des] [nvarchar](max) NULL,
	[CreateTime] [datetime] NOT NULL,
	[TaobaoTradeNo] [nvarchar](64) NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblComment_C_ID] ON [dbo].[tblComment] 
(
	[C_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblComment_T_ID] ON [dbo].[tblComment] 
(
	[T_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCourse]    Script Date: 05/26/2014 17:41:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCourse](
	[ID] [uniqueidentifier] NULL,
	[Name] [nvarchar](64) NULL,
	[Avatar] [varbinary](max) NULL,
	[Des] [nvarchar](max) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_tblCourse_ID] ON [dbo].[tblCourse] 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTea_Cour]    Script Date: 05/26/2014 17:41:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTea_Cour](
	[C_ID] [uniqueidentifier] NULL,
	[T_ID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
