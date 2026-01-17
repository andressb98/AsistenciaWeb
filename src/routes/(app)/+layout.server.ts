import { redirect } from '@sveltejs/kit';
import type { LayoutServerLoad } from './$types';
import { buildSessionUser } from '$lib/server/auth/user-context';

// 🛡️ PROTEGE TODAS LAS RUTAS DENTRO DE (app)
export const load: LayoutServerLoad = async ({ locals, cookies }) => {
  if (!locals.user) {
    throw redirect(303, '/login');
  }

  const cookieSucursal = cookies.get('sucursalActiva');
  const sucursalActivaId = cookieSucursal ? Number(cookieSucursal) : null;

  const user = await buildSessionUser(locals.user.id, { sucursalActivaId });

  if (!user) {
    cookies.delete('session', { path: '/' });
    throw redirect(303, '/login');
  }

  if (user.sucursalActivaId && user.sucursalActivaId !== sucursalActivaId) {
    cookies.set('sucursalActiva', String(user.sucursalActivaId), {
      path: '/',
      httpOnly: true,
      sameSite: 'lax',
      secure: false
    });
  }

  return { user };
};