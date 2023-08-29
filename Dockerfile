# Dockerfile and comments written with help from the article:
# https://typeofnan.dev/how-to-serve-a-react-app-with-nginx-in-docker/

# Multi-stage Dockerfile
# 1) Node image for building frontend assets
# 2) nginx image to serve frontend assets

# First stage
FROM node:alpine AS builder
# Set working directory
WORKDIR /momentum-mentors
# Copy app files to working dir in image
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY public/ public
COPY src/ src
# Install node modules and build assets
RUN npm install && npm run build

# Second stage
FROM nginx:stable-alpine
# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html
# Remove default nginx static assets
RUN rm -rf ./*
# Copy static assets from builder stage
COPY --from=builder /momentum-mentors/build .
# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]
