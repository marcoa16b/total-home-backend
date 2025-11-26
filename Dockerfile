# Use Node.js 20
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install all dependencies with npm (including devDependencies for build)
RUN npm ci

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Change to the production build directory
WORKDIR .medusa/server

# Install only production dependencies in the build directory
RUN npm ci --only=production

# Expose port
EXPOSE 9000

# Start the application
CMD ["npm", "run", "start"]