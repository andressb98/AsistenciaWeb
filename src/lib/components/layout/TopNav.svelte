<script lang="ts">
  import { can } from '$lib/auth/permissions';
  import type { SessionUser } from '../../../app';

  export let user: SessionUser | null;

  const actions = [
    { label: 'Crear empleado', href: '/empleados/nuevo', permiso: 'EMPLEADO_CREAR' },
    { label: 'Registrar asistencia', href: '/asistencias/nueva', permiso: 'ASISTENCIA_CREAR' },
    { label: 'Crear regla de alerta', href: '/alertas/reglas/nueva', permiso: 'REGLA_ALERTA_CREAR' },
    { label: 'Configuración', href: '/configuracion', permiso: 'EMPRESA_EDITAR' }
  ];
</script>

<header class="sticky top-0 z-20 bg-base-100/80 backdrop-blur border-b border-base-300">
  <div class="px-4 py-3 flex items-center justify-between gap-3">
    <!-- Left: breadcrumb -->
    <div class="flex items-center gap-2">
      <div class="text-base font-extrabold tracking-tight">AsistenciaWeb</div>
      <span class="opacity-40">/</span>
      <span class="font-semibold opacity-80">Panel</span>

      <!-- detalle visual -->
      <span class="badge badge-primary badge-outline ml-2 hidden sm:inline-flex">
        Activo
      </span>
    </div>

    <!-- Right -->
    <div class="flex items-center gap-3">
      <!-- Actions -->
      <div class="hidden md:flex items-center gap-2 flex-wrap justify-end">
        {#each actions as a}
          {#if !a.permiso || can(user, a.permiso)}
            <a class="btn btn-sm btn-ghost hover:btn-primary hover:text-primary-content transition rounded-xl"
               href={a.href}>
              {a.label}
            </a>
          {/if}
        {/each}
      </div>

      <!-- Compact actions menu (mobile) -->
      <div class="dropdown dropdown-end md:hidden">
        <label tabindex="0" class="btn btn-sm btn-ghost rounded-xl">Acciones</label>
        <ul tabindex="0" class="dropdown-content menu p-2 shadow bg-base-100 rounded-box w-56 border border-base-300">
          {#each actions as a}
            {#if !a.permiso || can(user, a.permiso)}
              <li><a href={a.href}>{a.label}</a></li>
            {/if}
          {/each}
        </ul>
      </div>

      <!-- Profile card -->
      <div class="flex items-center gap-3 pl-3 border-l border-base-300">
        <div class="text-right leading-tight hidden sm:block">
          <div class="font-bold">{user?.nombre ?? '—'}</div>
          <div class="text-xs opacity-70">Sucursal {user?.sucursalActivaId ?? '—'}</div>
        </div>

        <div class="avatar placeholder">
          <div class="w-10 rounded-2xl bg-secondary text-secondary-content font-bold shadow-sm">
            <span>{(user?.nombre?.[0] ?? 'U').toUpperCase()}</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</header>
