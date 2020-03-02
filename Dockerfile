FROM node:12.16.1-alpine3.10

# Build docker using ## docker build --build-arg app_host=preTest -t nhs-strapi:1.0.0-rc1 .
# Pass arguments while building

ARG app_host=127.0.0.1
ARG db_name=strapi
ARG db_uri=nothing

RUN yarn global add pm2

WORKDIR /usr/src/app

COPY package*.json ./
COPY yarn.lock ./

# Server info
ENV APP_HOST=$app_host
ENV PORT=80
ENV NODE_ENV=production

# DB Info
ENV DATABASE_NAME=$db_name
ENV DATABASE_URI=$db_uri

RUN yarn install

COPY . .

RUN yarn build

EXPOSE 80

CMD [ "pm2-runtime", "./server.js" ]
