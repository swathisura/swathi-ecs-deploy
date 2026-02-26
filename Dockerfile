# Use Node.js 18 alpine with Python support
FROM node:18-alpine

# Install Python, make, g++ for native modules
RUN apk add --no-cache python3 make g++ && \
    ln -sf python3 /usr/bin/python

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