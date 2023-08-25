FROM node:alpine

WORKDIR /momentomori

COPY package.json package.json

COPY package-lock.json package-lock.json

RUN npm install

COPY public/ public

COPY src/ src

EXPOSE 3000

CMD npm start