import type {SessionUser } from '../../app';

export function can(user: SessionUser  | null, permiso: string){
    if(!user) return false;
    return user.permisos?.includes(permiso) ?? false;
}

export function canAny(user: SessionUser  | null, permisos: string[]){
    if(!user) return false;
    return permisos.some((p) => user.permisos?.includes(p));
}

export function canAll(user: SessionUser  | null, permisos: string[]){
    if(!user) return false;
    return permisos.every((p) => user.permisos?.includes(p));
}
