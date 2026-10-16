-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2026-10-11 02:53:19 CLST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE "alerta_control" (
    "id"               NUMBER(19) NOT NULL,
    "regla_control_id" NUMBER(19) NOT NULL,
    "nivel"            VARCHAR2(12) NOT NULL,
    "estado"           VARCHAR2(15) DEFAULT 'ACTIVA',
    "creada_en"        TIMESTAMP DEFAULT systimestamp,
    "valor_disparo"    NUMBER(16, 3),
    "resuelta_en"      TIMESTAMP,
    "resuelta_por_id"  NUMBER(19),
    "motivo_cierre"    CLOB,
    "observaciones"    CLOB
);

ALTER TABLE "alerta_control"
    ADD CONSTRAINT ck_alerta_control_1 CHECK ( "nivel" IN ( 'PROXIMO', 'VENCIDO' ) );

ALTER TABLE "alerta_control"
    ADD CONSTRAINT ck_alerta_control_2 CHECK ( "estado" IN ( 'ACTIVA', 'RESUELTA', 'DESCARTADA' ) );

ALTER TABLE "alerta_control" ADD CONSTRAINT "PK_alerta_control_id" PRIMARY KEY ( "id" );

CREATE TABLE "articulo" (
    "id"           NUMBER(19) NOT NULL,
    "codigo"       VARCHAR2(60) NOT NULL,
    "nombre"       VARCHAR2(200) NOT NULL,
    "descripcion"  CLOB,
    "categoria_id" NUMBER(19) NOT NULL,
    "tipo_id"      NUMBER(19),
    "marca"        VARCHAR2(100),
    "modelo"       VARCHAR2(120),
    "control"      VARCHAR2(20) NOT NULL,
    "activo"       NUMBER(1) DEFAULT 1,
    "creado_en"    TIMESTAMP DEFAULT systimestamp
);

ALTER TABLE "articulo"
    ADD CONSTRAINT ck_articulo_1 CHECK ( "control" IN ( 'CANTIDAD', 'SERIE' ) );

ALTER TABLE "articulo"
    ADD CONSTRAINT ck_articulo_2 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "articulo" ADD CONSTRAINT "PK_articulo_id" PRIMARY KEY ( "id" );

ALTER TABLE "articulo" ADD CONSTRAINT index_1 UNIQUE ( "codigo" );

CREATE TABLE "articulo_variante" (
    "id"              NUMBER(19) NOT NULL,
    "articulo_id"     NUMBER(19) NOT NULL,
    "clave_atributos" VARCHAR2(200) NOT NULL,
    "codigo_variante" VARCHAR2(80),
    "activo"          NUMBER(1) DEFAULT 1
);

ALTER TABLE "articulo_variante"
    ADD CONSTRAINT ck_articulo_variante_1 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "articulo_variante" ADD CONSTRAINT "PK_articulo_variante_id" PRIMARY KEY ( "id" );

ALTER TABLE "articulo_variante" ADD CONSTRAINT index_1v1 UNIQUE ( "codigo_variante" );

ALTER TABLE "articulo_variante" ADD CONSTRAINT "UQ_articulo_variante_articulo_id_clave_atributos" UNIQUE ( "articulo_id",
                                                                                                           "clave_atributos" );

CREATE TABLE "asignacion_equipo" (
    "id"                 NUMBER(19) NOT NULL,
    "compania_id"        NUMBER(19) NOT NULL,
    "bombero_id"         NUMBER(19) NOT NULL,
    "variante_id"        NUMBER(19) NOT NULL,
    "equipo_seriado_id"  NUMBER(19),
    "cantidad_entregada" NUMBER(14) NOT NULL,
    "cantidad_devuelta"  NUMBER(14) DEFAULT 0,
    "estado_salida_id"   NUMBER(19) NOT NULL,
    "entregado_por_id"   NUMBER(19) NOT NULL,
    "fecha_entrega"      TIMESTAMP DEFAULT systimestamp,
    "observaciones"      CLOB
);

ALTER TABLE "asignacion_equipo" ADD CONSTRAINT ck_asignacion_equipo_1 CHECK ( "cantidad_entregada" > 0 );

ALTER TABLE "asignacion_equipo" ADD CONSTRAINT ck_asignacion_equipo_2 CHECK ( "cantidad_devuelta" >= 0 );

ALTER TABLE "asignacion_equipo" ADD CONSTRAINT ck_asignacion_equipo_3 CHECK ( "cantidad_devuelta" <= "cantidad_entregada" );

ALTER TABLE "asignacion_equipo"
    ADD CONSTRAINT ck_asignacion_equipo_4 CHECK ( "equipo_seriado_id" IS NULL
                                                  OR "cantidad_entregada" = 1 );

ALTER TABLE "asignacion_equipo" ADD CONSTRAINT "PK_asignacion_equipo_id" PRIMARY KEY ( "id" );

CREATE TABLE "atributo_def" (
    "id"     NUMBER(19) NOT NULL,
    "codigo" VARCHAR2(50) NOT NULL,
    "nombre" VARCHAR2(120) NOT NULL,
    "activo" NUMBER(1) DEFAULT 1
);

ALTER TABLE "atributo_def"
    ADD CONSTRAINT ck_atributo_def_1 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "atributo_def" ADD CONSTRAINT "PK_atributo_def_id" PRIMARY KEY ( "id" );

ALTER TABLE "atributo_def" ADD CONSTRAINT index_1v2 UNIQUE ( "codigo" );

CREATE TABLE "atributo_opcion" (
    "id"                NUMBER(19) NOT NULL,
    "atributo_id"       NUMBER(19) NOT NULL,
    "valor"             VARCHAR2(120) NOT NULL,
    "valor_normalizado" VARCHAR2(120) NOT NULL,
    "activo"            NUMBER(1) DEFAULT 1
);

ALTER TABLE "atributo_opcion"
    ADD CONSTRAINT ck_atributo_opcion_1 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "atributo_opcion" ADD CONSTRAINT "PK_atributo_opcion_id" PRIMARY KEY ( "id" );

ALTER TABLE "atributo_opcion" ADD CONSTRAINT "UQ_atributo_opcion_atributo_id_valor_normalizado" UNIQUE ( "atributo_id",
                                                                                                         "valor_normalizado" );

