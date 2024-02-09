FROM node:12.18.4-alpine
This will be our base image for the container.

WORKDIR /app
This will be set as a working directory in the container.

ENV PATH /app/node_modules/.bin:$PATH
PATH variable is assigned a path to /app/node_modules/.bin.

COPY package.json ./
Package.json will be copied in the working directory of the container.

RUN npm install
Install dependencies.

COPY . ./

Copy files and folders with dependencies from the host machine to the container.

EXPOSE 3000
Allow to port 300 of the container.

CMD [“node”, “./src/server.js”]
Start the application
