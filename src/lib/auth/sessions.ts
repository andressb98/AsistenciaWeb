import { SignJWT, jwtVerify } from 'jose';

const SECRET = new TextEncoder().encode(process.env.AUTH_SECRET || 'dev-secret-change-me');

export type SessionPayload = {
  sub: string;       // user id
  email: string;
  name: string;
};

export async function createSessionToken(payload: SessionPayload) {
  return await new SignJWT(payload)
    .setProtectedHeader({ alg: 'HS256' })
    .setIssuedAt()
    .setExpirationTime('7d')
    .sign(SECRET);
}

export async function verifySessionToken(token: string) {
  const { payload } = await jwtVerify(token, SECRET);
  return payload as unknown as SessionPayload;
}