CREATE TABLE "auditoria_evento" (
    "id"                   NUMBER(19) NOT NULL,
    "usuario_id"           NUMBER(19),
    "compania_contexto_id" NUMBER(19),
    "entidad"              VARCHAR2(80) NOT NULL,
    "registro_id"          VARCHAR2(80) NOT NULL,
    "accion"               VARCHAR2(50) NOT NULL,
    "fecha_evento"         TIMESTAMP DEFAULT systimestamp,
    "resumen_cambio"       CLOB,
    "referencia_jira"      VARCHAR2(40)
);

ALTER TABLE "auditoria_evento" ADD CONSTRAINT "PK_auditoria_evento_id" PRIMARY KEY ( "id" );

CREATE TABLE "bombero" (
    "id"             NUMBER(19) NOT NULL,
    "compania_id"    NUMBER(19) NOT NULL,
    "codigo_interno" VARCHAR2(50) NOT NULL,
    "nombres"        VARCHAR2(140) NOT NULL,
    "apellidos"      VARCHAR2(140),
    "estado"         VARCHAR2(20) DEFAULT 'ACTIVO'
);

ALTER TABLE "bombero"
    ADD CONSTRAINT ck_bombero_1 CHECK ( "estado" IN ( 'ACTIVO', 'INACTIVO' ) );

ALTER TABLE "bombero" ADD CONSTRAINT "PK_bombero_id" PRIMARY KEY ( "id" );

ALTER TABLE "bombero" ADD CONSTRAINT "UQ_bombero_compania_id_codigo_interno" UNIQUE ( "compania_id",
                                                                                      "codigo_interno" );

CREATE TABLE "catalogo_valor" (
    "id"                     NUMBER(19) NOT NULL,
    "dominio"                VARCHAR2(32) NOT NULL,
    "codigo"                 VARCHAR2(50) NOT NULL,
    "nombre"                 VARCHAR2(150) NOT NULL,
    "permite_disponibilidad" NUMBER(1) DEFAULT 0,
    "activo"                 NUMBER(1) DEFAULT 1
);

ALTER TABLE "catalogo_valor"
    ADD CONSTRAINT ck_catalogo_valor_1 CHECK ( "dominio" IN ( 'CATEGORIA_ARTICULO', 'TIPO_ARTICULO', 'ESTADO_MATERIAL', 'ORIGEN_FINANCIAMIENTO'
    , 'TIPO_UBICACION',
                                                              'TIPO_UNIDAD', 'ESTADO_UNIDAD' ) );

ALTER TABLE "catalogo_valor"
    ADD CONSTRAINT ck_catalogo_valor_2 CHECK ( TRIM("codigo") <> '' );

ALTER TABLE "catalogo_valor"
    ADD CONSTRAINT ck_catalogo_valor_3 CHECK ( TRIM("nombre") <> '' );

ALTER TABLE "catalogo_valor"
    ADD CONSTRAINT ck_catalogo_valor_4 CHECK ( "permite_disponibilidad" IN ( 0, 1 ) );

ALTER TABLE "catalogo_valor"
    ADD CONSTRAINT ck_catalogo_valor_5 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "catalogo_valor"
    ADD CONSTRAINT ck_catalogo_valor_6 CHECK ( "dominio" = 'ESTADO_MATERIAL'
                                               OR "permite_disponibilidad" = 0 );

ALTER TABLE "catalogo_valor" ADD CONSTRAINT "PK_catalogo_valor_id" PRIMARY KEY ( "id" );

ALTER TABLE "catalogo_valor" ADD CONSTRAINT "UQ_catalogo_valor_dominio_codigo" UNIQUE ( "dominio",
                                                                                        "codigo" );

CREATE TABLE "checkin" (
    "id"                     NUMBER(19) NOT NULL,
    "unidad_id"              NUMBER(19) NOT NULL,
    "responsable_usuario_id" NUMBER(19) NOT NULL,
    "fecha_operativa"        DATE NOT NULL,
    "realizado_en"           TIMESTAMP DEFAULT systimestamp,
    "estado_general_id"      NUMBER(19) NOT NULL,
    "fallas_resumen"         CLOB,
    "observaciones"          CLOB,
    "estado_registro"        VARCHAR2(20) DEFAULT 'CONFIRMADO'
);

ALTER TABLE "checkin"
    ADD CONSTRAINT ck_checkin_1 CHECK ( "estado_registro" IN ( 'BORRADOR', 'CONFIRMADO' ) );

ALTER TABLE "checkin" ADD CONSTRAINT "PK_checkin_id" PRIMARY KEY ( "id" );

CREATE TABLE "compania" (
    "id"             NUMBER(19) NOT NULL,
    "codigo"         VARCHAR2(30) NOT NULL,
    "nombre"         VARCHAR2(150) NOT NULL,
    "estado"         VARCHAR2(20) DEFAULT 'ACTIVA',
    "fecha_creacion" TIMESTAMP DEFAULT systimestamp
);

ALTER TABLE "compania"
    ADD CONSTRAINT ck_compania_1 CHECK ( "estado" IN ( 'ACTIVA', 'INACTIVA' ) );

ALTER TABLE "compania" ADD CONSTRAINT "PK_compania_id" PRIMARY KEY ( "id" );

ALTER TABLE "compania" ADD CONSTRAINT index_1v3 UNIQUE ( "codigo" );

CREATE TABLE "componente_unidad" (
    "id"        NUMBER(19) NOT NULL,
    "unidad_id" NUMBER(19) NOT NULL,
    "codigo"    VARCHAR2(50) NOT NULL,
    "nombre"    VARCHAR2(150) NOT NULL,
    "tipo"      VARCHAR2(70) NOT NULL,
    "activo"    NUMBER(1) DEFAULT 1
);

ALTER TABLE "componente_unidad"
    ADD CONSTRAINT ck_componente_unidad_1 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "componente_unidad" ADD CONSTRAINT "PK_componente_unidad_id" PRIMARY KEY ( "id" );

ALTER TABLE "componente_unidad" ADD CONSTRAINT "UQ_componente_unidad_unidad_id_codigo" UNIQUE ( "unidad_id",
                                                                                                "codigo" );

