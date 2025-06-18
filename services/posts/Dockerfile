FROM node:18-alpine

WORKDIR /usr/app/posts

COPY ./package.json ./
RUN npm install

COPY ./ ./

CMD [ "npm" ,"start" ]
