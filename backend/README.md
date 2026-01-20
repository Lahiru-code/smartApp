# smartapp-backend (NestJS)

Minimal NestJS starter wired for the smartApp project.

## Prerequisites
- Node.js 18+
- npm (default) or yarn/pnpm

## Setup
```bash
cd backend
npm install
npm run start:dev
```
The API will listen on `http://localhost:3000` by default (override with `PORT`).

## Scripts
- `npm run start:dev` — run with watch + hot reload
- `npm run build` — compile to `dist`
- `npm run start:prod` — run compiled build
- `npm test` — run unit tests
- `npm run lint` — lint TypeScript sources

## Project layout
- `src/main.ts` — app bootstrap
- `src/app.module.ts` — root module
- `src/app.controller.ts` — sample routes (`/health`, `/`)
- `src/app.service.ts` — sample business logic
- `src/app.controller.spec.ts` — example unit tests

## Environment
Copy `.env.example` to `.env` and adjust values as needed. Defaults use SQLite for local dev via Prisma.

## Prisma (SQLite)
```bash
npm run prisma:generate
npm run prisma:migrate -- --name init
```

## API docs
Swagger UI available at `http://localhost:3000/docs`.

## Sensors & IoT
Backend supports real-time sensor data with REST + WebSocket.

**Devices:**
- Create: `POST /sensors/devices` (auth required) `{ name, type }`
- List: `GET /sensors/devices` (auth required)

**Readings:**
- Add: `POST /sensors/devices/:deviceId/readings` `{ value, unit }`
- Query: `GET /sensors/devices/:deviceId/readings?limit=100&from=ISO8601&to=ISO8601`
- Latest: `GET /sensors/devices/:deviceId/latest`

**WebSocket (real-time):**
- Connect to `ws://localhost:3000`
- Emit `subscribe` with deviceId to get live readings
- Listen for `reading` events

**Hardware Integration:**
- See `scripts/hardware_simulator.py` or `.js` for examples
- Arduino/ESP32: POST readings every N seconds with device token

## Auth
- Register: `POST /auth/register` `{ email, password }`
- Login: `POST /auth/login` `{ email, password }` (returns `access_token`)
- Me: `GET /auth/me` with `Authorization: Bearer <token>`

## Next steps
- Switch `DATABASE_URL` to Postgres for staging/prod and run migrations.
- Add feature modules (domain logic) and tests.
- Add CI and deploy via Docker.
