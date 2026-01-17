<script lang="ts">
  import { page } from '$app/stores';
  import { NAV } from '$lib/nav/appNav';
  import { canAny } from '$lib/auth/permissions';
  import type { SessionUser } from '../../../app';

  export let user: SessionUser | null;

  function visible(item) {
    if (!item.permissions?.length) return true;
    return canAny(user, item.permissions);
  }
</script>

<aside class="h-full w-[280px] bg-base-100 border-r border-base-300">
  <!-- Brand -->
  <div class="p-4">
    <div class="flex items-center gap-3">
      <div class="avatar placeholder">
        <div class="w-11 rounded-2xl bg-primary text-primary-content font-extrabold shadow">
          <span>AW</span>
        </div>
      </div>

      <div class="leading-tight">
        <div class="text-lg font-extrabold tracking-tight text-base-content">
          AsistenciaWeb
        </div>
        <div class="text-sm opacity-70">Panel</div>
      </div>
    </div>
  </div>

  <!-- User Card -->
  <div class="px-4">
    <div class="card bg-base-200/60 border border-base-300 shadow-sm">
      <div class="card-body p-4">
        <div class="flex items-start justify-between gap-2">
          <div>
            <div class="font-bold text-base-content">{user?.nombre ?? '—'}</div>
            <div class="text-sm opacity-70 break-all">{user?.correo ?? '—'}</div>
          </div>

          <div class="badge badge-primary badge-outline">
            Sucursal {user?.sucursalActivaId ?? '—'}
          </div>
        </div>

        <div class="mt-2 flex flex-wrap gap-2">
          <!-- chips ejemplo (opcionales) -->
          <span class="badge badge-ghost">Roles</span>
          <span class="badge badge-ghost">Permisos</span>
          <span class="badge badge-ghost">Activa</span>
        </div>
      </div>
    </div>
  </div>

  <!-- Nav -->
  <nav class="px-2 py-4 overflow-auto h-[calc(100%-170px)]">
    {#each NAV as section}
      <div class="px-2 mt-3">
        <div class="text-xs font-bold uppercase tracking-wider opacity-60 mb-2">
          {section.title}
        </div>

        <ul class="menu menu-sm bg-transparent rounded-box p-0 gap-1">
          {#each section.items as item}
            {#if visible(item)}
              <li>
                <a
                  href={item.href}
                  class={`rounded-xl flex items-center gap-3 transition
                    ${$page.url.pathname.startsWith(item.href)
                      ? 'bg-primary/10 text-primary border border-primary/20 shadow-sm'
                      : 'hover:bg-base-200/70'}`}
                >
                  <!-- si luego metes iconos, aquí va -->
                  <span class="font-medium">{item.label}</span>
                </a>
              </li>
            {/if}
          {/each}
        </ul>
      </div>
    {/each}
  </nav>

  <!-- Footer mini -->
  <div class="p-4 border-t border-base-300">
    <div class="flex items-center justify-between text-sm opacity-70">
      <span>v0.1</span>
      <span class="badge badge-info badge-outline">skeleton</span>
    </div>
  </div>
</aside>
