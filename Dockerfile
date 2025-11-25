FROM node:18-alpine

# Install qpdf
RUN apk add --no-cache qpdf

# Install tini for proper signal handling
RUN apk add --no-cache tini

# Create app directory
WORKDIR /app

# Create data directory for temp files
RUN mkdir -p /app/data

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy app source
COPY . .

# Expose port
EXPOSE 3000

# Use tini as entrypoint for proper signal handling
ENTRYPOINT ["/sbin/tini", "--"]

# Start the server
CMD ["npm", "start"]
