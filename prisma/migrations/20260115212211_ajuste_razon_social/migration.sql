-- CreateTable
CREATE TABLE "asistencia" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "empleado_id" INTEGER NOT NULL,
    "sucursal_id" INTEGER NOT NULL,
    "fecha_hora" DATETIME NOT NULL,
    "tipo" TEXT NOT NULL,
    "fuente" TEXT NOT NULL,
    "comentario" TEXT,
    "justificada" BOOLEAN NOT NULL DEFAULT false,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "asistencia_empleado_id_fkey" FOREIGN KEY ("empleado_id") REFERENCES "empleado" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "asistencia_sucursal_id_fkey" FOREIGN KEY ("sucursal_id") REFERENCES "sucursal" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "categoria_dia_descanso" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "categoria_id" INTEGER NOT NULL,
    "dia_semana" TEXT NOT NULL,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "categoria_dia_descanso_categoria_id_fkey" FOREIGN KEY ("categoria_id") REFERENCES "categoria_puesto" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "categoria_puesto" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "sucursal_id" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,
    "tipo_descanso" TEXT NOT NULL,
    "misma_fecha_para_todos" BOOLEAN NOT NULL DEFAULT false,
    "semana_inicio_dia" INTEGER NOT NULL DEFAULT 0,
    "semana_fin_dia" INTEGER NOT NULL DEFAULT 6,
    "hora_entrada" INTEGER NOT NULL,
    "hora_salida" INTEGER NOT NULL,
    "tolerancia_retraso_min" INTEGER NOT NULL DEFAULT 5,
    "activo" TEXT NOT NULL DEFAULT 'ACTIVO',
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "categoria_puesto_sucursal_id_fkey" FOREIGN KEY ("sucursal_id") REFERENCES "sucursal" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "descanso_programado" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "empleado_id" INTEGER NOT NULL,
    "sucursal_id" INTEGER NOT NULL,
    "creado_por" INTEGER NOT NULL,
    "fecha" DATETIME NOT NULL,
    "origen" TEXT NOT NULL,
    "estado" TEXT NOT NULL DEFAULT 'PROGRAMADO',
    "comentario" TEXT,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "descanso_programado_empleado_id_fkey" FOREIGN KEY ("empleado_id") REFERENCES "empleado" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "descanso_programado_sucursal_id_fkey" FOREIGN KEY ("sucursal_id") REFERENCES "sucursal" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "descanso_programado_creado_por_fkey" FOREIGN KEY ("creado_por") REFERENCES "usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "empleado" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "sucursal_id" INTEGER NOT NULL,
    "categoria_id" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellido" TEXT NOT NULL,
    "correo" TEXT NOT NULL,
    "codigo_qr" TEXT NOT NULL,
    "estado" TEXT NOT NULL DEFAULT 'ACTIVO',
    "fecha_alta" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_baja" DATETIME,
    "dias_descanso_personalizado" INTEGER,
    "notas" TEXT,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "empleado_sucursal_id_fkey" FOREIGN KEY ("sucursal_id") REFERENCES "sucursal" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "empleado_categoria_id_fkey" FOREIGN KEY ("categoria_id") REFERENCES "categoria_puesto" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "empresa" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "dueno_usuario_id" INTEGER NOT NULL,
    "nombre_comercial" TEXT NOT NULL,
    "razon_social" TEXT,
    "rfc" TEXT,
    "estado" TEXT NOT NULL DEFAULT 'PRUEBA',
    "activa" BOOLEAN NOT NULL DEFAULT true,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "empresa_dueno_usuario_id_fkey" FOREIGN KEY ("dueno_usuario_id") REFERENCES "usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "falta" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "empleado_id" INTEGER NOT NULL,
    "sucursal_id" INTEGER NOT NULL,
    "validado_por" INTEGER,
    "fecha" DATETIME NOT NULL,
    "tipo" TEXT NOT NULL,
    "origen" TEXT NOT NULL,
    "justificada" BOOLEAN NOT NULL DEFAULT false,
    "comentario" TEXT,
    "validada_en" DATETIME,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "falta_empleado_id_fkey" FOREIGN KEY ("empleado_id") REFERENCES "empleado" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "falta_sucursal_id_fkey" FOREIGN KEY ("sucursal_id") REFERENCES "sucursal" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "falta_validado_por_fkey" FOREIGN KEY ("validado_por") REFERENCES "usuario" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "permiso" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "codigo" TEXT NOT NULL,
    "descripcion" TEXT,
    "activo" BOOLEAN NOT NULL DEFAULT true,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "rol" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "codigo" TEXT NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,
    "activo" BOOLEAN NOT NULL DEFAULT true,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "rol_permiso" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "rol_id" INTEGER NOT NULL,
    "permiso_id" INTEGER NOT NULL,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "rol_permiso_rol_id_fkey" FOREIGN KEY ("rol_id") REFERENCES "rol" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "rol_permiso_permiso_id_fkey" FOREIGN KEY ("permiso_id") REFERENCES "permiso" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "regla_alerta" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "sucursal_id" INTEGER NOT NULL,
    "creado_por" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "tipo" TEXT NOT NULL,
    "intervalo" INTEGER NOT NULL DEFAULT 7,
    "umbral" INTEGER NOT NULL DEFAULT 3,
    "dia_clave" TEXT,
    "activo" BOOLEAN NOT NULL DEFAULT true,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "regla_alerta_sucursal_id_fkey" FOREIGN KEY ("sucursal_id") REFERENCES "sucursal" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "regla_alerta_creado_por_fkey" FOREIGN KEY ("creado_por") REFERENCES "usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "sucursal" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "empresa_id" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "direccion" TEXT,
    "telefono" TEXT,
    "logo" TEXT,
    "tipo_logo" TEXT,
    "activa" BOOLEAN NOT NULL DEFAULT true,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "sucursal_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "suscripcion" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "empresa_id" INTEGER NOT NULL,
    "plan_id" INTEGER NOT NULL,
    "estado" TEXT NOT NULL DEFAULT 'PRUEBA',
    "fecha_inicio" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_fin" DATETIME,
    "origen" TEXT NOT NULL DEFAULT 'SISTEMA',
    "notas" TEXT,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "suscripcion_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "suscripcion_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "plan" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "telefono_empleado" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "empleado_id" INTEGER NOT NULL,
    "tipo" TEXT NOT NULL,
    "numero" TEXT NOT NULL,
    "es_principal" BOOLEAN NOT NULL DEFAULT false,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "telefono_empleado_empleado_id_fkey" FOREIGN KEY ("empleado_id") REFERENCES "empleado" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "usuario" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nombre" TEXT NOT NULL,
    "correo" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "activo" BOOLEAN NOT NULL DEFAULT true,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "usuario_rol_sucursal" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "usuario_id" INTEGER NOT NULL,
    "sucursal_id" INTEGER NOT NULL,
    "rol_id" INTEGER NOT NULL,
    "codigo" TEXT NOT NULL,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "usuario_rol_sucursal_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "usuario_rol_sucursal_sucursal_id_fkey" FOREIGN KEY ("sucursal_id") REFERENCES "sucursal" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "usuario_rol_sucursal_rol_id_fkey" FOREIGN KEY ("rol_id") REFERENCES "rol" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "alerta_empleado" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "regla_id" INTEGER NOT NULL,
    "empleado_id" INTEGER NOT NULL,
    "sucursal_id" INTEGER NOT NULL,
    "leida_por" INTEGER,
    "generado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "datos_calculo" JSONB,
    "leida_en" DATETIME,
    "estado" TEXT NOT NULL DEFAULT 'PENDIENTE',
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL,
    CONSTRAINT "alerta_empleado_regla_id_fkey" FOREIGN KEY ("regla_id") REFERENCES "regla_alerta" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "alerta_empleado_empleado_id_fkey" FOREIGN KEY ("empleado_id") REFERENCES "empleado" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "alerta_empleado_sucursal_id_fkey" FOREIGN KEY ("sucursal_id") REFERENCES "sucursal" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "alerta_empleado_leida_por_fkey" FOREIGN KEY ("leida_por") REFERENCES "usuario" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "bitacora" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "empresa_id" INTEGER,
    "sucursal_id" INTEGER,
    "usuario_id" INTEGER,
    "accion" TEXT NOT NULL,
    "detalle" TEXT,
    "severidad" TEXT NOT NULL DEFAULT 'INFO',
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "bitacora_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "bitacora_sucursal_id_fkey" FOREIGN KEY ("sucursal_id") REFERENCES "sucursal" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "bitacora_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "usuario" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "plan" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "codigo" TEXT NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,
    "max_sucursales_por_empresa" INTEGER NOT NULL DEFAULT 1,
    "max_categoria_por_sucursal" INTEGER NOT NULL DEFAULT 5,
    "max_empleados_por_sucursal" INTEGER NOT NULL DEFAULT 10,
    "max_gerentes_por_sucursal" INTEGER NOT NULL DEFAULT 1,
    "incluye_alertas" BOOLEAN NOT NULL DEFAULT false,
    "incluye_portal_empleado" BOOLEAN NOT NULL DEFAULT false,
    "limite_historial_meses" INTEGER NOT NULL DEFAULT 3,
    "activo" BOOLEAN NOT NULL DEFAULT true,
    "creado_en" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" DATETIME NOT NULL
);

