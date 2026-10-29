-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2026-10-25 19:01:03 CLST
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
    "observaciones"      CLOB,
    "lote_ingreso_id"    NUMBER(19)
);

COMMENT ON COLUMN "asignacion_equipo"."lote_ingreso_id" IS
    'Lote de origen del material. Permite mantener su trazabilidad en existencias, entregas, préstamos y devoluciones.';

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

CREATE TABLE capacidad (
    id          NUMBER(19) NOT NULL,
    codigo      VARCHAR2(60) NOT NULL,
    nombre      VARCHAR2(150) NOT NULL,
    descripcion CLOB,
    activo      NUMBER(1) DEFAULT 1
);

COMMENT ON TABLE capacidad IS
    'RF-013. Reunion CBSB 18-10-2026. Catalogo de capacidades tecnicas de unidades; no representa material o equipo inventariado.';

ALTER TABLE capacidad
    ADD CONSTRAINT ck_capacidad_activo CHECK ( activo IN ( 0, 1 ) );

ALTER TABLE capacidad ADD CONSTRAINT pk_capacidad PRIMARY KEY ( id );

ALTER TABLE capacidad ADD CONSTRAINT uq_capacidad_codigo UNIQUE ( codigo );

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

CREATE TABLE checkin_respuesta (
    id                          NUMBER(19) NOT NULL,
    checkin_id                  NUMBER(19) NOT NULL,
    checklist_item_id           NUMBER(19) NOT NULL,
    resultado_codigo            VARCHAR2(30),
    observaciones               CLOB,
    registrado_en               TIMESTAMP DEFAULT systimestamp,
    codigo_item_registrado      VARCHAR2(60) NOT NULL,
    nombre_item_registrado      VARCHAR2(200) NOT NULL,
    descripcion_item_registrada CLOB
);

COMMENT ON TABLE checkin_respuesta IS
    'RF-015, RF-016; RNF-008. Reunion CBSB 18-10-2026. Respuesta historica. La aplicacion debe copiar codigo, nombre y descripcion del item a las columnas de instantanea al registrar; no modificar instantaneas historicas. Resultados y frecuencia pendientes.'
    ;

ALTER TABLE checkin_respuesta ADD CONSTRAINT pk_checkin_respuesta PRIMARY KEY ( id );

ALTER TABLE checkin_respuesta ADD CONSTRAINT uq_checkin_respuesta_item UNIQUE ( checkin_id,
                                                                                checklist_item_id );

CREATE TABLE checklist_item (
    id             NUMBER(19) NOT NULL,
    codigo         VARCHAR2(60) NOT NULL,
    nombre         VARCHAR2(200) NOT NULL,
    descripcion    CLOB,
    unidad_id      NUMBER(19),
    tipo_unidad_id NUMBER(19),
    orden_visual   NUMBER(5),
    activo         NUMBER(1) DEFAULT 1,
    creado_en      TIMESTAMP DEFAULT systimestamp
);

COMMENT ON TABLE checklist_item IS
    'RF-015, RF-016. Reunion CBSB 18-10-2026. Definicion configurable. Aplicacion valida dominio TIPO_UNIDAD. Frecuencia, obligatoriedad y resultados pendientes; no determina operatividad.'
    ;

ALTER TABLE checklist_item
    ADD CONSTRAINT ck_checklist_item_activo CHECK ( activo IN ( 0, 1 ) );

ALTER TABLE checklist_item ADD CONSTRAINT pk_checklist_item PRIMARY KEY ( id );

ALTER TABLE checklist_item ADD CONSTRAINT uq_checklist_item_codigo UNIQUE ( codigo );

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
    "id"                 NUMBER(19) NOT NULL,
    "unidad_id"          NUMBER(19) NOT NULL,
    "codigo"             VARCHAR2(50) NOT NULL,
    "nombre"             VARCHAR2(150) NOT NULL,
    "tipo"               VARCHAR2(70) NOT NULL,
    "activo"             NUMBER(1) DEFAULT 1,
    "marca"              VARCHAR2(100),
    "modelo"             VARCHAR2(100),
    "numero_serie"       VARCHAR2(100),
    "posicion"           VARCHAR2(100),
    "fecha_instalacion"  DATE,
    "fecha_retiro"       DATE,
    "vida_util_valor"    NUMBER(14, 2),
    "vida_util_unidad"   VARCHAR2(10),
    "fecha_inicio_uso"   DATE,
    "lectura_inicio_uso" NUMBER(14, 2),
    "fecha_vencimiento"  DATE
);

COMMENT ON COLUMN "componente_unidad"."marca" IS
    'Marca del componente, cuando corresponda.';

COMMENT ON COLUMN "componente_unidad"."modelo" IS
    'Modelo del componente, cuando corresponda.';

COMMENT ON COLUMN "componente_unidad"."numero_serie" IS
    'Serie del fabricante del componente. No reemplaza la identificación del vehículo.';

COMMENT ON COLUMN "componente_unidad"."posicion" IS
    'Posición o emplazamiento del componente dentro de la unidad.';

COMMENT ON COLUMN "componente_unidad"."fecha_instalacion" IS
    'Fecha de instalación del componente en la unidad.';

COMMENT ON COLUMN "componente_unidad"."fecha_retiro" IS
    'Fecha de retiro del componente, conservando sus lecturas y mantenimientos históricos.';

COMMENT ON COLUMN "componente_unidad"."vida_util_valor" IS
    'Vida útil de referencia. Un dato desconocido se conserva vacío.';

COMMENT ON COLUMN "componente_unidad"."vida_util_unidad" IS
    'Unidad de la vida útil: DIAS, MESES, ANIOS, KM o HORAS.';

