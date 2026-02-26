# Use Node.js 18 as base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY strapi-app/package*.json ./

# Install dependencies
RUN npm install

# Copy all strapi app files
COPY strapi-app/ .

# Build Strapi
RUN npm run build

# Expose Strapi port
EXPOSE 1337

# Start Strapi
CMD ["npm", "run", "start"]