-- CreateIndex
CREATE INDEX "asistencia_empleado_id_fecha_hora_idx" ON "asistencia"("empleado_id", "fecha_hora");

-- CreateIndex
CREATE INDEX "asistencia_sucursal_id_fecha_hora_idx" ON "asistencia"("sucursal_id", "fecha_hora");

-- CreateIndex
CREATE INDEX "categoria_dia_descanso_categoria_id_idx" ON "categoria_dia_descanso"("categoria_id");

-- CreateIndex
CREATE UNIQUE INDEX "categoria_dia_descanso_categoria_id_dia_semana_key" ON "categoria_dia_descanso"("categoria_id", "dia_semana");

-- CreateIndex
CREATE INDEX "categoria_puesto_sucursal_id_activo_idx" ON "categoria_puesto"("sucursal_id", "activo");

-- CreateIndex
CREATE INDEX "descanso_programado_empleado_id_fecha_idx" ON "descanso_programado"("empleado_id", "fecha");

-- CreateIndex
CREATE INDEX "descanso_programado_sucursal_id_fecha_idx" ON "descanso_programado"("sucursal_id", "fecha");

-- CreateIndex
CREATE UNIQUE INDEX "empleado_correo_key" ON "empleado"("correo");

-- CreateIndex
CREATE UNIQUE INDEX "empleado_codigo_qr_key" ON "empleado"("codigo_qr");

