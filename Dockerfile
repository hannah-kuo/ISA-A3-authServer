# Build the client
FROM node:14 as client
WORKDIR /app/client
COPY client/package*.json ./
RUN npm install
COPY client ./
RUN npm run build

# Build the server
FROM node:14 as server
WORKDIR /app/server
COPY server/package*.json ./
RUN npm install --also=dev
COPY server ./

# Final Image
FROM node:14
COPY --from=client /app/client/build /app/client/build
COPY --from=server /app/server /app/server
WORKDIR /app/server
EXPOSE 5000
CMD ["npm", "start"]
