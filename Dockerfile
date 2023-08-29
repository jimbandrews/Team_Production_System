FROM node:alpine AS builder

WORKDIR /momentomori

COPY package.json package.json

COPY package-lock.json package-lock.json

COPY public/ public

COPY src/ src

RUN npm install

RUN npm run build


FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /momentomori/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]