-- CreateIndex
CREATE INDEX "empleado_sucursal_id_estado_idx" ON "empleado"("sucursal_id", "estado");

-- CreateIndex
CREATE INDEX "empleado_categoria_id_idx" ON "empleado"("categoria_id");

-- CreateIndex
CREATE INDEX "empleado_correo_idx" ON "empleado"("correo");

-- CreateIndex
CREATE INDEX "empresa_dueno_usuario_id_idx" ON "empresa"("dueno_usuario_id");

-- CreateIndex
CREATE INDEX "empresa_activa_idx" ON "empresa"("activa");

-- CreateIndex
CREATE INDEX "empresa_estado_idx" ON "empresa"("estado");

-- CreateIndex
CREATE INDEX "falta_empleado_id_fecha_idx" ON "falta"("empleado_id", "fecha");

-- CreateIndex
CREATE INDEX "falta_sucursal_id_fecha_idx" ON "falta"("sucursal_id", "fecha");

-- CreateIndex
CREATE INDEX "falta_tipo_idx" ON "falta"("tipo");

-- CreateIndex
CREATE UNIQUE INDEX "permiso_codigo_key" ON "permiso"("codigo");

-- CreateIndex
CREATE UNIQUE INDEX "rol_codigo_key" ON "rol"("codigo");

