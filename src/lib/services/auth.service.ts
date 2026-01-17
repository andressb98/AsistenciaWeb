import { prisma } from '$lib/prisma';
import type { RegistroFormData } from '$lib/schemas/auth.schema';
import bcrypt from 'bcryptjs';

function makeCodigo(usuarioId: number, sucursalId: number, rolId: number) {
  return `U${usuarioId}-S${sucursalId}-R${rolId}-${Date.now()}`;
}

export async function crearCuentaCompleta(data: RegistroFormData) {
  return await prisma.$transaction(async (tx) => {
    // 1) validar que no exista correo
    const existe = await tx.usuario.findUnique({ where: { correo: data.correo } });
    if (existe) throw new Error('Este correo ya está registrado.');

    // 2) hash password
    const password_hash = await bcrypt.hash(data.password, 12);

    // 3) crear usuario
    const usuario = await tx.usuario.create({
      data: {
        nombre: data.nombre,
        correo: data.correo,
        password_hash,
        activo: true
      }
    });

    // 4) crear empresa
    const empresa = await tx.empresa.create({
      data: {
        dueno_usuario_id: usuario.id,
        nombre_comercial: data.nombreComercial,
        // si tu razon_social es String?:
        razon_social: data.razonSocial ?? null,
        activa: true
      }
    });

    // 5) crear sucursal default
    const sucursal = await tx.sucursal.create({
      data: {
        empresa_id: empresa.id,
        nombre: 'Sucursal Principal',
        direccion: 'Por configurar',
        telefono: '0000000000',
        activa: true
      }
    });

    // 6) rol OWNER
    const rolOwner = await tx.rol.findUnique({ where: { codigo: 'OWNER' } });
    if (!rolOwner) throw new Error('Rol OWNER no encontrado. Debes seedear roles primero.');

    // 7) asignar rol en sucursal
    await tx.usuario_rol_sucursal.create({
      data: {
        usuario_id: usuario.id,
        sucursal_id: sucursal.id,
        rol_id: rolOwner.id,
        codigo: makeCodigo(usuario.id, sucursal.id, rolOwner.id)
      }
    });

    return { usuario, empresa, sucursal };
  });
}

// Login con SQLite
export async function loginUsuario(correo: string, password: string) {
  const usuario = await prisma.usuario.findUnique({ where: { correo } });
  if (!usuario || !usuario.activo) return null;

  const ok = await bcrypt.compare(password, usuario.password_hash);
  if (!ok) return null;

  return usuario;
}
