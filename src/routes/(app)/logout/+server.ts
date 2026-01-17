import { redirect, type RequestHandler } from '@sveltejs/kit';

export const GET: RequestHandler = async ({ cookies }) => {
  cookies.delete('session', { path: '/' });
  cookies.delete('sucursal_activa', { path: '/' });
  throw redirect(302, '/login');
};
