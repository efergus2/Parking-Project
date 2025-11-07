# parking-project/backend/Dockerfile
FROM node:18-alpine
WORKDIR /usr/src/app

# copy only package.json first for layer caching
COPY package.json ./

# install production deps without dev deps (no package-lock required)
RUN npm install --omit=dev --no-audit --no-fund

# copy app source
COPY server.js ./

# expose port
EXPOSE 3000

CMD ["node", "server.js"]

