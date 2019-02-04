create table TIPO_ACCIDENTE (
   ID_TIPO              int                  not null identity,
   CODIGO               varchar(25)          null,
   DESCRIPCION          varchar(50)          null,
   constraint PK_TIPO_ACCIDENTE primary key nonclustered (ID_TIPO)
)
go

create table ACCIDENTE (
   ID_ACCIDENTE         int                  not null identity,
   ID_TIPO              int                  null,-
   FECHA                datetime             null,
   DETALLE              varchar(500)         null,
   LUGAR                varchar(150)         null,
   DETALLE_EMPLEADO     varchar(500)         null,
   constraint PK_ACCIDENTE primary key nonclustered (ID_ACCIDENTE),
   constraint FK_ACCIDENT_RELATIONS_TIPO_ACC foreign key (ID_TIPO)
      references TIPO_ACCIDENTE (ID_TIPO)
)
go

create table PERSONA (
   ID_PERSONA           int                  not null identity,
   NOMBRES              varchar(50)          null,
   APELLIDOS            varchar(100)         null,
   TELEFONO             varchar(25)          null,
   DIRECCION            varchar(200)         null,
   EMAIL                varchar(25)          null,
   SEXO                 char(2)              null,
   NACIMIENTO           datetime             null,
   CI                   varchar(15)          null,
   NACIONALIDAD         varchar(25)          null,
   constraint PK_PERSONA primary key nonclustered (ID_PERSONA)
)
go

create table EMPRESA (
   ID_EMPRESA           int                  not null identity,
   NOMBRE               varchar(25)          null,
   NIT                  varchar(30)          null,
   PROPIETARIO          varchar(50)          null,
   RUT                  int                  null,
   TELEFONO             varchar(15)          null,
   constraint PK_EMPRESA primary key nonclustered (ID_EMPRESA)
)
go

create table OBRA (
   ID_OBRA              int                  not null identity,
   ID_EMPRESA           int                  null,
   NOMBRE               varchar(50)          null,
   TELEFONO             varchar(10)          null,
   DIRECCION            varchar(50)          null,
   constraint PK_OBRA primary key nonclustered (ID_OBRA),
   constraint FK_OBRA_RELATIONS_EMPRESA foreign key (ID_EMPRESA)
      references EMPRESA (ID_EMPRESA)
)
go

create table SECCION (
   ID_SECCION           int                  not null identity,
   ID_OBRA              int                  null,
   NOMBRE               varchar(25)          null,
   UBICACION            varchar(50)          null,
   constraint PK_SECCION primary key nonclustered (ID_SECCION),
   constraint FK_SECCION_RELATIONS_OBRA foreign key (ID_OBRA)
      references OBRA (ID_OBRA)
)
go

create table EMPLEADO (
   ID_EMPLEADO          int                  not null identity,
   ID_PERSONA           int                  not null,
   ID_SECCION           int                  null,
   CARGO                varchar(25)          null,
   TITULO               varchar(25)          null,
   FECHA_CONTRATACION   datetime             null,
   ESTADO               char(1)              null,
   constraint PK_EMPLEADO primary key nonclustered (ID_EMPLEADO),
   constraint FK_EMPLEADO_RELATIONS_PERSONA foreign key (ID_PERSONA)
      references PERSONA (ID_PERSONA),
   constraint FK_EMPLEADO_RELATIONS_SECCION foreign key (ID_SECCION)
      references SECCION (ID_SECCION)	  
)
go

create table ACCIDENTES_EMPLEADO (
   ID_ACCIDENTE         int                  not null,
   ID_EMPLEADO          int                  not null,
   constraint PK_ACCIDENTES_EMPLEADO primary key nonclustered (ID_ACCIDENTE, ID_EMPLEADO),
   constraint FK_ACCIDENT_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO),
   constraint FK_ACCIDENT_RELATIONS_ACCIDENT foreign key (ID_ACCIDENTE)
      references ACCIDENTE (ID_ACCIDENTE)  
)
go

