# Use the official Node.js 14 image as a base
FROM node:14 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the remaining application code to the container
COPY . .

# Build the React app
RUN npm run build

# Create a new stage for the production image
FROM nginx:alpine

# Copy the build output from the build stage to the nginx server root directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
