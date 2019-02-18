

CREATE NONCLUSTERED INDEX NL_EmployeeNameAccidenteId ON historico_accidente(id_accidente);

CREATE NONCLUSTERED INDEX IX_Empleado ON empleado(cargo, estado);

CREATE NONCLUSTERED INDEX IX_detalle_artefacto ON detalle_artefacto(serial, estado);

CREATE NONCLUSTERED INDEX NL_fecha_mantenimiento ON mantenimiento(fecha_fin);

CREATE NONCLUSTERED INDEX IX_artefacto_comun ON artefacto(nombre, modelo, estado);

CREATE NONCLUSTERED INDEX IX_reporte_comun ON reporte(id_tipo, fecha);

CREATE NONCLUSTERED INDEX IX_persona_comun ON persona(nombres, ci, apellidos);