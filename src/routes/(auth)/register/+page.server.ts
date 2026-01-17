import { fail, redirect, isRedirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';
import { registroSchema } from '$lib/schemas/auth.schema';
import { crearCuentaCompleta, loginUsuario } from '$lib/services/auth.service';
import { createSessionToken } from '$lib/auth/sessions';


// helpers (los tuyos)
function formDataToObject(formData: FormData) {
  const obj: Record<string, string> = {};
  for (const [key, value] of formData.entries()) obj[key] = typeof value === 'string' ? value : '';
  return obj;
}
function normalize(data: Record<string, string>) {
  return { ...data, razonSocial: data.razonSocial?.trim() ? data.razonSocial.trim() : undefined };
}

export const load: PageServerLoad = async ({ locals }) => {
  if (locals.user) throw redirect(303, '/dashboard');
  return {};
};

export const actions: Actions = {
  default: async ({ request, cookies }) => {
    const formData = await request.formData();
    const raw = formDataToObject(formData);
    const data = normalize(raw);

    const resultado = registroSchema.safeParse(data);
    if (!resultado.success) {
      const errores = resultado.error.flatten().fieldErrors;
      return fail(400, { error: 'Datos inválidos', errores, valores: raw });
    }

    try {
      await crearCuentaCompleta(resultado.data);

      const usuario = await loginUsuario(resultado.data.correo, resultado.data.password);
      if (!usuario) {
        return fail(500, { error: 'No se pudo iniciar sesión automáticamente.', valores: raw });
      }

      // JWT session
      const token = await createSessionToken({
        sub: String(usuario.id),
        email: usuario.correo,
        name: usuario.nombre
      });

      cookies.set('session', token, {
        path: '/',
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'lax',
        maxAge: 60 * 60 * 24 * 7
      });

      throw redirect(303, '/dashboard');
    } catch (error) {
      if (isRedirect(error)) throw error; // <-- clave

      console.error('Error en registro:', error);
      return fail(500, {
        error: error instanceof Error ? error.message : 'Error inesperado',
        valores: raw
      });
    }
  }
} satisfies Actions;