COMMENT ON COLUMN "componente_unidad"."fecha_inicio_uso" IS
    'Fecha desde la que se considera el inicio de uso del elemento.';

COMMENT ON COLUMN "componente_unidad"."lectura_inicio_uso" IS
    'Lectura inicial cuando la vida útil se expresa en kilómetros o en horas.';

COMMENT ON COLUMN "componente_unidad"."fecha_vencimiento" IS
    'Vencimiento conocido o documentado. No implica un cálculo automático de depreciación.';

ALTER TABLE "componente_unidad"
    ADD CONSTRAINT ck_componente_unidad_1 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "componente_unidad"
    ADD CONSTRAINT ck_comp_vida CHECK ( ( "vida_util_valor" IS NULL
                                          AND "vida_util_unidad" IS NULL )
                                        OR ( "vida_util_valor" IS NOT NULL
                                             AND "vida_util_valor" > 0
                                             AND "vida_util_unidad" IS NOT NULL
                                             AND "vida_util_unidad" IN ( 'DIAS', 'MESES', 'ANIOS', 'KM', 'HORAS' ) ) );

ALTER TABLE "componente_unidad"
    ADD CONSTRAINT ck_comp_lectura CHECK ( "lectura_inicio_uso" IS NULL
                                           OR "lectura_inicio_uso" >= 0 );

ALTER TABLE "componente_unidad"
    ADD CONSTRAINT ck_comp_fechas CHECK ( "fecha_vencimiento" IS NULL
                                          OR "fecha_inicio_uso" IS NULL
                                          OR "fecha_vencimiento" >= "fecha_inicio_uso" );

ALTER TABLE "componente_unidad"
    ADD CONSTRAINT ck_comp_instalacion CHECK ( "fecha_retiro" IS NULL
                                               OR "fecha_instalacion" IS NULL
                                               OR "fecha_retiro" >= "fecha_instalacion" );

ALTER TABLE "componente_unidad" ADD CONSTRAINT "PK_componente_unidad_id" PRIMARY KEY ( "id" );

ALTER TABLE "componente_unidad" ADD CONSTRAINT "UQ_componente_unidad_unidad_id_codigo" UNIQUE ( "unidad_id",
                                                                                                "codigo" );

CREATE TABLE "equipo_seriado" (
    "id"                      NUMBER(19) NOT NULL,
    "variante_id"             NUMBER(19) NOT NULL,
    "codigo_interno"          VARCHAR2(80) NOT NULL,
    "numero_serie"            VARCHAR2(150),
    "compania_propietaria_id" NUMBER(19),
    "compania_tenedora_id"    NUMBER(19),
    "ubicacion_id"            NUMBER(19),
    "bombero_actual_id"       NUMBER(19),
    "estado_material_id"      NUMBER(19) NOT NULL,
    "origen_id"               NUMBER(19),
    "observaciones"           CLOB,
    "fecha_alta"              TIMESTAMP DEFAULT systimestamp,
    "lote_ingreso_id"         NUMBER(19),
    "vida_util_valor"         NUMBER(14, 2),
    "vida_util_unidad"        VARCHAR2(10),
    "fecha_inicio_uso"        DATE,
    "lectura_inicio_uso"      NUMBER(14, 2),
    "fecha_vencimiento"       DATE,
    "propiedad_comandancia"   NUMBER(1) DEFAULT 0 NOT NULL
);

COMMENT ON COLUMN "equipo_seriado"."lote_ingreso_id" IS
    'Lote de origen del material. Permite mantener su trazabilidad en existencias, entregas, préstamos y devoluciones.';

COMMENT ON COLUMN "equipo_seriado"."vida_util_valor" IS
    'Vida útil de referencia. Un dato desconocido se conserva vacío.';

COMMENT ON COLUMN "equipo_seriado"."vida_util_unidad" IS
    'Unidad de la vida útil: DIAS, MESES, ANIOS, KM o HORAS.';

COMMENT ON COLUMN "equipo_seriado"."fecha_inicio_uso" IS
    'Fecha desde la que se considera el inicio de uso del elemento.';

COMMENT ON COLUMN "equipo_seriado"."lectura_inicio_uso" IS
    'Lectura inicial cuando la vida útil se expresa en kilómetros o en horas.';

COMMENT ON COLUMN "equipo_seriado"."fecha_vencimiento" IS
    'Vencimiento conocido o documentado. No implica un cálculo automático de depreciación.';

COMMENT ON COLUMN "equipo_seriado"."propiedad_comandancia" IS
    'Inventario propio de Comandancia, distinto de la consulta consolidada.';

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT ck_equipo_seriado_1 CHECK ( "numero_serie" IS NULL
                                               OR ( TRIM("numero_serie") <> ''
                                                    AND upper(TRIM("numero_serie")) NOT IN ( 'N/A', 'NA', '-' ) ) );

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT ck_equipo_vida CHECK ( ( "vida_util_valor" IS NULL
                                            AND "vida_util_unidad" IS NULL )
                                          OR ( "vida_util_valor" IS NOT NULL
                                               AND "vida_util_valor" > 0
                                               AND "vida_util_unidad" IS NOT NULL
                                               AND "vida_util_unidad" IN ( 'DIAS', 'MESES', 'ANIOS', 'KM', 'HORAS' ) ) );

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT ck_equipo_lectura CHECK ( "lectura_inicio_uso" IS NULL
                                             OR "lectura_inicio_uso" >= 0 );

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT ck_equipo_fechas CHECK ( "fecha_vencimiento" IS NULL
                                            OR "fecha_inicio_uso" IS NULL
                                            OR "fecha_vencimiento" >= "fecha_inicio_uso" );

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT ck_equipo_ambito_propietario CHECK ( ( "propiedad_comandancia" = 1
                                                          AND "compania_propietaria_id" IS NULL )
                                                        OR ( "propiedad_comandancia" = 0
                                                             AND "compania_propietaria_id" IS NOT NULL ) );

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

