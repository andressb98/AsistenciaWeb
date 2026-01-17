// src/lib/server/auth/user-context.ts
import { prisma } from '$lib/prisma';
import type { SessionUser, UserSucursalRol } from '../../../app';

export async function buildSessionUser(userId: number, opts?: { sucursalActivaId?: number | null }) {
  // 1) Usuario base
  const usuario = await prisma.usuario.findUnique({
    where: { id: userId },
    select: { id: true, nombre: true, correo: true, activo: true }
  });

  if (!usuario || !usuario.activo) return null;

  // 2) Roles por sucursal (usuario_rol_sucursal -> rol)
  const asignaciones = await prisma.usuario_rol_sucursal.findMany({
    where: { usuario_id: userId },
    select: {
      sucursal_id: true,
      rol: { select: { codigo: true, nombre: true } }
    }
  });

  const rolesPorSucursal: UserSucursalRol[] = asignaciones.map((a) => ({
    sucursal_id: a.sucursal_id,
    rol_codigo: a.rol.codigo,
    rol_nombre: a.rol.nombre
  }));

  // 3) Determinar sucursal activa:
  // - si viene en cookie y el user tiene rol en esa sucursal, úsala
  // - si no, toma la primera sucursal asignada
  const sucursalPreferida = opts?.sucursalActivaId ?? null;

  const tienePreferida =
    sucursalPreferida != null && rolesPorSucursal.some((r) => r.sucursal_id === sucursalPreferida);

  const sucursalActivaId =
    tienePreferida ? sucursalPreferida : (rolesPorSucursal[0]?.sucursal_id ?? null);

  // 4) Permisos efectivos (unión de permisos de roles en la sucursal activa)
  //    usuario_rol_sucursal -> rol -> rol_permiso -> permiso
  let permisos: string[] = [];
  if (sucursalActivaId != null) {
    const rows = await prisma.usuario_rol_sucursal.findMany({
      where: { usuario_id: userId, sucursal_id: sucursalActivaId },
      select: {
        rol: {
          select: {
            permisos: {
              select: {
                permiso: { select: { codigo: true, activo: true } }
              }
            }
          }
        }
      }
    });

    const set = new Set<string>();
    for (const r of rows) {
      for (const rp of r.rol.permisos) {
        if (rp.permiso.activo) set.add(rp.permiso.codigo);
      }
    }
    permisos = Array.from(set);
  }

  const sessionUser: SessionUser = {
    id: usuario.id,
    nombre: usuario.nombre,
    correo: usuario.correo,
    sucursalActivaId,
    rolesPorSucursal,
    permisos
  };

  return sessionUser;
}
