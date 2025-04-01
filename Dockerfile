# Use official Node.js image as a build stage
FROM node:18-alpine AS builder

# Set working directory inside the container
WORKDIR /app

# Copy package files first for better caching
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --frozen-lockfile

# Copy the rest of the project files
COPY . .

# Build the Next.js project
RUN npm run build

# ----------- Production Stage -----------
FROM node:18-alpine AS runner

# Set working directory for production
WORKDIR /app

# Copy only necessary files from the builder stage
COPY --from=builder /app/package.json /app/package-lock.json ./
COPY --from=builder /app/.next .next
COPY --from=builder /app/public public
COPY --from=builder /app/node_modules node_modules

# Expose port 3000 for Next.js
EXPOSE 3000

# Run Next.js in production mode
CMD ["npm", "run", "start"]
