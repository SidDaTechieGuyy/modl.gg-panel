FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM caddy:2-alpine
COPY --from=builder /app/dist /usr/share/caddy
EXPOSE 3000
CMD ["caddy", "file-server", "--root", "/usr/share/caddy", "--listen", "0.0.0.0:3000"]
