export const PERMISOS = [
    {codigo: "EMPLEADO_VER", descripcion: "Ver empleados"},
    {codigo: "EMPLEADO_CREAR", descripcion: "Crear empleados"},
    {codigo: "EMPLEADO_EDITAR", descripcion: "Editar empleados"},
    {codigo: "EMPLEADO_ELIMINAR", descripcion: "Eliminar empleados"},

    {codigo: "ASISTENCIA_VER", descripcion: "Ver asistencias"},
    {codigo: "ASISTENCIA_CREAR", descripcion: "Registrar asistencias (manual/sistema)"},
    {codigo: "ASISTENCIA_EDITAR", descripcion: "Editar asistencias"},
    {codigo: "ASISTENCIA_ELIMINAR", descripcion: "Eliminar asistencias"},

    {codigo: "FALTA_VER", descripcion: "Ver faltas"},
    {codigo: "FALTA_CREAR", descripcion: "Crear/registrar faltas"},
    {codigo: "FALTA_EDITAR", descripcion: "Editar faltas"},
    {codigo: "FALTA_JUSTIFICAR", descripcion: "Justificar/validar faltas y permisos"},

    {codigo: "DESCANSO_VER", descripcion: "Ver descansos"},
    {codigo: "DESCANSO_CREAR", descripcion: "Crear descansos"},
    {codigo: "DESCANSO_EDITAR", descripcion: "Editar descansos"},
    {codigo: "DESCANSO_ELIMINAR", descripcion: "Eliminar descansos"},

    {codigo: "REGLA_ALERTA_VER", descripcion: "Ver reglas de alertas"},
    {codigo: "REGLA_ALERTA_CREAR", descripcion: "Crear reglas de alertas"},
    {codigo: "REGLA_ALERTA_EDITAR", descripcion: "Editar reglas de alertas"},
    {codigo: "REGLA_ALERTA_ELIMINAR", descripcion: "Eliminar reglas de alertas"},

    {codigo: "ALERTA_VER", descripcion: "Ver alertas"},
    {codigo: "ALERTA_MARCAR_LEIDA", descripcion: "Marcar alertas como leídas"},

    {codigo: "SUCURSAL_VER", descripcion: "Ver sucursal"},
    {codigo: "SUCURSAL_EDITAR", descripcion: "Editar configuración de sucursal"},

    {codigo: "EMPRESA_VER", descripcion: "Ver empresa"},
    {codigo: "EMPRESA_EDITAR", descripcion: "Editar configuración de empresa"},

    {codigo: "ROL_VER", descripcion: "Ver roles"},
    {codigo: "ROL_EDITAR", descripcion: "Asignar roles a usuarios"},

    {codigo: "BITACORA_VER", descripcion: "Ver bitácora/auditoría"},
] as const;

export const ROLES = [
    {codigo: "OWNER", nombre: "Propietario", descripcion: "Acceso total a la cuenta"},
    {codigo: "GERENTE", nombre: "Gerente", descripcion: "Administra la sucursal y valida incidencias"},
    {codigo: "SUPERVISOR", nombre: "Supervisor", descripcion: "Supervisa asistencias e incidencias básicas"},
] as const;

export const PERMISOS_POR_ROL: Record<(typeof ROLES)[number]["codigo"], string[]> = {
    OWNER: PERMISOS.map((p) => p.codigo),
    GERENTE: [
        "EMPLEADO_VER", "EMPLEADO_CREAR", "EMPLEADO_EDITAR",
        "ASISTENCIA_VER", "ASISTENCIA CREAR", "ASISTENCIA_EDITAR",
        "FALTA_VER", "FALTA_CREAR", "FALTA_EDITAR", "FALTA_JUSTIFICAR",
        "DESCANSO_VER", "DESCANSO_CREAR", "DESCANSO_EDITAR",
        "REGLA_ALERTA_VER", "REGLA_ALERTA_CREAR", "REGLA_ALERTA_EDITAR",
        "ALERTA_VER", "ALERTA_MARCAR_LEIDA",
        "SUCURSAL_VER", "SUCURSAL_EDITAR",
        "EMPRESA_VER",
        "BITACORA_VER",
    ],
    SUPERVISOR: [
        "EMPLEADO_VER",
        "ASISTENCIA_VER", "ASISTENCIA_CREAR",
        "FALTA_VER", "FALTA_CREAR",
        "DESCANSO_VER",
        "ALERTA_VER", "ALERTA_MARCAR_LEIDA",
        "SUCURSAL_VER",
    ],
};