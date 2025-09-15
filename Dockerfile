# Stage 1: Build the React app
FROM node:14-buster AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first (for better caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the source
COPY . .

# Build the production version of the app
RUN npm run build

# Stage 2: Serve with a lightweight web server
FROM nginx:alpine

# Copy build output to nginx html folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