create table TIPO_ARTEFACTO (
   ID_TIPO              int                  not null identity,
   NOMBRE               varchar(25)          null,
   DESCRIPCION          varchar(50)          null,
   constraint PK_TIPO_ARTEFACTO primary key nonclustered (ID_TIPO)
)
go

create table ARTEFACTO (
   ID_ARTEFACTO         int                  not null identity,
   ID_TIPO              int                  null,
   NOMBRE               varchar(50)          null,
   MODELO               varchar(50)          null,
   INGRESO              datetime             null,
   ESTADO               varchar(15)          null,
   CANTIDAD             int                  null,
   constraint PK_ARTEFACTO primary key nonclustered (ID_ARTEFACTO),
   constraint FK_ARTEFACT_RELATIONS_TIPO_ART foreign key (ID_TIPO)
      references TIPO_ARTEFACTO (ID_TIPO)
)
go

create table ESTADO_FISICO_EQUIPO (
   ID_ESTADO_FISICO     int                  not null identity,
   CODIGO_ESTADO        varchar(25)          null,
   DESCRIPCION_ESTADO   varchar(100)         null,
   constraint PK_ESTADO_FISICO_EQUIPO primary key nonclustered (ID_ESTADO_FISICO)
)
go

create table ARTEFACTO_EMPLEADO (
   ID_EMPLEADO          int                  not null,
   ID_ARTEFACTO         int                  not null,
   ID_ESTADO_FISICO     int                  null,
   constraint PK_ARTEFACTO_EMPLEADO primary key nonclustered (ID_EMPLEADO, ID_ARTEFACTO),
   constraint FK_ARTEFACT_RELATIONS_ESTADO_F foreign key (ID_ESTADO_FISICO)
      references ESTADO_FISICO_EQUIPO (ID_ESTADO_FISICO),
   constraint FK_ARTEFACT_RELATIONS_ARTEFACT foreign key (ID_ARTEFACTO)
      references ARTEFACTO (ID_ARTEFACTO),
   constraint FK_ARTEFACT_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)  
)
go

create table MEDIDA_DE_SEGURIDAD (
   ID_MEDIDA_SEGURIDAD  int                  not null identity,
   TITULO               varchar(25)          null,
   DESCRIPCION          varchar(250)         null,
   FECHA_CREACION       datetime             null,
   ENCARGADO            varchar(50)          null,
   TIPO                 varchar(50)          null,
   PATH_DOCUMENTO       varchar(150)         null,
   constraint PK_MEDIDA_DE_SEGURIDAD primary key nonclustered (ID_MEDIDA_SEGURIDAD)
)
go

create table CAPACITACION (
   ID_CAPACITACION      int                  not null identity,
   ID_MEDIDA_SEGURIDAD  int                  null,
   TUTOR                varchar(50)          null,
   FECHA_INICIO         datetime             null,
   FECHA_FIN            datetime             null,
   TITULO               varchar(50)          null,
   DECRIPCION           varchar(250)         null,
   constraint PK_CAPACITACION primary key nonclustered (ID_CAPACITACION),
   constraint FK_CAPACITA_RELATIONS_MEDIDA_D foreign key (ID_MEDIDA_SEGURIDAD)
      references MEDIDA_DE_SEGURIDAD (ID_MEDIDA_SEGURIDAD)
)
go

create table CAPACITACION_EMPLEADO (
   ID_CAPACITACION      int                  not null,
   ID_EMPLEADO          int                  not null,
   constraint PK_CAPACITACION_EMPLEADO primary key nonclustered (ID_CAPACITACION, ID_EMPLEADO),
   constraint FK_CAPACITA_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO),
   constraint FK_CAPACITA_RELATIONS_CAPACITA foreign key (ID_CAPACITACION)
      references CAPACITACION (ID_CAPACITACION)
)
go