CREATE TABLE "lote_ingreso" (
    "id"                         NUMBER(19) NOT NULL,
    "variante_id"                NUMBER(19) NOT NULL,
    "compania_propietaria_id"    NUMBER(19),
    "movimiento_ingreso_id"      NUMBER(19),
    "codigo_lote"                VARCHAR2(80),
    "cantidad_inicial"           NUMBER(14) NOT NULL,
    "valor_unitario"             NUMBER(18, 2),
    "tipo_valor"                 VARCHAR2(16),
    "moneda"                     VARCHAR2(3),
    "fecha_adquisicion"          DATE,
    "documento_adquisicion"      VARCHAR2(250),
    "proveedor_nombre"           VARCHAR2(200),
    "vida_util_valor"            NUMBER(14, 2),
    "vida_util_unidad"           VARCHAR2(10),
    "fecha_inicio_uso"           DATE,
    "lectura_inicio_uso"         NUMBER(14, 2),
    "fecha_vencimiento"          DATE,
    "fecha_vencimiento_garantia" DATE,
    "documento_garantia"         VARCHAR2(250),
    "observaciones"              CLOB,
    "propiedad_comandancia"      NUMBER(1) DEFAULT 0 NOT NULL,
    "archivo_adquisicion"        VARCHAR2(250),
    "archivo_garantia"           VARCHAR2(250)
);

COMMENT ON TABLE "lote_ingreso" IS
    'Agrupa material de una misma recepción y conserva su valor, origen documental, garantía y vida útil sin fijar un precio único en el catálogo.'
    ;

COMMENT ON COLUMN "lote_ingreso"."id" IS
    'Identificador interno del lote de ingreso.';

COMMENT ON COLUMN "lote_ingreso"."variante_id" IS
    'Artículo y combinación de características recibidos en el lote.';

COMMENT ON COLUMN "lote_ingreso"."compania_propietaria_id" IS
    'Compañía o Comandancia propietaria del lote. La custodia se conserva por separado.';

COMMENT ON COLUMN "lote_ingreso"."movimiento_ingreso_id" IS
    'Movimiento original de recepción que respalda el ingreso del lote.';

COMMENT ON COLUMN "lote_ingreso"."codigo_lote" IS
    'Referencia del lote del proveedor o identificación interna de la recepción.';

COMMENT ON COLUMN "lote_ingreso"."cantidad_inicial" IS
    'Unidades recibidas inicialmente en el lote. Los saldos actuales se consultan en las existencias.';

COMMENT ON COLUMN "lote_ingreso"."valor_unitario" IS
    'Valor unitario de adquisición o de referencia. No se sustituye un importe desconocido por cero.';

COMMENT ON COLUMN "lote_ingreso"."tipo_valor" IS
    'Indica si el valor registrado corresponde a ADQUISICION o REFERENCIAL.';

COMMENT ON COLUMN "lote_ingreso"."moneda" IS
    'Código de moneda de tres letras. Los importes de monedas distintas no se suman sin conversión definida.';

COMMENT ON COLUMN "lote_ingreso"."fecha_adquisicion" IS
    'Fecha documentada de adquisición del elemento o lote.';

COMMENT ON COLUMN "lote_ingreso"."documento_adquisicion" IS
    'Número o referencia al documento que respalda la adquisición o el valor referencial.';

COMMENT ON COLUMN "lote_ingreso"."proveedor_nombre" IS
    'Proveedor informado en los antecedentes de adquisición, cuando exista.';

COMMENT ON COLUMN "lote_ingreso"."vida_util_valor" IS
    'Vida útil de referencia. Un dato desconocido se conserva vacío.';

COMMENT ON COLUMN "lote_ingreso"."vida_util_unidad" IS
    'Unidad de la vida útil: DIAS, MESES, ANIOS, KM o HORAS.';

COMMENT ON COLUMN "lote_ingreso"."fecha_inicio_uso" IS
    'Fecha desde la que se considera el inicio de uso del elemento.';

COMMENT ON COLUMN "lote_ingreso"."lectura_inicio_uso" IS
    'Lectura inicial cuando la vida útil se expresa en kilómetros o en horas.';

COMMENT ON COLUMN "lote_ingreso"."fecha_vencimiento" IS
    'Vencimiento conocido o documentado. No implica un cálculo automático de depreciación.';

COMMENT ON COLUMN "lote_ingreso"."fecha_vencimiento_garantia" IS
    'Fecha final de la garantía informada por el proveedor.';

COMMENT ON COLUMN "lote_ingreso"."documento_garantia" IS
    'Referencia al documento o respaldo de la garantía.';

COMMENT ON COLUMN "lote_ingreso"."observaciones" IS
    'Antecedentes complementarios del lote de ingreso.';

COMMENT ON COLUMN "lote_ingreso"."propiedad_comandancia" IS
    'Inventario propio de Comandancia, distinto de la consulta consolidada.';

COMMENT ON COLUMN "lote_ingreso"."archivo_adquisicion" IS
    'Ruta privada del adjunto de adquisición. La descarga valida permisos.';

COMMENT ON COLUMN "lote_ingreso"."archivo_garantia" IS
    'Ruta privada del adjunto de garantía, distinta de su referencia o número.';

CREATE INDEX ix_lote_codigo ON
    "lote_ingreso" (
        "codigo_lote"
    ASC );

ALTER TABLE "lote_ingreso"
    ADD CONSTRAINT ck_lote_valor CHECK ( "valor_unitario" IS NULL
                                         OR "valor_unitario" >= 0 );

