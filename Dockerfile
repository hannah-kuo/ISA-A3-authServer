# Use Node.js as the base image
FROM node:14

# Set the working directory
WORKDIR /app

# Copy and install server dependencies
COPY server/package*.json ./server/
RUN cd server && npm ci

# Copy and install client dependencies
COPY client/package*.json ./client/
RUN cd client && npm ci

# Copy server source code
COPY server ./server

# Copy client source code and build the client app
COPY client ./client
RUN cd client && npm run build

# Move the client build folder to the server folder
RUN mv client/build server/public

# Expose the backend server port
EXPOSE 5000

# Start the server
CMD ["npm", "start", "--prefix", "server"]
