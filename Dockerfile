FROM node:18.9.0

WORKDIR /app

COPY package*.json ./

RUN npm i -g npm@8 @quasar/cli && npm i

COPY . .

EXPOSE 8080