ALTER TABLE "lote_ingreso"
    ADD CONSTRAINT ck_lote_moneda CHECK ( ( "valor_unitario" IS NULL
                                            AND "tipo_valor" IS NULL
                                            AND "moneda" IS NULL )
                                          OR ( "valor_unitario" IS NOT NULL
                                               AND "tipo_valor" IS NOT NULL
                                               AND "tipo_valor" IN ( 'ADQUISICION', 'REFERENCIAL' )
                                               AND "moneda" IS NOT NULL
                                               AND REGEXP_LIKE ( "moneda",
                                                                 '^[A-Z]{3}$' ) ) );

ALTER TABLE "lote_ingreso"
    ADD CONSTRAINT ck_lote_vida CHECK ( ( "vida_util_valor" IS NULL
                                          AND "vida_util_unidad" IS NULL )
                                        OR ( "vida_util_valor" IS NOT NULL
                                             AND "vida_util_valor" > 0
                                             AND "vida_util_unidad" IS NOT NULL
                                             AND "vida_util_unidad" IN ( 'DIAS', 'MESES', 'ANIOS', 'KM', 'HORAS' ) ) );

ALTER TABLE "lote_ingreso"
    ADD CONSTRAINT ck_lote_lectura CHECK ( "lectura_inicio_uso" IS NULL
                                           OR "lectura_inicio_uso" >= 0 );

ALTER TABLE "lote_ingreso"
    ADD CONSTRAINT ck_lote_fechas CHECK ( "fecha_vencimiento" IS NULL
                                          OR "fecha_inicio_uso" IS NULL
                                          OR "fecha_vencimiento" >= "fecha_inicio_uso" );

ALTER TABLE "lote_ingreso" ADD CONSTRAINT ck_lote_cantidad CHECK ( "cantidad_inicial" > 0 );

ALTER TABLE "lote_ingreso"
    ADD CONSTRAINT ck_lote_ambito_propietario CHECK ( ( "propiedad_comandancia" = 1
                                                        AND "compania_propietaria_id" IS NULL )
                                                      OR ( "propiedad_comandancia" = 0
                                                           AND "compania_propietaria_id" IS NOT NULL ) );

ALTER TABLE "lote_ingreso" ADD CONSTRAINT pk_lote_ingreso PRIMARY KEY ( "id" );

CREATE TABLE "mantenimiento" (
    "id"                    NUMBER(19) NOT NULL,
    "unidad_id"             NUMBER(19) NOT NULL,
    "componente_id"         NUMBER(19),
    "plan_control_id"       NUMBER(19),
    "proveedor_nombre"      VARCHAR2(200),
    "registrado_por_id"     NUMBER(19) NOT NULL,
    "tipo"                  VARCHAR2(15) NOT NULL,
    "estado_trabajo"        VARCHAR2(25) NOT NULL,
    "fecha_inicio"          DATE NOT NULL,
    "fecha_fin"             DATE,
    "descripcion"           CLOB NOT NULL,
    "falla_descripcion"     CLOB,
    "trabajo_realizado"     CLOB,
    "km_referencia"         NUMBER(16, 3),
    "horas_referencia"      NUMBER(16, 3),
    "referencia_servicio"   VARCHAR2(150),
    "observaciones"         CLOB,
    observaciones_iniciales CLOB,
    observaciones_finales   CLOB,
    pruebas_realizadas      CLOB,
    resultado_pruebas       CLOB,
    "costo_intervencion"    NUMBER(18, 2),
    "tipo_costo"            VARCHAR2(10),
    "moneda_costo"          VARCHAR2(3),
    "fecha_costo"           DATE,
    "documento_costo"       VARCHAR2(250)
);

COMMENT ON COLUMN "mantenimiento"."costo_intervencion" IS
    'Costo total documentado de la intervención o estimación, según tipo_costo. No se calcula una suma contable automáticamente.';

COMMENT ON COLUMN "mantenimiento"."tipo_costo" IS
    'Distingue el costo REAL del costo ESTIMADO.';

COMMENT ON COLUMN "mantenimiento"."moneda_costo" IS
    'Moneda en la que se registra el costo de la intervención.';

COMMENT ON COLUMN "mantenimiento"."fecha_costo" IS
    'Fecha del antecedente que respalda el costo registrado.';

COMMENT ON COLUMN "mantenimiento"."documento_costo" IS
    'Referencia de factura, presupuesto, orden de trabajo u otro respaldo del costo.';

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

ALTER TABLE "mantenimiento"
    ADD CONSTRAINT ck_mant_costo CHECK ( "costo_intervencion" IS NULL
                                         OR "costo_intervencion" >= 0 );

ALTER TABLE "mantenimiento"
    ADD CONSTRAINT ck_mant_moneda CHECK ( ( "costo_intervencion" IS NULL
                                            AND "tipo_costo" IS NULL
                                            AND "moneda_costo" IS NULL )
                                          OR ( "costo_intervencion" IS NOT NULL
                                               AND "tipo_costo" IS NOT NULL
                                               AND "tipo_costo" IN ( 'REAL', 'ESTIMADO' )
                                               AND "moneda_costo" IS NOT NULL
                                               AND REGEXP_LIKE ( "moneda_costo",
                                                                 '^[A-Z]{3}$' ) ) );

ALTER TABLE "mantenimiento" ADD CONSTRAINT "PK_mantenimiento_id" PRIMARY KEY ( "id" );

