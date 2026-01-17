import { fail, redirect, isRedirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';
import { loginSchema } from '$lib/schemas/auth.schema';
import { loginUsuario } from '$lib/services/auth.service';
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
    // Si el usuario ya está autenticado, enviarlo al dashboard
    if (locals.user) throw redirect(302, '../dashboard');
    return {};
};

export const actions = {
    default: async ({ request, cookies }) => {
        const formData = await request.formData();
        const email = formData.get('email')?.toString() || '';
        const password = formData.get('password')?.toString() || '';

        const resultado = loginSchema.safeParse({ correo: email, password });
        if (!resultado.success) {
            const errores = resultado.error.flatten().fieldErrors;
            return fail(400, { error: 'Datos inválidos', errores });
        }

        try {
            const usuario = await loginUsuario(email, password);
            if (!usuario) {
                return fail(401, { error: 'Correo o contraseña incorrectos.' });
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

            throw redirect(302, '../dashboard');
        } catch (error) {
            if (isRedirect(error)) throw error; // <-- clave

            console.error('Error en login:', error);
            return fail(500, { error: error instanceof Error ? error.message : 'Error inesperado', valores: { email } });
        }

    }
} satisfies Actions;