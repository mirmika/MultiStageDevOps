FROM node:18-alpine

# Add the following lines
ENV CI=true
ENV WDS_SOCKET_PORT=0

ENV NODE_OPTIONS=--openssl-legacy-provider
WORKDIR /usr/app/client

COPY ./package.json ./
RUN npm install

COPY ./ ./

CMD [ "npm" ,"start" ]