CREATE TABLE "equipo_seriado" (
    "id"                      NUMBER(19) NOT NULL,
    "variante_id"             NUMBER(19) NOT NULL,
    "codigo_interno"          VARCHAR2(80) NOT NULL,
    "numero_serie"            VARCHAR2(150),
    "compania_propietaria_id" NUMBER(19) NOT NULL,
    "compania_tenedora_id"    NUMBER(19) NOT NULL,
    "ubicacion_id"            NUMBER(19),
    "bombero_actual_id"       NUMBER(19),
    "estado_material_id"      NUMBER(19) NOT NULL,
    "origen_id"               NUMBER(19),
    "observaciones"           CLOB,
    "fecha_alta"              TIMESTAMP DEFAULT systimestamp
);

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT ck_equipo_seriado_1 CHECK ( "numero_serie" IS NULL
                                               OR ( TRIM("numero_serie") <> ''
                                                    AND upper(TRIM("numero_serie")) NOT IN ( 'N/A', 'NA', '-' ) ) );

ALTER TABLE "equipo_seriado" ADD CONSTRAINT "PK_equipo_seriado_id" PRIMARY KEY ( "id" );

ALTER TABLE "equipo_seriado" ADD CONSTRAINT index_1v4 UNIQUE ( "codigo_interno" );

CREATE TABLE "estado_unidad_hist" (
    "id"                 NUMBER(19) NOT NULL,
    "unidad_id"          NUMBER(19) NOT NULL,
    "estado_anterior_id" NUMBER(19),
    "estado_nuevo_id"    NUMBER(19) NOT NULL,
    "usuario_id"         NUMBER(19) NOT NULL,
    "fecha_cambio"       TIMESTAMP DEFAULT systimestamp,
    "motivo"             CLOB
);

ALTER TABLE "estado_unidad_hist" ADD CONSTRAINT "PK_estado_unidad_hist_id" PRIMARY KEY ( "id" );

CREATE TABLE "falla_unidad" (
    "id"                NUMBER(19) NOT NULL,
    "unidad_id"         NUMBER(19) NOT NULL,
    "checkin_id"        NUMBER(19),
    "mantenimiento_id"  NUMBER(19),
    "registrado_por_id" NUMBER(19) NOT NULL,
    "reportada_en"      TIMESTAMP DEFAULT systimestamp,
    "descripcion"       CLOB NOT NULL,
    "estado"            VARCHAR2(20) DEFAULT 'ABIERTA',
    "observaciones"     CLOB
);

ALTER TABLE "falla_unidad"
    ADD CONSTRAINT ck_falla_unidad_1 CHECK ( "estado" IN ( 'ABIERTA', 'EN_TRATAMIENTO', 'RESUELTA' ) );

ALTER TABLE "falla_unidad" ADD CONSTRAINT "PK_falla_unidad_id" PRIMARY KEY ( "id" );

CREATE TABLE "lectura_unidad" (
    "id"                   NUMBER(19) NOT NULL,
    "unidad_id"            NUMBER(19) NOT NULL,
    "componente_id"        NUMBER(19),
    "checkin_id"           NUMBER(19),
    "tipo_lectura"         VARCHAR2(10) NOT NULL,
    "valor"                NUMBER(16, 3) NOT NULL,
    "fecha_lectura"        TIMESTAMP DEFAULT systimestamp,
    "registrado_por_id"    NUMBER(19) NOT NULL,
    "reemplaza_lectura_id" NUMBER(19),
    "motivo_correccion"    CLOB
);

ALTER TABLE "lectura_unidad"
    ADD CONSTRAINT ck_lectura_unidad_1 CHECK ( "tipo_lectura" IN ( 'KM', 'HORAS' ) );

ALTER TABLE "lectura_unidad"
    ADD CONSTRAINT ck_lectura_unidad_2 CHECK ( ( "tipo_lectura" = 'KM'
                                                 AND "componente_id" IS NULL )
                                               OR ( "tipo_lectura" = 'HORAS'
                                                    AND "componente_id" IS NOT NULL ) );

ALTER TABLE "lectura_unidad" ADD CONSTRAINT ck_lectura_unidad_3 CHECK ( "valor" >= 0 );

ALTER TABLE "lectura_unidad"
    ADD CONSTRAINT ck_lectura_unidad_4 CHECK ( "reemplaza_lectura_id" IS NULL
                                               OR ( "motivo_correccion" IS NOT NULL
                                                    AND TRIM("motivo_correccion") <> '' ) );

ALTER TABLE "lectura_unidad" ADD CONSTRAINT "PK_lectura_unidad_id" PRIMARY KEY ( "id" );

CREATE TABLE "mantenimiento" (
    "id"                  NUMBER(19) NOT NULL,
    "unidad_id"           NUMBER(19) NOT NULL,
    "componente_id"       NUMBER(19),
    "plan_control_id"     NUMBER(19),
    "proveedor_nombre"    VARCHAR2(200),
    "registrado_por_id"   NUMBER(19) NOT NULL,
    "tipo"                VARCHAR2(15) NOT NULL,
    "estado_trabajo"      VARCHAR2(25) NOT NULL,
    "fecha_inicio"        DATE NOT NULL,
    "fecha_fin"           DATE,
    "descripcion"         CLOB NOT NULL,
    "falla_descripcion"   CLOB,
    "trabajo_realizado"   CLOB,
    "km_referencia"       NUMBER(16, 3),
    "horas_referencia"    NUMBER(16, 3),
    "referencia_servicio" VARCHAR2(150),
    "observaciones"       CLOB
);

ALTER TABLE "mantenimiento"
    ADD CONSTRAINT ck_mantenimiento_1 CHECK ( "tipo" IN ( 'PREVENTIVO', 'CORRECTIVO' ) );

ALTER TABLE "mantenimiento"
    ADD CONSTRAINT ck_mantenimiento_2 CHECK ( "estado_trabajo" IN ( 'PROGRAMADO', 'EN_PROCESO', 'FINALIZADO', 'CANCELADO' ) );

ALTER TABLE "mantenimiento"
    ADD CONSTRAINT ck_mantenimiento_3 CHECK ( "km_referencia" IS NULL
                                              OR "km_referencia" >= 0 );