-- CreateIndex
CREATE INDEX "rol_permiso_rol_id_idx" ON "rol_permiso"("rol_id");

-- CreateIndex
CREATE INDEX "rol_permiso_permiso_id_idx" ON "rol_permiso"("permiso_id");

-- CreateIndex
CREATE UNIQUE INDEX "rol_permiso_rol_id_permiso_id_key" ON "rol_permiso"("rol_id", "permiso_id");

-- CreateIndex
CREATE INDEX "regla_alerta_sucursal_id_activo_idx" ON "regla_alerta"("sucursal_id", "activo");

-- CreateIndex
CREATE INDEX "regla_alerta_tipo_idx" ON "regla_alerta"("tipo");

-- CreateIndex
CREATE INDEX "sucursal_empresa_id_idx" ON "sucursal"("empresa_id");

-- CreateIndex
CREATE INDEX "sucursal_activa_idx" ON "sucursal"("activa");

-- CreateIndex
CREATE INDEX "suscripcion_empresa_id_estado_idx" ON "suscripcion"("empresa_id", "estado");

-- CreateIndex
CREATE INDEX "suscripcion_plan_id_idx" ON "suscripcion"("plan_id");

-- CreateIndex
CREATE INDEX "telefono_empleado_empleado_id_idx" ON "telefono_empleado"("empleado_id");

-- CreateIndex
CREATE UNIQUE INDEX "telefono_empleado_empleado_id_tipo_numero_key" ON "telefono_empleado"("empleado_id", "tipo", "numero");

-- CreateIndex
CREATE UNIQUE INDEX "usuario_correo_key" ON "usuario"("correo");

-- CreateIndex
CREATE INDEX "usuario_activo_idx" ON "usuario"("activo");

-- CreateIndex
CREATE INDEX "usuario_correo_idx" ON "usuario"("correo");

-- CreateIndex
CREATE UNIQUE INDEX "usuario_rol_sucursal_codigo_key" ON "usuario_rol_sucursal"("codigo");

-- CreateIndex
CREATE INDEX "usuario_rol_sucursal_sucursal_id_idx" ON "usuario_rol_sucursal"("sucursal_id");

-- CreateIndex
CREATE UNIQUE INDEX "usuario_rol_sucursal_usuario_id_sucursal_id_rol_id_key" ON "usuario_rol_sucursal"("usuario_id", "sucursal_id", "rol_id");

-- CreateIndex
CREATE INDEX "alerta_empleado_empleado_id_estado_idx" ON "alerta_empleado"("empleado_id", "estado");

-- CreateIndex
CREATE INDEX "alerta_empleado_sucursal_id_generado_en_idx" ON "alerta_empleado"("sucursal_id", "generado_en");

-- CreateIndex
CREATE INDEX "alerta_empleado_leida_por_idx" ON "alerta_empleado"("leida_por");

-- CreateIndex
CREATE INDEX "bitacora_empresa_id_creado_en_idx" ON "bitacora"("empresa_id", "creado_en");

-- CreateIndex
CREATE INDEX "bitacora_sucursal_id_creado_en_idx" ON "bitacora"("sucursal_id", "creado_en");

-- CreateIndex
CREATE INDEX "bitacora_usuario_id_idx" ON "bitacora"("usuario_id");

-- CreateIndex
CREATE UNIQUE INDEX "plan_codigo_key" ON "plan"("codigo");

-- CreateIndex
CREATE INDEX "plan_activo_idx" ON "plan"("activo");
