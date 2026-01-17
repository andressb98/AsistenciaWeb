import { z } from 'zod';

// 1) Base sin refinements (permite pick)
export const registroBaseSchema = z.object({
  nombre: z.string().min(2, 'El nombre debe tener al menos 2 caracteres'),
  correo: z.string().email('Correo inválido'),
  password: z.string().min(8, 'Mínimo 8 caracteres'),
  confirmPassword: z.string(),
  nombreComercial: z.string().min(2, 'Nombre comercial requerido'),
  razonSocial: z.string().optional(),
});

// 2) Schema final (para submit) con refine
export const registroSchema = registroBaseSchema.refine(
  (data) => data.password === data.confirmPassword,
  {
    message: 'Las contraseñas no coinciden',
    path: ['confirmPassword'],
  }
);

// 3) Schemas por paso (solo lo necesario)
export const registroPaso1Schema = registroBaseSchema
  .pick({ nombre: true, correo: true, password: true, confirmPassword: true })
  .superRefine((data, ctx) => {
    if (data.password !== data.confirmPassword) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'Las contraseñas no coinciden',
        path: ['confirmPassword'],
      });
    }
  });

export const registroPaso2Schema = registroBaseSchema.pick({
  nombreComercial: true,
  razonSocial: true,
});

export const loginSchema = z.object({
  correo: z.string().email('Correo inválido'),
  password: z.string().min(1, 'Password requerido'),
});

export type RegistroFormData = z.infer<typeof registroSchema>;