CREATE TABLE mantenimiento_evidencia (
    id                  NUMBER(19) NOT NULL,
    mantenimiento_id    NUMBER(19) NOT NULL,
    registrado_por_id   NUMBER(19) NOT NULL,
    tipo_etapa          VARCHAR2(25),
    nombre_archivo      VARCHAR2(255) NOT NULL,
    ruta_almacenamiento VARCHAR2(1000) NOT NULL,
    tipo_mime           VARCHAR2(120),
    tamano_bytes        NUMBER(19),
    creado_en           TIMESTAMP DEFAULT systimestamp,
    observaciones       CLOB
);

COMMENT ON TABLE mantenimiento_evidencia IS
    'RF-017, RF-018; RNF-008, RNF-017. Reunion CBSB 18-10-2026. Multiples evidencias por mantenimiento. Referencia interna de archivo, no URL publica. No sobrescribir historia. Almacenamiento y restauracion de archivos pendientes de validar. Etapas pendientes, sin CHECK cerrado.'
    ;

ALTER TABLE mantenimiento_evidencia ADD CONSTRAINT ck_mant_evidencia_tamano CHECK ( tamano_bytes >= 0 );

ALTER TABLE mantenimiento_evidencia ADD CONSTRAINT pk_mantenimiento_evidencia PRIMARY KEY ( id );

CREATE TABLE mantenimiento_validacion (
    id                     NUMBER(19) NOT NULL,
    mantenimiento_id       NUMBER(19) NOT NULL,
    responsable_usuario_id NUMBER(19) NOT NULL,
    tipo_validacion        VARCHAR2(35),
    resultado              VARCHAR2(30),
    observaciones          CLOB,
    fecha_validacion       TIMESTAMP DEFAULT systimestamp
);

COMMENT ON TABLE mantenimiento_validacion IS
    'RF-017, RF-018; RNF-008, RNF-017. Reunion CBSB 18-10-2026. Validaciones sucesivas independientes. Inspeccion tecnica y conformidad de recepcion son distintas. Estados, orden de aprobacion y cierre pendientes; no sustituir historia.'
    ;

ALTER TABLE mantenimiento_validacion ADD CONSTRAINT pk_mantenimiento_validacion PRIMARY KEY ( id );

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
    "observaciones"        CLOB,
    "lote_ingreso_id"      NUMBER(19)
);

COMMENT ON COLUMN "movimiento_detalle"."lote_ingreso_id" IS
    'Lote de origen del material. Permite mantener su trazabilidad en existencias, entregas, préstamos y devoluciones.';

ALTER TABLE "movimiento_detalle" ADD CONSTRAINT ck_movimiento_detalle_1 CHECK ( "cantidad" > 0 );

ALTER TABLE "movimiento_detalle"
    ADD CONSTRAINT ck_movimiento_detalle_2 CHECK ( "equipo_seriado_id" IS NULL
                                                   OR "cantidad" = 1 );

ALTER TABLE "movimiento_detalle" ADD CONSTRAINT "PK_movimiento_detalle_id" PRIMARY KEY ( "id" );

CREATE TABLE "movimiento_inventario" (
    "id"                        NUMBER(19) NOT NULL,
    "tipo_movimiento"           VARCHAR2(35) NOT NULL,
    "usuario_id"                NUMBER(19) NOT NULL,
    "compania_contexto_id"      NUMBER(19),
    "fecha_operacion"           TIMESTAMP DEFAULT systimestamp,
    "motivo"                    VARCHAR2(250),
    "observaciones"             CLOB,
    "referencia_externa"        VARCHAR2(100),
    transferencia_definitiva_id NUMBER(19),
    "fecha_ingreso"             DATE
);

COMMENT ON COLUMN "movimiento_inventario"."fecha_ingreso" IS
    'Fecha declarada de recepción del material. Se distingue de la fecha y hora de registro de la operación.';

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
    "observaciones"     CLOB,
    "lote_ingreso_id"   NUMBER(19)
);

COMMENT ON COLUMN "prestamo_detalle"."lote_ingreso_id" IS
    'Lote de origen del material. Permite mantener su trazabilidad en existencias, entregas, préstamos y devoluciones.';

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
    "compania_propietaria_id" NUMBER(19),
    "compania_tenedora_id"    NUMBER(19),
    "ubicacion_id"            NUMBER(19),
    "estado_material_id"      NUMBER(19) NOT NULL,
    "origen_id"               NUMBER(19),
    "cantidad_en_posicion"    NUMBER(14) DEFAULT 0,
    "fecha_alta"              TIMESTAMP DEFAULT systimestamp,
    "observaciones"           CLOB,
    "lote_ingreso_id"         NUMBER(19),
    "propiedad_comandancia"   NUMBER(1) DEFAULT 0 NOT NULL
);

COMMENT ON COLUMN "stock_posicion"."lote_ingreso_id" IS
    'Lote de origen del material. Permite mantener su trazabilidad en existencias, entregas, préstamos y devoluciones.';

COMMENT ON COLUMN "stock_posicion"."propiedad_comandancia" IS
    'Inventario propio de Comandancia, distinto de la consulta consolidada.';

ALTER TABLE "stock_posicion" ADD CONSTRAINT ck_stock_posicion_1 CHECK ( "cantidad_en_posicion" >= 0 );

ALTER TABLE "stock_posicion"
    ADD CONSTRAINT ck_stock_ambito_propietario CHECK ( ( "propiedad_comandancia" = 1
                                                         AND "compania_propietaria_id" IS NULL )
                                                       OR ( "propiedad_comandancia" = 0
                                                            AND "compania_propietaria_id" IS NOT NULL ) );

ALTER TABLE "stock_posicion" ADD CONSTRAINT "PK_stock_posicion_id" PRIMARY KEY ( "id" );