ALTER TABLE "mantenimiento"
    ADD CONSTRAINT ck_mantenimiento_4 CHECK ( "horas_referencia" IS NULL
                                              OR "horas_referencia" >= 0 );

ALTER TABLE "mantenimiento"
    ADD CONSTRAINT ck_mantenimiento_5 CHECK ( "fecha_fin" IS NULL
                                              OR "fecha_fin" >= "fecha_inicio" );

ALTER TABLE "mantenimiento" ADD CONSTRAINT "PK_mantenimiento_id" PRIMARY KEY ( "id" );

CREATE TABLE "movimiento_detalle" (
    "id"                   NUMBER(19) NOT NULL,
    "movimiento_id"        NUMBER(19) NOT NULL,
    "variante_id"          NUMBER(19) NOT NULL,
    "equipo_seriado_id"    NUMBER(19),
    "cantidad"             NUMBER(14) NOT NULL,
    "stock_origen_id"      NUMBER(19),
    "stock_destino_id"     NUMBER(19),
    "compania_origen_id"   NUMBER(19),
    "compania_destino_id"  NUMBER(19),
    "ubicacion_origen_id"  NUMBER(19),
    "ubicacion_destino_id" NUMBER(19),
    "estado_origen_id"     NUMBER(19),
    "estado_destino_id"    NUMBER(19),
    "asignacion_id"        NUMBER(19),
    "prestamo_detalle_id"  NUMBER(19),
    "observaciones"        CLOB
);

ALTER TABLE "movimiento_detalle" ADD CONSTRAINT ck_movimiento_detalle_1 CHECK ( "cantidad" > 0 );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT ck_movimiento_detalle_2 CHECK ( "equipo_seriado_id" IS NULL
                                                   OR "cantidad" = 1 );

ALTER TABLE "movimiento_detalle" ADD CONSTRAINT "PK_movimiento_detalle_id" PRIMARY KEY ( "id" );

CREATE TABLE "movimiento_inventario" (
    "id"                   NUMBER(19) NOT NULL,
    "tipo_movimiento"      VARCHAR2(35) NOT NULL,
    "usuario_id"           NUMBER(19) NOT NULL,
    "compania_contexto_id" NUMBER(19) NOT NULL,
    "fecha_operacion"      TIMESTAMP DEFAULT systimestamp,
    "motivo"               VARCHAR2(250),
    "observaciones"        CLOB,
    "referencia_externa"   VARCHAR2(100)
);

ALTER TABLE "movimiento_inventario"
    ADD CONSTRAINT ck_movimiento_inventario_1 CHECK ( "tipo_movimiento" IN ( 'INGRESO', 'BAJA', 'PERDIDA', 'TRASLADO', 'ASIGNACION',
                                                                             'DEVOLUCION_PERSONAL', 'PRESTAMO', 'DEVOLUCION_PRESTAMO'
                                                                             , 'CAMBIO_ESTADO', 'AJUSTE',
                                                                             'CORRECCION' ) );

ALTER TABLE "movimiento_inventario" ADD CONSTRAINT "PK_movimiento_inventario_id" PRIMARY KEY ( "id" );

CREATE TABLE "plan_control" (
    "id"            NUMBER(19) NOT NULL,
    "unidad_id"     NUMBER(19) NOT NULL,
    "componente_id" NUMBER(19),
    "clase"         VARCHAR2(25) NOT NULL,
    "nombre"        VARCHAR2(150) NOT NULL,
    "descripcion"   CLOB,
    "activo"        NUMBER(1) DEFAULT 1
);

ALTER TABLE "plan_control"
    ADD CONSTRAINT ck_plan_control_1 CHECK ( "clase" IN ( 'PREVENTIVO', 'REVISION_TECNICA', 'OTRO' ) );

ALTER TABLE "plan_control"
    ADD CONSTRAINT ck_plan_control_2 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "plan_control" ADD CONSTRAINT "PK_plan_control_id" PRIMARY KEY ( "id" );

CREATE TABLE "prestamo" (
    "id"                  NUMBER(19) NOT NULL,
    "compania_origen_id"  NUMBER(19) NOT NULL,
    "compania_destino_id" NUMBER(19) NOT NULL,
    "registrado_por_id"   NUMBER(19) NOT NULL,
    "fecha_entrega"       TIMESTAMP DEFAULT systimestamp,
    "fecha_compromiso"    DATE,
    "fecha_cierre"        TIMESTAMP,
    "estado"              VARCHAR2(20) DEFAULT 'PENDIENTE',
    "observaciones"       CLOB
);

ALTER TABLE "prestamo" ADD CONSTRAINT ck_prestamo_1 CHECK ( "compania_origen_id" <> "compania_destino_id" );

ALTER TABLE "prestamo"
    ADD CONSTRAINT ck_prestamo_2 CHECK ( "estado" IN ( 'PENDIENTE', 'PARCIAL', 'FINALIZADO', 'CANCELADO' ) );

ALTER TABLE "prestamo" ADD CONSTRAINT "PK_prestamo_id" PRIMARY KEY ( "id" );

CREATE TABLE "prestamo_detalle" (
    "id"                NUMBER(19) NOT NULL,
    "prestamo_id"       NUMBER(19) NOT NULL,
    "variante_id"       NUMBER(19) NOT NULL,
    "equipo_seriado_id" NUMBER(19),
    "cantidad_prestada" NUMBER(14) NOT NULL,
    "cantidad_devuelta" NUMBER(14) DEFAULT 0,
    "estado_salida_id"  NUMBER(19) NOT NULL,
    "observaciones"     CLOB
);

ALTER TABLE "prestamo_detalle" ADD CONSTRAINT ck_prestamo_detalle_1 CHECK ( "cantidad_prestada" > 0 );

ALTER TABLE "prestamo_detalle" ADD CONSTRAINT ck_prestamo_detalle_2 CHECK ( "cantidad_devuelta" >= 0 );

ALTER TABLE "prestamo_detalle" ADD CONSTRAINT ck_prestamo_detalle_3 CHECK ( "cantidad_devuelta" <= "cantidad_prestada" );

ALTER TABLE "prestamo_detalle"
    ADD CONSTRAINT ck_prestamo_detalle_4 CHECK ( "equipo_seriado_id" IS NULL
                                                 OR "cantidad_prestada" = 1 );

