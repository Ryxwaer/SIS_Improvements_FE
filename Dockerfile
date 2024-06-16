# Stage 1: Build
FROM node:18-alpine as builder

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Serve
FROM node:18-alpine

WORKDIR /app

# Copy built files from the previous stage
COPY --from=builder /app/.output ./

# Install production dependencies
RUN npm install --production

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["node", "server/index.mjs"]
