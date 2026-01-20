# Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npx prisma generate && npm run build

# Runtime stage
FROM node:18-alpine
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/package*.json ./
RUN npm ci --omit=dev
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma
EXPOSE 3000
CMD ["node", "dist/main.js"]