create table COSTO (
   ID_COSTO             int                  not null identity,
   ID_ACCIDENTE         int                  null,
   TIPO                 varchar(25)          null,
   IMPORTE              money                null,
   NOTA                 varchar(150)         null,
   constraint PK_COSTO primary key nonclustered (ID_COSTO),
   constraint FK_COSTO_RELATIONS_ACCIDENT foreign key (ID_ACCIDENTE)
      references ACCIDENTE (ID_ACCIDENTE)
)
go

create table ESTRUCTURA_PERSONAL (
   EMP_ID_EMPLEADO      int                  not null,
   ID_EMPLEADO          int                  not null,
   constraint PK_ESTRUCTURA_PERSONAL primary key nonclustered (EMP_ID_EMPLEADO, ID_EMPLEADO),
   constraint FK_ESTRUCTU_RELATIONS_EMPLEAD1 foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO),
   constraint FK_ESTRUCTU_RELATIONS_EMPLEAD2 foreign key (EMP_ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)
)
go

create table HISTORICO_ACCIDENTE (
   ID_HISTORICO_ACCIDENTE int                  not null identity,
   ID_ACCIDENTE         int                  null,
   ID_TIPO              int                  null,
   FECHA                datetime             null,
   DETALLE              varchar(500)         null,
   LUGAR                varchar(150)         null,
   DETALLE_EMPLEADO     varchar(500)         null,
   FECHA_MODIFICACION   datetime             null,
   USUARIO_MODIFICACION int                  null,
   constraint PK_HISTORICO_ACCIDENTE primary key nonclustered (ID_HISTORICO_ACCIDENTE),
   constraint FK_HISTORIC_RELATIONS_ACCIDENT foreign key (ID_ACCIDENTE)
      references ACCIDENTE (ID_ACCIDENTE)
)
go

create table HISTORICO_ARTEFACTO (
   ID_ARTEFACTO         int                  not null,
   ID_MEDIDA_SEGURIDAD  int                  not null,
   constraint PK_HISTORICO_ARTEFACTO primary key nonclustered (ID_ARTEFACTO, ID_MEDIDA_SEGURIDAD),
   constraint FK_HISTORIC_RELATIONS_MEDIDA_D foreign key (ID_MEDIDA_SEGURIDAD)
      references MEDIDA_DE_SEGURIDAD (ID_MEDIDA_SEGURIDAD),
   constraint FK_HISTORIC_RELATIONS_ARTEFACT foreign key (ID_ARTEFACTO)
      references ARTEFACTO (ID_ARTEFACTO)
)

create table HISTORICO_BAJAS (
   ID_HISTORICO_AC      int                  not null identity,
   ID_EMPLEADO          int                  null,
   FECHA_INGRESO        datetime             null,
   FECHA_EGRESO         datetime             null,
   DETALLE              varchar(250)         null,
   constraint PK_HISTORICO_BAJAS primary key nonclustered (ID_HISTORICO_AC),
   constraint FK_HISTORIC_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)
)
go

create table LOGIN (
   ID_LOGIN             int                  not null identity,
   ID_EMPLEADO          int                  null,
   NICK                 varchar(10)          null,
   CONTRASENA           varchar(100)         null,
   ESTADO               char(1)              null,
   constraint PK_LOGIN primary key nonclustered (ID_LOGIN),
   constraint FK_LOGIN_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)
)
go

create table MANTENIMIENTO (
   ID_MANTENIMIENTO     int                  not null identity,
   ID_ARTEFACTO         int                  null,
   FECHA_INICIO         datetime             null,
   FECHA_FIN            datetime             null,
   DETALLE              varchar(250)         null,
   constraint PK_MANTENIMIENTO primary key nonclustered (ID_MANTENIMIENTO),
   constraint FK_MANTENIM_RELATIONS_ARTEFACT foreign key (ID_ARTEFACTO)
      references ARTEFACTO (ID_ARTEFACTO)
)
go



