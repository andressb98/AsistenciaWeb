import { redirect } from '@sveltejs/kit';
import type { PageServerLoad, Actions } from './$types';

export const load: PageServerLoad = async ({ locals }) => {
    // Mantener solo la protección de ruta
    if (!locals.user) throw redirect(302, '/login');

    return {
        empresaId: "temp-id-123", // IDs simulados para la vista
        sucursalId: null,
        onboardingComplete: false
    };
};

export const actions = {
    createSucursal: async () => {
        // Aquí iría la lógica de guardado
        return { success: true, sucursalId: "new-sucursal-id" };
    },
    
    createCategoria: async () => {
        return { success: true, categoriaId: "new-categoria-id" };
    },
    
    createEmpleado: async () => {
        // Simulamos la URL del QR que espera la vista
        const fakeQrCode = "QR-123456";
        return { 
            success: true, 
            empleadoId: "new-empleado-id",
            qrData: `/qr/${fakeQrCode}` 
        };
    }
} satisfies Actions;