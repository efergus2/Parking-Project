# parking-project/backend/Dockerfile
FROM node:18-alpine

# Install bash, MySQL server, and required tools
RUN apk add --no-cache bash mysql mysql-client

WORKDIR /usr/src/app

# Copy package.json and install deps
COPY package.json ./
RUN npm install --omit=dev --no-audit --no-fund

# Copy app source
COPY server.js ./

# Copy SQL initialization script
COPY ../mysql/init.sql /init.sql

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose Node and MySQL ports
EXPOSE 3000 3306

# Start both MySQL and Node
CMD ["/start.sh"]
