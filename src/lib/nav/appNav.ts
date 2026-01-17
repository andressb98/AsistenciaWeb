// src/lib/nav/appNav.ts
export type NavItem = {
  label: string;
  href: string;
  icon?: string; // placeholder (luego metes lucide o lo que uses)
  permissions?: string[]; // si no existe => visible para cualquier logueado
};

export type NavSection = {
  title: string;
  items: NavItem[];
};

export const NAV: NavSection[] = [
  {
    title: 'Core',
    items: [
      { label: 'Dashboard', href: '/dashboard' },

      { label: 'Asistencias', href: '/asistencias', permissions: ['ASISTENCIA_VER'] },
      { label: 'Faltas', href: '/faltas', permissions: ['FALTA_VER'] },
      { label: 'Alertas', href: '/alertas', permissions: ['ALERTA_VER', 'REGLA_ALERTA_VER'] },

      { label: 'Empleados', href: '/empleados', permissions: ['EMPLEADO_VER'] },
      { label: 'Roles y permisos', href: '/roles', permissions: ['ROL_VER', 'ROL_EDITAR'] }
    ]
  },

  {
    title: 'Administración',
    items: [
      { label: 'Sucursales', href: '/sucursales', permissions: ['SUCURSAL_VER'] },
      { label: 'Horarios / Turnos', href: '/horarios', permissions: ['DESCANSO_VER', 'DESCANSO_EDITAR'] },

      // Reportes: lo ligamos a ver asistencias o auditoría (ajústalo luego)
      { label: 'Reportes', href: '/reportes', permissions: ['ASISTENCIA_VER', 'BITACORA_VER'] },

      { label: 'Auditoría / Bitácora', href: '/bitacora', permissions: ['BITACORA_VER'] }
    ]
  },

  {
    title: 'Configuración',
    items: [
      { label: 'Configuración general', href: '/configuracion', permissions: ['EMPRESA_EDITAR', 'SUCURSAL_EDITAR'] },
      { label: 'Integraciones', href: '/integraciones', permissions: ['EMPRESA_EDITAR'] }
    ]
  },

  {
    title: 'Cuenta',
    items: [
      { label: 'Perfil', href: '/perfil' },
      { label: 'Cerrar sesión', href: '/logout' }
    ]
  }
];
