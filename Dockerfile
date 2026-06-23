# ==========================================
# Stage 1: Build & Cài đặt thư viện đầy đủ
# ==========================================
FROM node:20-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./

# Cài đặt toàn bộ thư viện (bao gồm cả devDependencies nếu có để build)
RUN npm ci

# Copy code nguồn
COPY . .

# ==========================================
# Stage 2: Môi trường chạy Production siêu nhẹ
# ==========================================
FROM node:20-alpine AS runner

WORKDIR /usr/src/app

# Chỉ copy các file cần thiết từ Stage 1 sang
COPY --from=builder /usr/src/app/package*.json ./
COPY --from=builder /usr/src/app/app.js ./

# Chỉ cài đặt thư viện cho Production để loại bỏ thư viện test/dev
RUN npm ci --only=production

# Bảo mật: Chạy ứng dụng dưới quyền user node (phi-root)
USER node

EXPOSE 8080

CMD ["node", "app.js"]