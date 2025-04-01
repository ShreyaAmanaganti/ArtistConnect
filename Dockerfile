# Use official Node.js image as the base
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies (excluding bcrypt initially)
RUN npm install && npm cache clean --force

# Copy the rest of the backend files
COPY . .

# Rebuild bcrypt inside Docker to match its architecture
# RUN npm rebuild bcrypt --build-from-source
RUN npm install bcrypt --build-from-source

# Generate Prisma client
# RUN npx prisma generate
# RUN npx prisma generate --schema=prisma/schema.prisma





# RUN npm install -g prisma
# RUN npm install @prisma/client --save-dev
RUN npm install prisma@6.5.0 @prisma/client@6.5.0 --save-dev

# Run prisma generate
RUN npx prisma generate --schema=prisma/schema.prisma

# Expose the port the server runs on
EXPOSE 3001

# Start the backend server
CMD ["npm", "start"]





# # Use Node.js official image
# FROM node: 18

# # Set working directory
# WORKDIR /app

# # Copy package.json and package-lock.json first (for efficient caching)
# COPY package.json package-lock.json ./

# # Install dependencies explicitly before copying other files
# RUN npm install

# # Copy all project files (including prisma/)
# COPY . .

# # Ensure Prisma CLI is installed inside the container
# RUN npm install -g prisma
# RUN npm install @prisma/client --save-dev

# # Run prisma generate
# RUN npx prisma generate --schema=server/prisma/schema.prisma

# # Start the application
# CMD ["npm", "start"]

