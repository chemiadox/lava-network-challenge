FROM node:18-alpine AS base

# Install dependencies
FROM base AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci

# Build application
FROM base as builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
ARG database_url
ENV DATABASE_URL $database_url
RUN echo $DATABASE_URL
RUN npm i -D prisma
RUN npm run build

# Run application
FROM base as runner
ENV NODE_ENV production
COPY --from=builder /app/dist ./
COPY --from=builder /app/node_modules ./node_modules
CMD ["node", "index.js"]
