# Use Debian-based Node image to avoid MariaDB/Alpine issues
FROM node:18-bullseye

# Install MySQL server and bash
RUN apt-get update && \
    apt-get install -y mysql-server bash && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Copy package.json and install production dependencies
COPY package.json ./
RUN npm install --omit=dev --no-audit --no-fund

# Copy Node app source
COPY server.js ./

# Copy SQL initialization script
COPY mysql/init.sql /init.sql

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose Node and MySQL ports
EXPOSE 3000 3306

# Start both MySQL and Node
CMD ["/start.sh"]