CREATE TABLE transferencia_definitiva (
    id                  NUMBER(19) NOT NULL,
    compania_destino_id NUMBER(19) NOT NULL,
    registrado_por_id   NUMBER(19) NOT NULL,
    fecha_registro      TIMESTAMP DEFAULT systimestamp,
    observaciones       CLOB,
    "estado"            VARCHAR2(12) DEFAULT 'HISTORICA' NOT NULL,
    "stock_origen_id"   NUMBER(19),
    "equipo_seriado_id" NUMBER(19),
    "cantidad"          NUMBER(10),
    "fecha_entrega"     DATE,
    "referencia"        VARCHAR2(100),
    "clave_solicitud"   VARCHAR2(32),
    "respondido_por_id" NUMBER(19),
    "fecha_respuesta"   TIMESTAMP,
    "motivo_respuesta"  VARCHAR2(1000)
);

COMMENT ON TABLE transferencia_definitiva IS
    'Envío definitivo de inventario propio de Comandancia. Pendiente reserva, aceptar mueve propiedad y saldos. Rechazar o cancelar libera la reserva.'
    ;

COMMENT ON COLUMN transferencia_definitiva."estado" IS
    'HISTORICA, PENDIENTE, ACEPTADA, RECHAZADA o CANCELADA. Se acepta la transferencia completa.';

COMMENT ON COLUMN transferencia_definitiva."stock_origen_id" IS
    'Posición propia de Comandancia que se reserva y entrega.';

COMMENT ON COLUMN transferencia_definitiva."equipo_seriado_id" IS
    'Equipo físico transferido. Su serie original se conserva.';

COMMENT ON COLUMN transferencia_definitiva."cantidad" IS
    'Unidades positivas de la transferencia nueva.';

COMMENT ON COLUMN transferencia_definitiva."fecha_entrega" IS
    'Fecha operativa del envío, distinta de la fecha de registro.';

COMMENT ON COLUMN transferencia_definitiva."referencia" IS
    'Referencia del envío cuando exista.';

COMMENT ON COLUMN transferencia_definitiva."clave_solicitud" IS
    'UUID de solicitud para impedir un envío duplicado.';

COMMENT ON COLUMN transferencia_definitiva."respondido_por_id" IS
    'Cuenta que acepta, rechaza o cancela, validada por ámbito.';

COMMENT ON COLUMN transferencia_definitiva."fecha_respuesta" IS
    'Momento de aceptación, rechazo o cancelación.';

COMMENT ON COLUMN transferencia_definitiva."motivo_respuesta" IS
    'Motivo de rechazo o cancelación y observaciones de la respuesta.';

ALTER TABLE transferencia_definitiva
    ADD CONSTRAINT ck_transferencia_datos CHECK ( "estado" = 'HISTORICA'
                                                  OR ( "estado" IN ( 'PENDIENTE', 'ACEPTADA', 'RECHAZADA', 'CANCELADA' )
                                                       AND "cantidad" IS NOT NULL
                                                       AND "cantidad" > 0
                                                       AND "clave_solicitud" IS NOT NULL
                                                       AND "fecha_entrega" IS NOT NULL
                                                       AND "stock_origen_id" IS NOT NULL ) );

ALTER TABLE transferencia_definitiva
    ADD CONSTRAINT ck_transferencia_respuesta CHECK ( ( "estado" IN ( 'HISTORICA', 'PENDIENTE' )
                                                        AND "fecha_respuesta" IS NULL
                                                        AND "respondido_por_id" IS NULL )
                                                      OR ( "estado" IN ( 'ACEPTADA', 'RECHAZADA', 'CANCELADA' )
                                                           AND "fecha_respuesta" IS NOT NULL
                                                           AND "respondido_por_id" IS NOT NULL ) );

ALTER TABLE transferencia_definitiva ADD CONSTRAINT pk_transferencia_definitiva PRIMARY KEY ( id );

ALTER TABLE transferencia_definitiva ADD CONSTRAINT uq_transferencia_solicitud UNIQUE ( "clave_solicitud" );

CREATE TABLE "ubicacion" (
    "id"                NUMBER(19) NOT NULL,
    "compania_id"       NUMBER(19),
    "tipo_ubicacion_id" NUMBER(19) NOT NULL,
    "unidad_id"         NUMBER(19),
    "padre_id"          NUMBER(19),
    "codigo"            VARCHAR2(80) NOT NULL,
    "nombre"            VARCHAR2(140) NOT NULL,
    "activo"            NUMBER(1) DEFAULT 1,
    "es_comandancia"    NUMBER(1) DEFAULT 0 NOT NULL
);

COMMENT ON COLUMN "ubicacion"."es_comandancia" IS
    'Lugar propio de Comandancia, sin compañía ficticia.';

CREATE UNIQUE INDEX uq_ubicacion_comandancia ON
    "ubicacion" (
        CASE
            WHEN
                "es_comandancia"
            = 1 THEN
                    "codigo"
        END
    );

ALTER TABLE "ubicacion"
    ADD CONSTRAINT ck_ubicacion_1 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "ubicacion"
    ADD CONSTRAINT ck_ubicacion_ambito CHECK ( ( "es_comandancia" = 1
                                                 AND "compania_id" IS NULL )
                                               OR ( "es_comandancia" = 0
                                                    AND "compania_id" IS NOT NULL ) );

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
    "activo"                             NUMBER(1) DEFAULT 1,
    "valor_adquisicion"                  NUMBER(18, 2),
    "tipo_valor"                         VARCHAR2(16),
    "moneda"                             VARCHAR2(3),
    "fecha_adquisicion"                  DATE,
    "documento_adquisicion"              VARCHAR2(250),
    "proveedor_nombre"                   VARCHAR2(200),
    "vida_util_valor"                    NUMBER(14, 2),
    "vida_util_unidad"                   VARCHAR2(10),
    "fecha_inicio_uso"                   DATE,
    "lectura_inicio_uso"                 NUMBER(14, 2),
    "fecha_vencimiento"                  DATE
);