ALTER TABLE "prestamo_detalle" ADD CONSTRAINT "PK_prestamo_detalle_id" PRIMARY KEY ( "id" );

CREATE TABLE "regla_control" (
    "id"                 NUMBER(19) NOT NULL,
    "plan_control_id"    NUMBER(19) NOT NULL,
    "criterio"           VARCHAR2(10) NOT NULL,
    "intervalo_valor"    NUMBER(16, 3),
    "anticipacion_valor" NUMBER(16, 3) DEFAULT 0,
    "proximo_umbral"     NUMBER(16, 3),
    "proxima_fecha"      DATE,
    "activo"             NUMBER(1) DEFAULT 1,
    "actualizado_en"     TIMESTAMP DEFAULT systimestamp
);

ALTER TABLE "regla_control"
    ADD CONSTRAINT ck_regla_control_1 CHECK ( "criterio" IN ( 'KM', 'HORAS', 'FECHA' ) );

ALTER TABLE "regla_control" ADD CONSTRAINT ck_regla_control_2 CHECK ( "anticipacion_valor" >= 0 );

ALTER TABLE "regla_control"
    ADD CONSTRAINT ck_regla_control_3 CHECK ( "intervalo_valor" IS NULL
                                              OR "intervalo_valor" > 0 );

ALTER TABLE "regla_control"
    ADD CONSTRAINT ck_regla_control_4 CHECK ( "proximo_umbral" IS NULL
                                              OR "proximo_umbral" >= 0 );

ALTER TABLE "regla_control"
    ADD CONSTRAINT ck_regla_control_5 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "regla_control"
    ADD CONSTRAINT ck_regla_control_6 CHECK ( ( "criterio" = 'FECHA'
                                                AND "proxima_fecha" IS NOT NULL
                                                AND "proximo_umbral" IS NULL )
                                              OR ( "criterio" IN ( 'KM', 'HORAS' )
                                                   AND "proximo_umbral" IS NOT NULL
                                                   AND "proxima_fecha" IS NULL ) );

ALTER TABLE "regla_control" ADD CONSTRAINT "PK_regla_control_id" PRIMARY KEY ( "id" );

CREATE TABLE "rol" (
    "id"      NUMBER(19) NOT NULL,
    "codigo"  VARCHAR2(40) NOT NULL,
    "nombre"  VARCHAR2(120) NOT NULL,
    "alcance" VARCHAR2(20) NOT NULL,
    "activo"  NUMBER(1) DEFAULT 1
);

ALTER TABLE "rol"
    ADD CONSTRAINT ck_rol_1 CHECK ( "alcance" IN ( 'GLOBAL', 'COMPANIA' ) );

ALTER TABLE "rol"
    ADD CONSTRAINT ck_rol_2 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "rol" ADD CONSTRAINT "PK_rol_id" PRIMARY KEY ( "id" );

ALTER TABLE "rol" ADD CONSTRAINT index_1v5 UNIQUE ( "codigo" );

CREATE TABLE "stock_posicion" (
    "id"                      NUMBER(19) NOT NULL,
    "variante_id"             NUMBER(19) NOT NULL,
    "compania_propietaria_id" NUMBER(19) NOT NULL,
    "compania_tenedora_id"    NUMBER(19) NOT NULL,
    "ubicacion_id"            NUMBER(19),
    "estado_material_id"      NUMBER(19) NOT NULL,
    "origen_id"               NUMBER(19),
    "cantidad_en_posicion"    NUMBER(14) DEFAULT 0,
    "fecha_alta"              TIMESTAMP DEFAULT systimestamp,
    "observaciones"           CLOB
);

ALTER TABLE "stock_posicion" ADD CONSTRAINT ck_stock_posicion_1 CHECK ( "cantidad_en_posicion" >= 0 );

ALTER TABLE "stock_posicion" ADD CONSTRAINT "PK_stock_posicion_id" PRIMARY KEY ( "id" );

CREATE TABLE "ubicacion" (
    "id"                NUMBER(19) NOT NULL,
    "compania_id"       NUMBER(19) NOT NULL,
    "tipo_ubicacion_id" NUMBER(19) NOT NULL,
    "unidad_id"         NUMBER(19),
    "padre_id"          NUMBER(19),
    "codigo"            VARCHAR2(80) NOT NULL,
    "nombre"            VARCHAR2(140) NOT NULL,
    "activo"            NUMBER(1) DEFAULT 1
);

ALTER TABLE "ubicacion"
    ADD CONSTRAINT ck_ubicacion_1 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "ubicacion" ADD CONSTRAINT "PK_ubicacion_id" PRIMARY KEY ( "id" );

ALTER TABLE "ubicacion" ADD CONSTRAINT "UQ_ubicacion_compania_id_codigo" UNIQUE ( "compania_id",
                                                                                  "codigo" );

CREATE TABLE "unidad" (
    "id"                                 NUMBER(19) NOT NULL,
    "compania_id"                        NUMBER(19) NOT NULL,
    "codigo"                             VARCHAR2(40) NOT NULL,
    "codigo_institucional"               VARCHAR2(60),
    "tipo_unidad_id"                     NUMBER(19) NOT NULL,
    "estado_unidad_id"                   NUMBER(19) NOT NULL,
    "marca"                              VARCHAR2(100),
    "modelo"                             VARCHAR2(120),
    "anio"                               NUMBER(14),
    "numero_motor"                       VARCHAR2(100),
    "vin"                                VARCHAR2(100),
    "patente"                            VARCHAR2(30),
    "fecha_ultima_revision_tecnica"      DATE,
    "fecha_vencimiento_revision_tecnica" DATE,
    "fecha_fuera_servicio"               DATE,
    "motivo_fuera_servicio"              CLOB,
    "activo"                             NUMBER(1) DEFAULT 1
);

ALTER TABLE "unidad"
    ADD CONSTRAINT ck_unidad_1 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "unidad"
    ADD CONSTRAINT ck_unidad_2 CHECK ( "anio" IS NULL
                                       OR ( "anio" BETWEEN 1900 AND 2200 ) );

