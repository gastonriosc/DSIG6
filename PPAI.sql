USE [master]
GO
/****** Object:  Database [PPAI]    Script Date: 27/10/2021 09:40:48 ******/
CREATE DATABASE [PPAI]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PPAI', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\PPAI.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PPAI_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\PPAI_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PPAI] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PPAI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PPAI] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PPAI] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PPAI] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PPAI] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PPAI] SET ARITHABORT OFF 
GO
ALTER DATABASE [PPAI] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PPAI] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PPAI] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PPAI] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PPAI] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PPAI] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PPAI] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PPAI] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PPAI] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PPAI] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PPAI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PPAI] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PPAI] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PPAI] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PPAI] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PPAI] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PPAI] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PPAI] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PPAI] SET  MULTI_USER 
GO
ALTER DATABASE [PPAI] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PPAI] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PPAI] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PPAI] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PPAI] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PPAI] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PPAI] SET QUERY_STORE = OFF
GO
USE [PPAI]
GO
/****** Object:  Table [dbo].[ASIGNACION]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ASIGNACION](
	[num_reserva] [int] NOT NULL,
	[dni_empleado] [int] NOT NULL,
	[FechaHoraInicio] [datetime] NULL,
	[FechaHoraFin] [datetime] NULL,
 CONSTRAINT [asignacion_num_pk] PRIMARY KEY CLUSTERED 
(
	[num_reserva] ASC,
	[dni_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CAMBIOS_ESTADO]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAMBIOS_ESTADO](
	[num_reserva] [int] NOT NULL,
	[id_estado] [int] NOT NULL,
	[FechaHoraInicio] [datetime] NULL,
	[FechaHoraFin] [datetime] NULL,
 CONSTRAINT [PK_CAMBIOS_ESTADO] PRIMARY KEY CLUSTERED 
(
	[num_reserva] ASC,
	[id_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CARGOS]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARGOS](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
 CONSTRAINT [PK_CARGO] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DETALLES_EXP]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLES_EXP](
	[id_exposicion] [int] NOT NULL,
	[id_obra] [int] NOT NULL,
	[lugar_asignado] [varchar](50) NULL,
 CONSTRAINT [PK_DETALLE_EXP] PRIMARY KEY CLUSTERED 
(
	[id_exposicion] ASC,
	[id_obra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIAS_SEMANA]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIAS_SEMANA](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
 CONSTRAINT [PK_DIAS_SEMANA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EMPLEADOS]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EMPLEADOS](
	[dni] [int] NOT NULL,
	[apellido] [varchar](50) NULL,
	[nombre] [varchar](50) NULL,
	[cargo] [int] NULL,
	[mail] [varchar](50) NULL,
	[id_sede] [int] NULL,
 CONSTRAINT [PK_EMPLEADOS] PRIMARY KEY CLUSTERED 
(
	[dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESCUELAS]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESCUELAS](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
 CONSTRAINT [escuelas_id_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESTADOS]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESTADOS](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
 CONSTRAINT [PK_ESTADOS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EXPOSICION]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXPOSICION](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[fechaInicio] [datetime] NULL,
	[fechaFin] [datetime] NULL,
	[id_tipo_exp] [int] NULL,
	[id_publico] [int] NULL,
	[id_sede] [int] NULL,
	[horaApertura] [time](7) NULL,
	[horaCierre] [time](7) NULL,
 CONSTRAINT [Exposicion_id_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EXPOXRESER]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXPOXRESER](
	[numero_reserva] [int] NOT NULL,
	[id_exposicion] [int] NOT NULL,
 CONSTRAINT [expoXreserva_pk] PRIMARY KEY CLUSTERED 
(
	[numero_reserva] ASC,
	[id_exposicion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HORARIOS_EMP]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HORARIOS_EMP](
	[dni_empleado] [int] NOT NULL,
	[id_dia_semana] [int] NOT NULL,
	[hora_inicio] [time](7) NOT NULL,
	[hora_fin] [time](7) NULL,
 CONSTRAINT [PK_HORARIOS_emp] PRIMARY KEY CLUSTERED 
(
	[dni_empleado] ASC,
	[id_dia_semana] ASC,
	[hora_inicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OBRAS]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OBRAS](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[duracion_ext] [int] NULL,
	[duracion_res] [int] NULL,
	[descripcion] [varchar](100) NULL,
 CONSTRAINT [obras_id_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PUBLICOS_DESTINO]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PUBLICOS_DESTINO](
	[id_publico] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[descrip] [varchar](50) NULL,
 CONSTRAINT [id_exposicion] PRIMARY KEY CLUSTERED 
(
	[id_publico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RESERVAS]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESERVAS](
	[numero] [int] NOT NULL,
	[cantVisitantes] [int] NULL,
	[fecha_reserva] [datetime] NULL,
	[fecha_creacion] [datetime] NULL,
	[duracion] [int] NULL,
	[usuario] [varchar](50) NULL,
	[id_escuela] [int] NULL,
	[id_sede] [int] NULL,
	[id_tipo_visita] [int] NULL,
 CONSTRAINT [PK_RESERVAS] PRIMARY KEY CLUSTERED 
(
	[numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SEDES]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SEDES](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[cantMaxVisit] [int] NULL,
	[cantMaxGuia] [int] NULL,
 CONSTRAINT [sedes_id_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SESIONES]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SESIONES](
	[fechaHoraInicio] [datetime] NOT NULL,
	[fechaHoraFin] [datetime] NULL,
	[usuario] [varchar](50) NULL,
 CONSTRAINT [sesiones_fecha_pk] PRIMARY KEY CLUSTERED 
(
	[fechaHoraInicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOS_EXPOSICION]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOS_EXPOSICION](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_TIPOS_EXPOSICION] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOS_VISITA]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOS_VISITA](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[descripcion] [varchar](100) NULL,
 CONSTRAINT [PK_TIPOS_VISITAS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIOS]    Script Date: 27/10/2021 09:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIOS](
	[nombre] [varchar](50) NOT NULL,
	[contraseña] [varchar](50) NULL,
	[dni_empleado] [int] NULL,
 CONSTRAINT [PK_USUARIOS] PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (1, 38876123, CAST(N'2021-05-01T11:00:00.000' AS DateTime), CAST(N'2021-05-01T12:28:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (1, 39255164, CAST(N'2021-05-01T11:00:00.000' AS DateTime), CAST(N'2021-05-01T12:28:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (2, 43231949, CAST(N'2021-05-04T17:00:00.000' AS DateTime), CAST(N'2021-05-04T18:28:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (2, 43277949, CAST(N'2021-05-04T17:00:00.000' AS DateTime), CAST(N'2021-05-04T18:28:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 23455089, CAST(N'2021-06-10T12:00:00.000' AS DateTime), CAST(N'2021-06-10T13:17:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 38876123, CAST(N'2021-06-10T12:00:00.000' AS DateTime), CAST(N'2021-06-10T13:17:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 39255164, CAST(N'2021-06-10T12:00:00.000' AS DateTime), CAST(N'2021-06-10T13:17:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 40251648, CAST(N'2021-06-10T12:00:00.000' AS DateTime), CAST(N'2021-06-10T13:17:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 42554498, CAST(N'2021-06-10T12:00:00.000' AS DateTime), CAST(N'2021-06-10T13:17:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 43231949, CAST(N'2021-06-10T12:00:00.000' AS DateTime), CAST(N'2021-06-10T13:17:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 43277949, CAST(N'2021-06-10T12:00:00.000' AS DateTime), CAST(N'2021-06-10T13:17:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (4, 23455089, CAST(N'2021-06-09T15:00:00.000' AS DateTime), CAST(N'2021-06-09T17:00:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (4, 40251648, CAST(N'2021-06-09T15:00:00.000' AS DateTime), CAST(N'2021-06-09T17:00:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (4, 42554498, CAST(N'2021-06-09T15:00:00.000' AS DateTime), CAST(N'2021-06-09T17:00:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (4, 43231949, CAST(N'2021-06-09T15:00:00.000' AS DateTime), CAST(N'2021-06-09T17:00:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (4, 43277949, CAST(N'2021-06-09T15:00:00.000' AS DateTime), CAST(N'2021-06-09T17:00:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 23455089, CAST(N'2021-06-12T12:30:00.000' AS DateTime), CAST(N'2021-06-12T20:30:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 39255164, CAST(N'2021-06-12T12:30:00.000' AS DateTime), CAST(N'2021-06-12T20:30:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 40251648, CAST(N'2021-06-12T12:30:00.000' AS DateTime), CAST(N'2021-06-12T20:30:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 43231949, CAST(N'2021-06-12T12:30:00.000' AS DateTime), CAST(N'2021-06-12T20:30:00.000' AS DateTime))
INSERT [dbo].[ASIGNACION] ([num_reserva], [dni_empleado], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 43277949, CAST(N'2021-06-12T12:30:00.000' AS DateTime), CAST(N'2021-06-12T20:30:00.000' AS DateTime))
GO
INSERT [dbo].[CAMBIOS_ESTADO] ([num_reserva], [id_estado], [FechaHoraInicio], [FechaHoraFin]) VALUES (1, 3, CAST(N'1900-01-01T08:00:00.000' AS DateTime), NULL)
INSERT [dbo].[CAMBIOS_ESTADO] ([num_reserva], [id_estado], [FechaHoraInicio], [FechaHoraFin]) VALUES (2, 3, CAST(N'1900-01-01T10:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[CARGOS] ([id], [nombre]) VALUES (1, N'Director')
INSERT [dbo].[CARGOS] ([id], [nombre]) VALUES (2, N'Guia')
INSERT [dbo].[CARGOS] ([id], [nombre]) VALUES (3, N'Responsable de Registracion')
INSERT [dbo].[CARGOS] ([id], [nombre]) VALUES (4, N'Responsable de Infraestructura')
INSERT [dbo].[CARGOS] ([id], [nombre]) VALUES (5, N'Responsable de Obras')
INSERT [dbo].[CARGOS] ([id], [nombre]) VALUES (6, N'Responsable de Visitas')
GO
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (1, 1, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (1, 2, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (2, 3, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (2, 4, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (3, 5, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (3, 6, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (4, 7, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (4, 8, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (4, 9, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (4, 10, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (4, 11, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (5, 1, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (5, 12, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (5, 13, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (5, 14, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (5, 15, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (5, 16, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (6, 2, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (6, 3, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (6, 4, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (6, 5, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (6, 6, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (7, 7, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (7, 8, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (7, 9, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (8, 10, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (9, 11, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (9, 12, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (9, 13, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (9, 14, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (9, 15, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (10, 2, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (10, 3, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (11, 8, NULL)
INSERT [dbo].[DETALLES_EXP] ([id_exposicion], [id_obra], [lugar_asignado]) VALUES (11, 9, NULL)
GO
INSERT [dbo].[DIAS_SEMANA] ([id], [nombre]) VALUES (1, N'Lunes')
INSERT [dbo].[DIAS_SEMANA] ([id], [nombre]) VALUES (2, N'Martes')
INSERT [dbo].[DIAS_SEMANA] ([id], [nombre]) VALUES (3, N'Miercoles')
INSERT [dbo].[DIAS_SEMANA] ([id], [nombre]) VALUES (4, N'Jueves')
INSERT [dbo].[DIAS_SEMANA] ([id], [nombre]) VALUES (5, N'Viernes')
INSERT [dbo].[DIAS_SEMANA] ([id], [nombre]) VALUES (6, N'Sabado')
INSERT [dbo].[DIAS_SEMANA] ([id], [nombre]) VALUES (7, N'Domingo')
GO
INSERT [dbo].[EMPLEADOS] ([dni], [apellido], [nombre], [cargo], [mail], [id_sede]) VALUES (23455089, N'Gomez', N'Juan', 2, N'juanGomez@gmail.com', 1)
INSERT [dbo].[EMPLEADOS] ([dni], [apellido], [nombre], [cargo], [mail], [id_sede]) VALUES (38876123, N'Manavella', N'Julian', 2, N'julianManavella@gmail.com', 2)
INSERT [dbo].[EMPLEADOS] ([dni], [apellido], [nombre], [cargo], [mail], [id_sede]) VALUES (39255164, N'Rodriguez', N'Carlos', 2, N'rodri14car@gmail.com', 1)
INSERT [dbo].[EMPLEADOS] ([dni], [apellido], [nombre], [cargo], [mail], [id_sede]) VALUES (40251648, N'Giantomassi', N'Enrique', 2, N'Enri123@gmail.com', 3)
INSERT [dbo].[EMPLEADOS] ([dni], [apellido], [nombre], [cargo], [mail], [id_sede]) VALUES (41345987, N'Rodriguez', N'Facundo', 1, N'facundoRodriguez@gmail.com', 1)
INSERT [dbo].[EMPLEADOS] ([dni], [apellido], [nombre], [cargo], [mail], [id_sede]) VALUES (42515648, N'Anselmi', N'Rosario', 5, N'rosario.an@gmail.com', 3)
INSERT [dbo].[EMPLEADOS] ([dni], [apellido], [nombre], [cargo], [mail], [id_sede]) VALUES (42554498, N'Avila', N'Pilar', 2, N'pilar_avila01@hotmail.com', 2)
INSERT [dbo].[EMPLEADOS] ([dni], [apellido], [nombre], [cargo], [mail], [id_sede]) VALUES (43231949, N'Fernandez', N'Rodrigo', 2, N'Frodrigo@hotmail.com', 3)
INSERT [dbo].[EMPLEADOS] ([dni], [apellido], [nombre], [cargo], [mail], [id_sede]) VALUES (43277949, N'Perez', N'Hernan', 2, N'HERNANperez03@gmail.com', 1)
GO
INSERT [dbo].[ESCUELAS] ([id], [nombre]) VALUES (1, N'Manuel Lucero')
INSERT [dbo].[ESCUELAS] ([id], [nombre]) VALUES (2, N'San Jorge')
INSERT [dbo].[ESCUELAS] ([id], [nombre]) VALUES (3, N'Sagrada Familia')
INSERT [dbo].[ESCUELAS] ([id], [nombre]) VALUES (4, N'MONJAS AZULES')
INSERT [dbo].[ESCUELAS] ([id], [nombre]) VALUES (5, N'25 de mayo')
INSERT [dbo].[ESCUELAS] ([id], [nombre]) VALUES (6, N'Hardvard')
INSERT [dbo].[ESCUELAS] ([id], [nombre]) VALUES (7, N'Escolapias')
INSERT [dbo].[ESCUELAS] ([id], [nombre]) VALUES (8, N'Adoratrices')
INSERT [dbo].[ESCUELAS] ([id], [nombre]) VALUES (9, N'Santo Tomas')
GO
INSERT [dbo].[ESTADOS] ([id], [nombre]) VALUES (1, N'Confirmado')
INSERT [dbo].[ESTADOS] ([id], [nombre]) VALUES (2, N'Cancelado')
INSERT [dbo].[ESTADOS] ([id], [nombre]) VALUES (3, N'Pendiente Confirmacion')
INSERT [dbo].[ESTADOS] ([id], [nombre]) VALUES (4, N'Anulado')
GO
INSERT [dbo].[EXPOSICION] ([id], [nombre], [fechaInicio], [fechaFin], [id_tipo_exp], [id_publico], [id_sede], [horaApertura], [horaCierre]) VALUES (1, N'Picasso', CAST(N'2019-05-10T00:00:00.000' AS DateTime), CAST(N'2019-05-15T00:00:00.000' AS DateTime), 2, 1, 3, CAST(N'08:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[EXPOSICION] ([id], [nombre], [fechaInicio], [fechaFin], [id_tipo_exp], [id_publico], [id_sede], [horaApertura], [horaCierre]) VALUES (2, N'Espejos', CAST(N'2021-03-12T00:00:00.000' AS DateTime), CAST(N'2021-02-15T00:00:00.000' AS DateTime), 2, 2, 2, CAST(N'08:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[EXPOSICION] ([id], [nombre], [fechaInicio], [fechaFin], [id_tipo_exp], [id_publico], [id_sede], [horaApertura], [horaCierre]) VALUES (3, N'Difucion de Ideas', CAST(N'2020-05-13T00:00:00.000' AS DateTime), CAST(N'2020-03-19T00:00:00.000' AS DateTime), 1, 3, 3, CAST(N'08:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[EXPOSICION] ([id], [nombre], [fechaInicio], [fechaFin], [id_tipo_exp], [id_publico], [id_sede], [horaApertura], [horaCierre]) VALUES (4, N'Vintage', CAST(N'2021-06-18T00:00:00.000' AS DateTime), CAST(N'2021-06-25T00:00:00.000' AS DateTime), 2, 5, 1, CAST(N'08:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[EXPOSICION] ([id], [nombre], [fechaInicio], [fechaFin], [id_tipo_exp], [id_publico], [id_sede], [horaApertura], [horaCierre]) VALUES (5, N'Stone Heroes', CAST(N'2021-05-13T00:00:00.000' AS DateTime), CAST(N'2021-07-28T00:00:00.000' AS DateTime), 2, 4, 2, CAST(N'08:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[EXPOSICION] ([id], [nombre], [fechaInicio], [fechaFin], [id_tipo_exp], [id_publico], [id_sede], [horaApertura], [horaCierre]) VALUES (6, N'Drawing from Life', CAST(N'2021-05-10T00:00:00.000' AS DateTime), CAST(N'2022-05-15T00:00:00.000' AS DateTime), 2, 6, 3, CAST(N'08:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[EXPOSICION] ([id], [nombre], [fechaInicio], [fechaFin], [id_tipo_exp], [id_publico], [id_sede], [horaApertura], [horaCierre]) VALUES (7, N'Pintores Locales', CAST(N'2021-01-07T00:00:00.000' AS DateTime), CAST(N'2021-09-19T00:00:00.000' AS DateTime), 1, 1, 1, CAST(N'08:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[EXPOSICION] ([id], [nombre], [fechaInicio], [fechaFin], [id_tipo_exp], [id_publico], [id_sede], [horaApertura], [horaCierre]) VALUES (8, N'Obras de Berlin', CAST(N'2019-02-19T00:00:00.000' AS DateTime), CAST(N'2019-05-03T00:00:00.000' AS DateTime), 1, 2, 2, CAST(N'08:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[EXPOSICION] ([id], [nombre], [fechaInicio], [fechaFin], [id_tipo_exp], [id_publico], [id_sede], [horaApertura], [horaCierre]) VALUES (9, N'Exposición Híbrida', CAST(N'2021-06-05T00:00:00.000' AS DateTime), CAST(N'2021-11-30T00:00:00.000' AS DateTime), 2, 3, 3, CAST(N'08:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[EXPOSICION] ([id], [nombre], [fechaInicio], [fechaFin], [id_tipo_exp], [id_publico], [id_sede], [horaApertura], [horaCierre]) VALUES (10, N'70s', CAST(N'2021-06-01T00:00:00.000' AS DateTime), CAST(N'2021-11-20T00:00:00.000' AS DateTime), 2, 3, 3, CAST(N'10:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[EXPOSICION] ([id], [nombre], [fechaInicio], [fechaFin], [id_tipo_exp], [id_publico], [id_sede], [horaApertura], [horaCierre]) VALUES (11, N'80s', CAST(N'2021-06-03T00:00:00.000' AS DateTime), CAST(N'2021-08-03T00:00:00.000' AS DateTime), 1, 5, 3, CAST(N'10:00:00' AS Time), CAST(N'08:00:00' AS Time))
GO
INSERT [dbo].[EXPOXRESER] ([numero_reserva], [id_exposicion]) VALUES (1, 1)
INSERT [dbo].[EXPOXRESER] ([numero_reserva], [id_exposicion]) VALUES (2, 6)
GO
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (23455089, 1, CAST(N'12:00:00' AS Time), CAST(N'23:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (23455089, 3, CAST(N'12:00:00' AS Time), CAST(N'23:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (23455089, 4, CAST(N'12:00:00' AS Time), CAST(N'23:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (23455089, 6, CAST(N'12:00:00' AS Time), CAST(N'23:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (23455089, 7, CAST(N'12:00:00' AS Time), CAST(N'23:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (38876123, 4, CAST(N'09:00:00' AS Time), CAST(N'16:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (38876123, 5, CAST(N'09:00:00' AS Time), CAST(N'16:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (38876123, 6, CAST(N'09:00:00' AS Time), CAST(N'16:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (39255164, 3, CAST(N'14:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (39255164, 4, CAST(N'08:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (39255164, 6, CAST(N'08:00:00' AS Time), CAST(N'21:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (40251648, 1, CAST(N'14:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (40251648, 2, CAST(N'14:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (40251648, 3, CAST(N'14:00:00' AS Time), CAST(N'21:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (40251648, 4, CAST(N'08:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (40251648, 6, CAST(N'08:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (41345987, 2, CAST(N'08:00:00' AS Time), CAST(N'15:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (41345987, 3, CAST(N'08:00:00' AS Time), CAST(N'15:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (41345987, 4, CAST(N'08:00:00' AS Time), CAST(N'15:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (42515648, 1, CAST(N'08:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (42515648, 2, CAST(N'08:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (42515648, 3, CAST(N'08:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (42554498, 1, CAST(N'08:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (42554498, 3, CAST(N'08:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (42554498, 3, CAST(N'14:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (42554498, 4, CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (42554498, 5, CAST(N'08:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (43231949, 2, CAST(N'16:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (43231949, 3, CAST(N'14:30:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (43231949, 4, CAST(N'08:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (43231949, 6, CAST(N'16:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (43277949, 2, CAST(N'12:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (43277949, 3, CAST(N'12:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (43277949, 4, CAST(N'12:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[HORARIOS_EMP] ([dni_empleado], [id_dia_semana], [hora_inicio], [hora_fin]) VALUES (43277949, 6, CAST(N'12:00:00' AS Time), CAST(N'20:30:00' AS Time))
GO
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (1, N'Gioconda', 30, 25, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (2, N'Guernica', 25, 20, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (3, N'La ultima cena', 15, 10, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (4, N'La persistencia', 20, 15, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (5, N'Gioconda', 25, 20, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (6, N'Romeo y Julieta', 75, 50, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (7, N'La Celestina', 35, 20, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (8, N'La Gioconda', 75, 63, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (9, N'La noche estrellada', 75, 63, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (10, N' El Grito', 42, 35, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (11, N'Hamlet', 60, 50, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (12, N'Vincent Willem Van Gogh', 15, 7, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (13, N'Pinturas explotadas', 21, 18, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (14, N'Imyours', 16, 11, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (15, N'loveintheair', 29, 25, NULL)
INSERT [dbo].[OBRAS] ([id], [nombre], [duracion_ext], [duracion_res], [descripcion]) VALUES (16, N'baloons', 20, 14, NULL)
GO
INSERT [dbo].[PUBLICOS_DESTINO] ([id_publico], [nombre], [descrip]) VALUES (1, N'niños', NULL)
INSERT [dbo].[PUBLICOS_DESTINO] ([id_publico], [nombre], [descrip]) VALUES (2, N'estudiantes de arte', NULL)
INSERT [dbo].[PUBLICOS_DESTINO] ([id_publico], [nombre], [descrip]) VALUES (3, N'publico general', NULL)
INSERT [dbo].[PUBLICOS_DESTINO] ([id_publico], [nombre], [descrip]) VALUES (4, N'niños y publico general', NULL)
INSERT [dbo].[PUBLICOS_DESTINO] ([id_publico], [nombre], [descrip]) VALUES (5, N'niños y estudiantes de arte', NULL)
INSERT [dbo].[PUBLICOS_DESTINO] ([id_publico], [nombre], [descrip]) VALUES (6, N'estudiantes de arte y publico general', NULL)
GO
INSERT [dbo].[RESERVAS] ([numero], [cantVisitantes], [fecha_reserva], [fecha_creacion], [duracion], [usuario], [id_escuela], [id_sede], [id_tipo_visita]) VALUES (1, 10, CAST(N'2021-05-01T11:00:00.000' AS DateTime), CAST(N'2021-05-01T00:00:00.000' AS DateTime), 88, N'julyMana', 4, 3, 1)
INSERT [dbo].[RESERVAS] ([numero], [cantVisitantes], [fecha_reserva], [fecha_creacion], [duracion], [usuario], [id_escuela], [id_sede], [id_tipo_visita]) VALUES (2, 7, CAST(N'2021-05-04T17:00:00.000' AS DateTime), CAST(N'2021-05-04T00:00:00.000' AS DateTime), 88, N'pepito33', 5, 3, 1)
INSERT [dbo].[RESERVAS] ([numero], [cantVisitantes], [fecha_reserva], [fecha_creacion], [duracion], [usuario], [id_escuela], [id_sede], [id_tipo_visita]) VALUES (3, 40, CAST(N'2021-06-10T12:00:00.000' AS DateTime), CAST(N'2021-05-27T00:00:00.000' AS DateTime), 77, N'ElmasRapido', 2, 3, 2)
INSERT [dbo].[RESERVAS] ([numero], [cantVisitantes], [fecha_reserva], [fecha_creacion], [duracion], [usuario], [id_escuela], [id_sede], [id_tipo_visita]) VALUES (4, 30, CAST(N'2021-06-09T15:00:00.000' AS DateTime), CAST(N'2021-05-29T00:00:00.000' AS DateTime), 120, N'gianto123', 3, 3, 1)
INSERT [dbo].[RESERVAS] ([numero], [cantVisitantes], [fecha_reserva], [fecha_creacion], [duracion], [usuario], [id_escuela], [id_sede], [id_tipo_visita]) VALUES (5, 25, CAST(N'2021-06-12T12:30:00.000' AS DateTime), CAST(N'2021-05-28T00:00:00.000' AS DateTime), 480, N'JuanGo', 1, 3, 2)
GO
INSERT [dbo].[SEDES] ([id], [nombre], [cantMaxVisit], [cantMaxGuia]) VALUES (1, N'Carafa', 150, 3)
INSERT [dbo].[SEDES] ([id], [nombre], [cantMaxVisit], [cantMaxGuia]) VALUES (2, N'Grecia', 200, 4)
INSERT [dbo].[SEDES] ([id], [nombre], [cantMaxVisit], [cantMaxGuia]) VALUES (3, N'San Martin', 300, 10)
GO
INSERT [dbo].[SESIONES] ([fechaHoraInicio], [fechaHoraFin], [usuario]) VALUES (CAST(N'2021-06-11T08:00:00.000' AS DateTime), CAST(N'2021-06-11T14:00:00.000' AS DateTime), N'rodri5454')
INSERT [dbo].[SESIONES] ([fechaHoraInicio], [fechaHoraFin], [usuario]) VALUES (CAST(N'2021-06-12T09:00:00.000' AS DateTime), CAST(N'2021-06-12T16:00:00.000' AS DateTime), N'julyMana')
INSERT [dbo].[SESIONES] ([fechaHoraInicio], [fechaHoraFin], [usuario]) VALUES (CAST(N'2021-06-12T16:00:00.000' AS DateTime), CAST(N'2021-06-12T22:00:00.000' AS DateTime), N'pepito33')
INSERT [dbo].[SESIONES] ([fechaHoraInicio], [fechaHoraFin], [usuario]) VALUES (CAST(N'2021-06-15T08:00:00.000' AS DateTime), CAST(N'2021-06-15T15:00:00.000' AS DateTime), N'facuRo')
INSERT [dbo].[SESIONES] ([fechaHoraInicio], [fechaHoraFin], [usuario]) VALUES (CAST(N'2021-06-15T16:00:00.000' AS DateTime), CAST(N'2021-06-15T22:00:00.000' AS DateTime), N'pepito33')
INSERT [dbo].[SESIONES] ([fechaHoraInicio], [fechaHoraFin], [usuario]) VALUES (CAST(N'2021-06-17T09:00:00.000' AS DateTime), CAST(N'2021-06-17T16:00:00.000' AS DateTime), N'julyMana')
INSERT [dbo].[SESIONES] ([fechaHoraInicio], [fechaHoraFin], [usuario]) VALUES (CAST(N'2021-06-17T16:00:00.000' AS DateTime), CAST(N'2021-06-17T22:00:00.000' AS DateTime), N'pepito33')
GO
INSERT [dbo].[TIPOS_EXPOSICION] ([id], [nombre], [descripcion]) VALUES (1, N'Permanentes', NULL)
INSERT [dbo].[TIPOS_EXPOSICION] ([id], [nombre], [descripcion]) VALUES (2, N'Temporales', NULL)
GO
INSERT [dbo].[TIPOS_VISITA] ([id], [nombre], [descripcion]) VALUES (1, N'completa', NULL)
INSERT [dbo].[TIPOS_VISITA] ([id], [nombre], [descripcion]) VALUES (2, N'porExposicion', NULL)
GO
INSERT [dbo].[USUARIOS] ([nombre], [contraseña], [dni_empleado]) VALUES (N'Anse123', N'1542papa', 42515648)
INSERT [dbo].[USUARIOS] ([nombre], [contraseña], [dni_empleado]) VALUES (N'ElmasRapido', N'lola5656', 43277949)
INSERT [dbo].[USUARIOS] ([nombre], [contraseña], [dni_empleado]) VALUES (N'facuRo', N'facundo12343', 41345987)
INSERT [dbo].[USUARIOS] ([nombre], [contraseña], [dni_empleado]) VALUES (N'gianto123', N'154papa', 40251648)
INSERT [dbo].[USUARIOS] ([nombre], [contraseña], [dni_empleado]) VALUES (N'JJrodriguez', N'258852', 42554498)
INSERT [dbo].[USUARIOS] ([nombre], [contraseña], [dni_empleado]) VALUES (N'JuanGo', N'juango1', 23455089)
INSERT [dbo].[USUARIOS] ([nombre], [contraseña], [dni_empleado]) VALUES (N'julyMana', N'manavella12', 38876123)
INSERT [dbo].[USUARIOS] ([nombre], [contraseña], [dni_empleado]) VALUES (N'pepito33', N'lavoz489', 43231949)
INSERT [dbo].[USUARIOS] ([nombre], [contraseña], [dni_empleado]) VALUES (N'rodri5454', N'15482roro', 39255164)
GO
ALTER TABLE [dbo].[ASIGNACION]  WITH CHECK ADD  CONSTRAINT [asignacion_dniempleado_fk] FOREIGN KEY([dni_empleado])
REFERENCES [dbo].[EMPLEADOS] ([dni])
GO
ALTER TABLE [dbo].[ASIGNACION] CHECK CONSTRAINT [asignacion_dniempleado_fk]
GO
ALTER TABLE [dbo].[ASIGNACION]  WITH CHECK ADD  CONSTRAINT [asignacion_numReserva_fk] FOREIGN KEY([num_reserva])
REFERENCES [dbo].[RESERVAS] ([numero])
GO
ALTER TABLE [dbo].[ASIGNACION] CHECK CONSTRAINT [asignacion_numReserva_fk]
GO
ALTER TABLE [dbo].[CAMBIOS_ESTADO]  WITH CHECK ADD  CONSTRAINT [cambios_estadoID_fk] FOREIGN KEY([id_estado])
REFERENCES [dbo].[ESTADOS] ([id])
GO
ALTER TABLE [dbo].[CAMBIOS_ESTADO] CHECK CONSTRAINT [cambios_estadoID_fk]
GO
ALTER TABLE [dbo].[CAMBIOS_ESTADO]  WITH CHECK ADD  CONSTRAINT [cambios_num_fk] FOREIGN KEY([num_reserva])
REFERENCES [dbo].[RESERVAS] ([numero])
GO
ALTER TABLE [dbo].[CAMBIOS_ESTADO] CHECK CONSTRAINT [cambios_num_fk]
GO
ALTER TABLE [dbo].[DETALLES_EXP]  WITH CHECK ADD  CONSTRAINT [detalle_IDexposicion_fk] FOREIGN KEY([id_exposicion])
REFERENCES [dbo].[EXPOSICION] ([id])
GO
ALTER TABLE [dbo].[DETALLES_EXP] CHECK CONSTRAINT [detalle_IDexposicion_fk]
GO
ALTER TABLE [dbo].[DETALLES_EXP]  WITH CHECK ADD  CONSTRAINT [detalle_IDobra_fk] FOREIGN KEY([id_obra])
REFERENCES [dbo].[OBRAS] ([id])
GO
ALTER TABLE [dbo].[DETALLES_EXP] CHECK CONSTRAINT [detalle_IDobra_fk]
GO
ALTER TABLE [dbo].[EMPLEADOS]  WITH CHECK ADD  CONSTRAINT [empleados_cargo_fk] FOREIGN KEY([cargo])
REFERENCES [dbo].[CARGOS] ([id])
GO
ALTER TABLE [dbo].[EMPLEADOS] CHECK CONSTRAINT [empleados_cargo_fk]
GO
ALTER TABLE [dbo].[EMPLEADOS]  WITH CHECK ADD  CONSTRAINT [empleados_sede_fk] FOREIGN KEY([id_sede])
REFERENCES [dbo].[SEDES] ([id])
GO
ALTER TABLE [dbo].[EMPLEADOS] CHECK CONSTRAINT [empleados_sede_fk]
GO
ALTER TABLE [dbo].[EXPOSICION]  WITH CHECK ADD  CONSTRAINT [exposicion_idPublico_fk] FOREIGN KEY([id_publico])
REFERENCES [dbo].[PUBLICOS_DESTINO] ([id_publico])
GO
ALTER TABLE [dbo].[EXPOSICION] CHECK CONSTRAINT [exposicion_idPublico_fk]
GO
ALTER TABLE [dbo].[EXPOSICION]  WITH CHECK ADD  CONSTRAINT [exposicion_IDsede_fk] FOREIGN KEY([id_sede])
REFERENCES [dbo].[SEDES] ([id])
GO
ALTER TABLE [dbo].[EXPOSICION] CHECK CONSTRAINT [exposicion_IDsede_fk]
GO
ALTER TABLE [dbo].[EXPOSICION]  WITH CHECK ADD  CONSTRAINT [exposicion_idTipoEXP_fk] FOREIGN KEY([id_tipo_exp])
REFERENCES [dbo].[TIPOS_EXPOSICION] ([id])
GO
ALTER TABLE [dbo].[EXPOSICION] CHECK CONSTRAINT [exposicion_idTipoEXP_fk]
GO
ALTER TABLE [dbo].[EXPOXRESER]  WITH CHECK ADD  CONSTRAINT [expoXReserva_idEx_fk] FOREIGN KEY([id_exposicion])
REFERENCES [dbo].[EXPOSICION] ([id])
GO
ALTER TABLE [dbo].[EXPOXRESER] CHECK CONSTRAINT [expoXReserva_idEx_fk]
GO
ALTER TABLE [dbo].[EXPOXRESER]  WITH CHECK ADD  CONSTRAINT [expoXReserva_numR_fk] FOREIGN KEY([numero_reserva])
REFERENCES [dbo].[RESERVAS] ([numero])
GO
ALTER TABLE [dbo].[EXPOXRESER] CHECK CONSTRAINT [expoXReserva_numR_fk]
GO
ALTER TABLE [dbo].[HORARIOS_EMP]  WITH CHECK ADD  CONSTRAINT [horarios_dniEmpleado_fk] FOREIGN KEY([dni_empleado])
REFERENCES [dbo].[EMPLEADOS] ([dni])
GO
ALTER TABLE [dbo].[HORARIOS_EMP] CHECK CONSTRAINT [horarios_dniEmpleado_fk]
GO
ALTER TABLE [dbo].[HORARIOS_EMP]  WITH CHECK ADD  CONSTRAINT [horarios_idDiaSemana_fk] FOREIGN KEY([id_dia_semana])
REFERENCES [dbo].[DIAS_SEMANA] ([id])
GO
ALTER TABLE [dbo].[HORARIOS_EMP] CHECK CONSTRAINT [horarios_idDiaSemana_fk]
GO
ALTER TABLE [dbo].[RESERVAS]  WITH CHECK ADD  CONSTRAINT [reservas_idEscuela_fk] FOREIGN KEY([id_escuela])
REFERENCES [dbo].[ESCUELAS] ([id])
GO
ALTER TABLE [dbo].[RESERVAS] CHECK CONSTRAINT [reservas_idEscuela_fk]
GO
ALTER TABLE [dbo].[RESERVAS]  WITH CHECK ADD  CONSTRAINT [reservas_IDsede_fk] FOREIGN KEY([id_sede])
REFERENCES [dbo].[SEDES] ([id])
GO
ALTER TABLE [dbo].[RESERVAS] CHECK CONSTRAINT [reservas_IDsede_fk]
GO
ALTER TABLE [dbo].[RESERVAS]  WITH CHECK ADD  CONSTRAINT [reservas_IDtipoVisita_fk] FOREIGN KEY([id_tipo_visita])
REFERENCES [dbo].[TIPOS_VISITA] ([id])
GO
ALTER TABLE [dbo].[RESERVAS] CHECK CONSTRAINT [reservas_IDtipoVisita_fk]
GO
ALTER TABLE [dbo].[SESIONES]  WITH CHECK ADD  CONSTRAINT [sesion_usuario_fk] FOREIGN KEY([usuario])
REFERENCES [dbo].[USUARIOS] ([nombre])
GO
ALTER TABLE [dbo].[SESIONES] CHECK CONSTRAINT [sesion_usuario_fk]
GO
ALTER TABLE [dbo].[USUARIOS]  WITH CHECK ADD  CONSTRAINT [usuarios_dniEmpleado_fk] FOREIGN KEY([dni_empleado])
REFERENCES [dbo].[EMPLEADOS] ([dni])
GO
ALTER TABLE [dbo].[USUARIOS] CHECK CONSTRAINT [usuarios_dniEmpleado_fk]
GO
USE [master]
GO
ALTER DATABASE [PPAI] SET  READ_WRITE 
GO
