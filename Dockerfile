# Build client
FROM node:14 AS client
WORKDIR /app/client
COPY client/package*.json ./
RUN npm ci
COPY client ./
RUN npm run build

# Build server
FROM node:14 AS server
WORKDIR /app/server
COPY server/package*.json ./
RUN npm ci --also=dev
COPY server ./
COPY --from=client /app/client/build ./public

# Start server
EXPOSE 5000
CMD ["npm", "start"]