COMMENT ON COLUMN "unidad"."valor_adquisicion" IS
    'Valor unitario de adquisición o de referencia. No se sustituye un importe desconocido por cero.';

COMMENT ON COLUMN "unidad"."tipo_valor" IS
    'Indica si el valor registrado corresponde a ADQUISICION o REFERENCIAL.';

COMMENT ON COLUMN "unidad"."moneda" IS
    'Código de moneda de tres letras. Los importes de monedas distintas no se suman sin conversión definida.';

COMMENT ON COLUMN "unidad"."fecha_adquisicion" IS
    'Fecha documentada de adquisición del elemento o lote.';

COMMENT ON COLUMN "unidad"."documento_adquisicion" IS
    'Número o referencia al documento que respalda la adquisición o el valor referencial.';

COMMENT ON COLUMN "unidad"."proveedor_nombre" IS
    'Proveedor informado en los antecedentes de adquisición, cuando exista.';

COMMENT ON COLUMN "unidad"."vida_util_valor" IS
    'Vida útil de referencia. Un dato desconocido se conserva vacío.';

COMMENT ON COLUMN "unidad"."vida_util_unidad" IS
    'Unidad de la vida útil: DIAS, MESES, ANIOS, KM o HORAS.';

COMMENT ON COLUMN "unidad"."fecha_inicio_uso" IS
    'Fecha desde la que se considera el inicio de uso del elemento.';

COMMENT ON COLUMN "unidad"."lectura_inicio_uso" IS
    'Lectura inicial cuando la vida útil se expresa en kilómetros o en horas.';

COMMENT ON COLUMN "unidad"."fecha_vencimiento" IS
    'Vencimiento conocido o documentado. No implica un cálculo automático de depreciación.';

ALTER TABLE "unidad"
    ADD CONSTRAINT ck_unidad_1 CHECK ( "activo" IN ( 0, 1 ) );

ALTER TABLE "unidad"
    ADD CONSTRAINT ck_unidad_2 CHECK ( "anio" IS NULL
                                       OR ( "anio" BETWEEN 1900 AND 2200 ) );

ALTER TABLE "unidad"
    ADD CONSTRAINT ck_unidad_valor CHECK ( "valor_adquisicion" IS NULL
                                           OR "valor_adquisicion" >= 0 );

ALTER TABLE "unidad"
    ADD CONSTRAINT ck_unidad_moneda CHECK ( ( "valor_adquisicion" IS NULL
                                              AND "tipo_valor" IS NULL
                                              AND "moneda" IS NULL )
                                            OR ( "valor_adquisicion" IS NOT NULL
                                                 AND "tipo_valor" IS NOT NULL
                                                 AND "tipo_valor" IN ( 'ADQUISICION', 'REFERENCIAL' )
                                                 AND "moneda" IS NOT NULL
                                                 AND REGEXP_LIKE ( "moneda",
                                                                   '^[A-Z]{3}$' ) ) );

ALTER TABLE "unidad"
    ADD CONSTRAINT ck_unidad_vida CHECK ( ( "vida_util_valor" IS NULL
                                            AND "vida_util_unidad" IS NULL )
                                          OR ( "vida_util_valor" IS NOT NULL
                                               AND "vida_util_valor" > 0
                                               AND "vida_util_unidad" IS NOT NULL
                                               AND "vida_util_unidad" IN ( 'DIAS', 'MESES', 'ANIOS', 'KM', 'HORAS' ) ) );

ALTER TABLE "unidad"
    ADD CONSTRAINT ck_unidad_lectura CHECK ( "lectura_inicio_uso" IS NULL
                                             OR "lectura_inicio_uso" >= 0 );

ALTER TABLE "unidad"
    ADD CONSTRAINT ck_unidad_fechas CHECK ( "fecha_vencimiento" IS NULL
                                            OR "fecha_inicio_uso" IS NULL
                                            OR "fecha_vencimiento" >= "fecha_inicio_uso" );

ALTER TABLE "unidad" ADD CONSTRAINT "PK_unidad_id" PRIMARY KEY ( "id" );

ALTER TABLE "unidad" ADD CONSTRAINT index_1v6 UNIQUE ( "codigo_institucional" );

ALTER TABLE "unidad" ADD CONSTRAINT index_2 UNIQUE ( "vin" );

ALTER TABLE "unidad" ADD CONSTRAINT index_3 UNIQUE ( "patente" );

ALTER TABLE "unidad" ADD CONSTRAINT "UQ_unidad_compania_id_codigo" UNIQUE ( "compania_id",
                                                                            "codigo" );

CREATE TABLE unidad_capacidad (
    id            NUMBER(19) NOT NULL,
    unidad_id     NUMBER(19) NOT NULL,
    capacidad_id  NUMBER(19) NOT NULL,
    observaciones CLOB,
    activo        NUMBER(1) DEFAULT 1
);

COMMENT ON TABLE unidad_capacidad IS
    'RF-013; RNF-008. Reunion CBSB 18-10-2026. Capacidad tecnica por unidad. Una asociacion por par. Historia de cambios mediante auditoria de aplicacion; no destruir antecedentes ni confundir capacidad con equipo existente.'
    ;

ALTER TABLE unidad_capacidad
    ADD CONSTRAINT ck_unidad_capacidad_activo CHECK ( activo IN ( 0, 1 ) );

ALTER TABLE unidad_capacidad ADD CONSTRAINT pk_unidad_capacidad PRIMARY KEY ( id );

ALTER TABLE unidad_capacidad ADD CONSTRAINT uq_unidad_capacidad UNIQUE ( unidad_id,
                                                                         capacidad_id );

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