ALTER TABLE "unidad" ADD CONSTRAINT "PK_unidad_id" PRIMARY KEY ( "id" );

ALTER TABLE "unidad" ADD CONSTRAINT index_1v6 UNIQUE ( "codigo_institucional" );

ALTER TABLE "unidad" ADD CONSTRAINT index_2 UNIQUE ( "vin" );

ALTER TABLE "unidad" ADD CONSTRAINT index_3 UNIQUE ( "patente" );

ALTER TABLE "unidad" ADD CONSTRAINT "UQ_unidad_compania_id_codigo" UNIQUE ( "compania_id",
                                                                            "codigo" );

CREATE TABLE "usuario" (
    "id"           NUMBER(19) NOT NULL,
    "username"     VARCHAR2(150) NOT NULL,
    "password"     VARCHAR2(128) NOT NULL,
    "first_name"   VARCHAR2(150),
    "last_name"    VARCHAR2(150),
    "email"        VARCHAR2(254),
    "rol_id"       NUMBER(19) NOT NULL,
    "compania_id"  NUMBER(19),
    "is_active"    NUMBER(1) DEFAULT 1,
    "is_staff"     NUMBER(1) DEFAULT 0,
    "is_superuser" NUMBER(1) DEFAULT 0,
    "last_login"   TIMESTAMP,
    "date_joined"  TIMESTAMP DEFAULT systimestamp
);

ALTER TABLE "usuario"
    ADD CONSTRAINT ck_usuario_1 CHECK ( "is_active" IN ( 0, 1 ) );

ALTER TABLE "usuario"
    ADD CONSTRAINT ck_usuario_2 CHECK ( "is_staff" IN ( 0, 1 ) );

ALTER TABLE "usuario"
    ADD CONSTRAINT ck_usuario_3 CHECK ( "is_superuser" IN ( 0, 1 ) );

ALTER TABLE "usuario" ADD CONSTRAINT "PK_usuario_id" PRIMARY KEY ( "id" );

ALTER TABLE "usuario" ADD CONSTRAINT index_1v7 UNIQUE ( "username" );

CREATE TABLE "variante_atributo" (
    "id"          NUMBER(19) NOT NULL,
    "variante_id" NUMBER(19) NOT NULL,
    "atributo_id" NUMBER(19) NOT NULL,
    "opcion_id"   NUMBER(19),
    "valor_libre" VARCHAR2(200)
);

ALTER TABLE "variante_atributo"
    ADD CONSTRAINT ck_variante_atributo_1 CHECK ( ( "opcion_id" IS NOT NULL
                                                    AND "valor_libre" IS NULL )
                                                  OR ( "opcion_id" IS NULL
                                                       AND "valor_libre" IS NOT NULL ) );

ALTER TABLE "variante_atributo" ADD CONSTRAINT "PK_variante_atributo_id" PRIMARY KEY ( "id" );

ALTER TABLE "variante_atributo" ADD CONSTRAINT "UQ_variante_atributo_variante_id_atributo_id" UNIQUE ( "variante_id",
                                                                                                       "atributo_id" );

ALTER TABLE "alerta_control"
    ADD CONSTRAINT "FK_alerta_control_regla_control_id" FOREIGN KEY ( "regla_control_id" )
        REFERENCES "regla_control" ( "id" );

ALTER TABLE "alerta_control"
    ADD CONSTRAINT "FK_alerta_control_resuelta_por_id" FOREIGN KEY ( "resuelta_por_id" )
        REFERENCES "usuario" ( "id" );

