import { PERMISOS } from '$lib/auth/acl'

declare global {
	namespace App {
		interface Locals {
			user: {
				id: number;
				nombre: string;
				correo: string;
			} | null;
		}
		// interface Error {}
		// interface Locals {}
		// interface PageData {}
		// interface PageState {}
		// interface Platform {}
		interface PageData {
			user: SessionUseer | null;
		}
	}

}
export type PermisoCodigo =(typeof PERMISOS)[number]["codigo"];

export type UserSucursalRol = {
  sucursal_id: number;
  rol_codigo: string;
  rol_nombre: string;
};

export type SessionUser  = {
	id: number;
	nombre: string;
	correo: string;

	sucursalActivaId: number | null;
	rolesPorSucursal: UserSucursalRol[];
	permisos: string[];
};

export { };
