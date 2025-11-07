# Use Debian-based Node image
FROM node:18-bullseye

# Install MariaDB server and bash
RUN apt-get update && \
    apt-get install -y mariadb-server bash && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install --omit=dev --no-audit --no-fund

# Copy Node app source
COPY server.js ./

# Copy frontend public folder
COPY ../frontend/public /usr/src/app/public

# Copy SQL initialization script
COPY mysql/init.sql /init.sql

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose Node and MariaDB ports
EXPOSE 3000 3306

# Start both services
CMD ["/start.sh"]