ALTER TABLE "articulo"
    ADD CONSTRAINT "FK_articulo_categoria_id" FOREIGN KEY ( "categoria_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "articulo"
    ADD CONSTRAINT "FK_articulo_tipo_id" FOREIGN KEY ( "tipo_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "articulo_variante"
    ADD CONSTRAINT "FK_articulo_variante_articulo_id" FOREIGN KEY ( "articulo_id" )
        REFERENCES "articulo" ( "id" );

ALTER TABLE "asignacion_equipo"
    ADD CONSTRAINT "FK_asignacion_equipo_bombero_id" FOREIGN KEY ( "bombero_id" )
        REFERENCES "bombero" ( "id" );

ALTER TABLE "asignacion_equipo"
    ADD CONSTRAINT "FK_asignacion_equipo_compania_id" FOREIGN KEY ( "compania_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "asignacion_equipo"
    ADD CONSTRAINT "FK_asignacion_equipo_entregado_por_id" FOREIGN KEY ( "entregado_por_id" )
        REFERENCES "usuario" ( "id" );

ALTER TABLE "asignacion_equipo"
    ADD CONSTRAINT "FK_asignacion_equipo_equipo_seriado_id" FOREIGN KEY ( "equipo_seriado_id" )
        REFERENCES "equipo_seriado" ( "id" );

ALTER TABLE "asignacion_equipo"
    ADD CONSTRAINT "FK_asignacion_equipo_estado_salida_id" FOREIGN KEY ( "estado_salida_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "asignacion_equipo"
    ADD CONSTRAINT "FK_asignacion_equipo_variante_id" FOREIGN KEY ( "variante_id" )
        REFERENCES "articulo_variante" ( "id" );

ALTER TABLE "atributo_opcion"
    ADD CONSTRAINT "FK_atributo_opcion_atributo_id" FOREIGN KEY ( "atributo_id" )
        REFERENCES "atributo_def" ( "id" );

ALTER TABLE "auditoria_evento"
    ADD CONSTRAINT "FK_auditoria_evento_compania_contexto_id" FOREIGN KEY ( "compania_contexto_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "auditoria_evento"
    ADD CONSTRAINT "FK_auditoria_evento_usuario_id" FOREIGN KEY ( "usuario_id" )
        REFERENCES "usuario" ( "id" );

ALTER TABLE "bombero"
    ADD CONSTRAINT "FK_bombero_compania_id" FOREIGN KEY ( "compania_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "checkin"
    ADD CONSTRAINT "FK_checkin_estado_general_id" FOREIGN KEY ( "estado_general_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "checkin"
    ADD CONSTRAINT "FK_checkin_responsable_usuario_id" FOREIGN KEY ( "responsable_usuario_id" )
        REFERENCES "usuario" ( "id" );

ALTER TABLE "checkin"
    ADD CONSTRAINT "FK_checkin_unidad_id" FOREIGN KEY ( "unidad_id" )
        REFERENCES "unidad" ( "id" );

ALTER TABLE "componente_unidad"
    ADD CONSTRAINT "FK_componente_unidad_unidad_id" FOREIGN KEY ( "unidad_id" )
        REFERENCES "unidad" ( "id" );

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT "FK_equipo_seriado_bombero_actual_id" FOREIGN KEY ( "bombero_actual_id" )
        REFERENCES "bombero" ( "id" );

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT "FK_equipo_seriado_compania_propietaria_id" FOREIGN KEY ( "compania_propietaria_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT "FK_equipo_seriado_compania_tenedora_id" FOREIGN KEY ( "compania_tenedora_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT "FK_equipo_seriado_estado_material_id" FOREIGN KEY ( "estado_material_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT "FK_equipo_seriado_origen_id" FOREIGN KEY ( "origen_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT "FK_equipo_seriado_ubicacion_id" FOREIGN KEY ( "ubicacion_id" )
        REFERENCES "ubicacion" ( "id" );

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT "FK_equipo_seriado_variante_id" FOREIGN KEY ( "variante_id" )
        REFERENCES "articulo_variante" ( "id" );

ALTER TABLE "estado_unidad_hist"
    ADD CONSTRAINT "FK_estado_unidad_hist_estado_anterior_id" FOREIGN KEY ( "estado_anterior_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "estado_unidad_hist"
    ADD CONSTRAINT "FK_estado_unidad_hist_estado_nuevo_id" FOREIGN KEY ( "estado_nuevo_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "estado_unidad_hist"
    ADD CONSTRAINT "FK_estado_unidad_hist_unidad_id" FOREIGN KEY ( "unidad_id" )
        REFERENCES "unidad" ( "id" );

ALTER TABLE "estado_unidad_hist"
    ADD CONSTRAINT "FK_estado_unidad_hist_usuario_id" FOREIGN KEY ( "usuario_id" )
        REFERENCES "usuario" ( "id" );

ALTER TABLE "falla_unidad"
    ADD CONSTRAINT "FK_falla_unidad_checkin_id" FOREIGN KEY ( "checkin_id" )
        REFERENCES "checkin" ( "id" );

ALTER TABLE "falla_unidad"
    ADD CONSTRAINT "FK_falla_unidad_mantenimiento_id" FOREIGN KEY ( "mantenimiento_id" )
        REFERENCES "mantenimiento" ( "id" );

ALTER TABLE "falla_unidad"
    ADD CONSTRAINT "FK_falla_unidad_registrado_por_id" FOREIGN KEY ( "registrado_por_id" )
        REFERENCES "usuario" ( "id" );

ALTER TABLE "falla_unidad"
    ADD CONSTRAINT "FK_falla_unidad_unidad_id" FOREIGN KEY ( "unidad_id" )
        REFERENCES "unidad" ( "id" );

ALTER TABLE "lectura_unidad"
    ADD CONSTRAINT "FK_lectura_unidad_checkin_id" FOREIGN KEY ( "checkin_id" )
        REFERENCES "checkin" ( "id" );

ALTER TABLE "lectura_unidad"
    ADD CONSTRAINT "FK_lectura_unidad_componente_id" FOREIGN KEY ( "componente_id" )
        REFERENCES "componente_unidad" ( "id" );

ALTER TABLE "lectura_unidad"
    ADD CONSTRAINT "FK_lectura_unidad_reemplaza_lectura_id" FOREIGN KEY ( "reemplaza_lectura_id" )
        REFERENCES "lectura_unidad" ( "id" );

ALTER TABLE "lectura_unidad"
    ADD CONSTRAINT "FK_lectura_unidad_registrado_por_id" FOREIGN KEY ( "registrado_por_id" )
        REFERENCES "usuario" ( "id" );

ALTER TABLE "lectura_unidad"
    ADD CONSTRAINT "FK_lectura_unidad_unidad_id" FOREIGN KEY ( "unidad_id" )
        REFERENCES "unidad" ( "id" );

ALTER TABLE "mantenimiento"
    ADD CONSTRAINT "FK_mantenimiento_componente_id" FOREIGN KEY ( "componente_id" )
        REFERENCES "componente_unidad" ( "id" );

ALTER TABLE "mantenimiento"
    ADD CONSTRAINT "FK_mantenimiento_plan_control_id" FOREIGN KEY ( "plan_control_id" )
        REFERENCES "plan_control" ( "id" );

ALTER TABLE "mantenimiento"
    ADD CONSTRAINT "FK_mantenimiento_registrado_por_id" FOREIGN KEY ( "registrado_por_id" )
        REFERENCES "usuario" ( "id" );

ALTER TABLE "mantenimiento"
    ADD CONSTRAINT "FK_mantenimiento_unidad_id" FOREIGN KEY ( "unidad_id" )
        REFERENCES "unidad" ( "id" );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT "FK_movimiento_detalle_asignacion_id" FOREIGN KEY ( "asignacion_id" )
        REFERENCES "asignacion_equipo" ( "id" );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT "FK_movimiento_detalle_compania_destino_id" FOREIGN KEY ( "compania_destino_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT "FK_movimiento_detalle_compania_origen_id" FOREIGN KEY ( "compania_origen_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT "FK_movimiento_detalle_equipo_seriado_id" FOREIGN KEY ( "equipo_seriado_id" )
        REFERENCES "equipo_seriado" ( "id" );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT "FK_movimiento_detalle_estado_destino_id" FOREIGN KEY ( "estado_destino_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT "FK_movimiento_detalle_estado_origen_id" FOREIGN KEY ( "estado_origen_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT "FK_movimiento_detalle_movimiento_id" FOREIGN KEY ( "movimiento_id" )
        REFERENCES "movimiento_inventario" ( "id" );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT "FK_movimiento_detalle_prestamo_detalle_id" FOREIGN KEY ( "prestamo_detalle_id" )
        REFERENCES "prestamo_detalle" ( "id" );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT "FK_movimiento_detalle_stock_destino_id" FOREIGN KEY ( "stock_destino_id" )
        REFERENCES "stock_posicion" ( "id" );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT "FK_movimiento_detalle_stock_origen_id" FOREIGN KEY ( "stock_origen_id" )
        REFERENCES "stock_posicion" ( "id" );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT "FK_movimiento_detalle_ubicacion_destino_id" FOREIGN KEY ( "ubicacion_destino_id" )
        REFERENCES "ubicacion" ( "id" );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT "FK_movimiento_detalle_ubicacion_origen_id" FOREIGN KEY ( "ubicacion_origen_id" )
        REFERENCES "ubicacion" ( "id" );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT "FK_movimiento_detalle_variante_id" FOREIGN KEY ( "variante_id" )
        REFERENCES "articulo_variante" ( "id" );

ALTER TABLE "movimiento_inventario"
    ADD CONSTRAINT "FK_movimiento_inventario_compania_contexto_id" FOREIGN KEY ( "compania_contexto_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "movimiento_inventario"
    ADD CONSTRAINT "FK_movimiento_inventario_usuario_id" FOREIGN KEY ( "usuario_id" )
        REFERENCES "usuario" ( "id" );

ALTER TABLE "plan_control"
    ADD CONSTRAINT "FK_plan_control_componente_id" FOREIGN KEY ( "componente_id" )
        REFERENCES "componente_unidad" ( "id" );

ALTER TABLE "plan_control"
    ADD CONSTRAINT "FK_plan_control_unidad_id" FOREIGN KEY ( "unidad_id" )
        REFERENCES "unidad" ( "id" );

ALTER TABLE "prestamo"
    ADD CONSTRAINT "FK_prestamo_compania_destino_id" FOREIGN KEY ( "compania_destino_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "prestamo"
    ADD CONSTRAINT "FK_prestamo_compania_origen_id" FOREIGN KEY ( "compania_origen_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "prestamo_detalle"
    ADD CONSTRAINT "FK_prestamo_detalle_equipo_seriado_id" FOREIGN KEY ( "equipo_seriado_id" )
        REFERENCES "equipo_seriado" ( "id" );

ALTER TABLE "prestamo_detalle"
    ADD CONSTRAINT "FK_prestamo_detalle_estado_salida_id" FOREIGN KEY ( "estado_salida_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "prestamo_detalle"
    ADD CONSTRAINT "FK_prestamo_detalle_prestamo_id" FOREIGN KEY ( "prestamo_id" )
        REFERENCES "prestamo" ( "id" );

ALTER TABLE "prestamo_detalle"
    ADD CONSTRAINT "FK_prestamo_detalle_variante_id" FOREIGN KEY ( "variante_id" )
        REFERENCES "articulo_variante" ( "id" );

ALTER TABLE "prestamo"
    ADD CONSTRAINT "FK_prestamo_registrado_por_id" FOREIGN KEY ( "registrado_por_id" )
        REFERENCES "usuario" ( "id" );

ALTER TABLE "regla_control"
    ADD CONSTRAINT "FK_regla_control_plan_control_id" FOREIGN KEY ( "plan_control_id" )
        REFERENCES "plan_control" ( "id" );

ALTER TABLE "stock_posicion"
    ADD CONSTRAINT "FK_stock_posicion_compania_propietaria_id" FOREIGN KEY ( "compania_propietaria_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "stock_posicion"
    ADD CONSTRAINT "FK_stock_posicion_compania_tenedora_id" FOREIGN KEY ( "compania_tenedora_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "stock_posicion"
    ADD CONSTRAINT "FK_stock_posicion_estado_material_id" FOREIGN KEY ( "estado_material_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "stock_posicion"
    ADD CONSTRAINT "FK_stock_posicion_origen_id" FOREIGN KEY ( "origen_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "stock_posicion"
    ADD CONSTRAINT "FK_stock_posicion_ubicacion_id" FOREIGN KEY ( "ubicacion_id" )
        REFERENCES "ubicacion" ( "id" );

ALTER TABLE "stock_posicion"
    ADD CONSTRAINT "FK_stock_posicion_variante_id" FOREIGN KEY ( "variante_id" )
        REFERENCES "articulo_variante" ( "id" );

ALTER TABLE "ubicacion"
    ADD CONSTRAINT "FK_ubicacion_compania_id" FOREIGN KEY ( "compania_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "ubicacion"
    ADD CONSTRAINT "FK_ubicacion_padre_id" FOREIGN KEY ( "padre_id" )
        REFERENCES "ubicacion" ( "id" );

ALTER TABLE "ubicacion"
    ADD CONSTRAINT "FK_ubicacion_tipo_ubicacion_id" FOREIGN KEY ( "tipo_ubicacion_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "ubicacion"
    ADD CONSTRAINT "FK_ubicacion_unidad_id" FOREIGN KEY ( "unidad_id" )
        REFERENCES "unidad" ( "id" );

ALTER TABLE "unidad"
    ADD CONSTRAINT "FK_unidad_compania_id" FOREIGN KEY ( "compania_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "unidad"
    ADD CONSTRAINT "FK_unidad_estado_unidad_id" FOREIGN KEY ( "estado_unidad_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "unidad"
    ADD CONSTRAINT "FK_unidad_tipo_unidad_id" FOREIGN KEY ( "tipo_unidad_id" )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE "usuario"
    ADD CONSTRAINT "FK_usuario_compania_id" FOREIGN KEY ( "compania_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "usuario"
    ADD CONSTRAINT "FK_usuario_rol_id" FOREIGN KEY ( "rol_id" )
        REFERENCES "rol" ( "id" );

ALTER TABLE "variante_atributo"
    ADD CONSTRAINT "FK_variante_atributo_atributo_id" FOREIGN KEY ( "atributo_id" )
        REFERENCES "atributo_def" ( "id" );

ALTER TABLE "variante_atributo"
    ADD CONSTRAINT "FK_variante_atributo_opcion_id" FOREIGN KEY ( "opcion_id" )
        REFERENCES "atributo_opcion" ( "id" );

ALTER TABLE "variante_atributo"
    ADD CONSTRAINT "FK_variante_atributo_variante_id" FOREIGN KEY ( "variante_id" )
        REFERENCES "articulo_variante" ( "id" );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            29
-- CREATE INDEX                             0
-- ALTER TABLE                            192
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