ALTER TABLE "asignacion_equipo"
    ADD CONSTRAINT fk_asignacion_lote FOREIGN KEY ( "lote_ingreso_id" )
        REFERENCES "lote_ingreso" ( "id" );

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

ALTER TABLE checkin_respuesta
    ADD CONSTRAINT fk_checkin_respuesta_checkin FOREIGN KEY ( checkin_id )
        REFERENCES "checkin" ( "id" );

ALTER TABLE checkin_respuesta
    ADD CONSTRAINT fk_checkin_respuesta_item FOREIGN KEY ( checklist_item_id )
        REFERENCES checklist_item ( id );

ALTER TABLE "checkin"
    ADD CONSTRAINT "FK_checkin_unidad_id" FOREIGN KEY ( "unidad_id" )
        REFERENCES "unidad" ( "id" );

ALTER TABLE checklist_item
    ADD CONSTRAINT fk_checklist_item_tipo FOREIGN KEY ( tipo_unidad_id )
        REFERENCES "catalogo_valor" ( "id" );

ALTER TABLE checklist_item
    ADD CONSTRAINT fk_checklist_item_unidad FOREIGN KEY ( unidad_id )
        REFERENCES "unidad" ( "id" );

ALTER TABLE "componente_unidad"
    ADD CONSTRAINT "FK_componente_unidad_unidad_id" FOREIGN KEY ( "unidad_id" )
        REFERENCES "unidad" ( "id" );

ALTER TABLE "equipo_seriado"
    ADD CONSTRAINT fk_equipo_lote FOREIGN KEY ( "lote_ingreso_id" )
        REFERENCES "lote_ingreso" ( "id" );

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

ALTER TABLE "lote_ingreso"
    ADD CONSTRAINT fk_lote_movimiento FOREIGN KEY ( "movimiento_ingreso_id" )
        REFERENCES "movimiento_inventario" ( "id" );

ALTER TABLE "lote_ingreso"
    ADD CONSTRAINT fk_lote_propietaria FOREIGN KEY ( "compania_propietaria_id" )
        REFERENCES "compania" ( "id" );

ALTER TABLE "lote_ingreso"
    ADD CONSTRAINT fk_lote_variante FOREIGN KEY ( "variante_id" )
        REFERENCES "articulo_variante" ( "id" );

ALTER TABLE mantenimiento_evidencia
    ADD CONSTRAINT fk_mant_evidencia_mant FOREIGN KEY ( mantenimiento_id )
        REFERENCES "mantenimiento" ( "id" );

ALTER TABLE mantenimiento_evidencia
    ADD CONSTRAINT fk_mant_evidencia_usuario FOREIGN KEY ( registrado_por_id )
        REFERENCES "usuario" ( "id" );

ALTER TABLE mantenimiento_validacion
    ADD CONSTRAINT fk_mant_validacion_mant FOREIGN KEY ( mantenimiento_id )
        REFERENCES "mantenimiento" ( "id" );

ALTER TABLE mantenimiento_validacion
    ADD CONSTRAINT fk_mant_validacion_usuario FOREIGN KEY ( responsable_usuario_id )
        REFERENCES "usuario" ( "id" );

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
    ADD CONSTRAINT fk_movdet_lote FOREIGN KEY ( "lote_ingreso_id" )
        REFERENCES "lote_ingreso" ( "id" );

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

ALTER TABLE "movimiento_inventario"
    ADD CONSTRAINT fk_movimiento_transferencia FOREIGN KEY ( transferencia_definitiva_id )
        REFERENCES transferencia_definitiva ( id );

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

ALTER TABLE "prestamo_detalle"
    ADD CONSTRAINT fk_prestdet_lote FOREIGN KEY ( "lote_ingreso_id" )
        REFERENCES "lote_ingreso" ( "id" );

ALTER TABLE "regla_control"
    ADD CONSTRAINT "FK_regla_control_plan_control_id" FOREIGN KEY ( "plan_control_id" )
        REFERENCES "plan_control" ( "id" );

ALTER TABLE "stock_posicion"
    ADD CONSTRAINT fk_stock_lote FOREIGN KEY ( "lote_ingreso_id" )
        REFERENCES "lote_ingreso" ( "id" );

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

ALTER TABLE transferencia_definitiva
    ADD CONSTRAINT fk_transferencia_destino FOREIGN KEY ( compania_destino_id )
        REFERENCES "compania" ( "id" );

ALTER TABLE transferencia_definitiva
    ADD CONSTRAINT fk_transferencia_equipo FOREIGN KEY ( "equipo_seriado_id" )
        REFERENCES "equipo_seriado" ( "id" );

ALTER TABLE transferencia_definitiva
    ADD CONSTRAINT fk_transferencia_respuesta FOREIGN KEY ( "respondido_por_id" )
        REFERENCES "usuario" ( "id" );

ALTER TABLE transferencia_definitiva
    ADD CONSTRAINT fk_transferencia_stock_origen FOREIGN KEY ( "stock_origen_id" )
        REFERENCES "stock_posicion" ( "id" );

ALTER TABLE transferencia_definitiva
    ADD CONSTRAINT fk_transferencia_usuario FOREIGN KEY ( registrado_por_id )
        REFERENCES "usuario" ( "id" );

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

ALTER TABLE unidad_capacidad
    ADD CONSTRAINT fk_unidad_capacidad_capacidad FOREIGN KEY ( capacidad_id )
        REFERENCES capacidad ( id );

ALTER TABLE unidad_capacidad
    ADD CONSTRAINT fk_unidad_capacidad_unidad FOREIGN KEY ( unidad_id )
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
-- CREATE TABLE                            37
-- CREATE INDEX                             2
-- ALTER TABLE                            259
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
