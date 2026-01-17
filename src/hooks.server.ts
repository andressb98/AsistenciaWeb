import type { Handle } from '@sveltejs/kit';
import { verifySessionToken } from '$lib/auth/sessions';

export const handle: Handle = async ({ event, resolve }) => {
  event.locals.user = null; // siempre inicializa

  const token = event.cookies.get('session');
  if (token) {
    try {
      const payload = await verifySessionToken(token);
      event.locals.user = {
        id: Number(payload.sub),
        nombre: payload.name,
        correo: payload.email,
      };
    } catch {
      event.cookies.delete('session', { path: '/' });
      event.locals.user = null;
    }
  }

  return resolve(event);
};
