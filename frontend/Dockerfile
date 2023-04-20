# base image
FROM node:14.17.5-alpine3.14

# set working directory
WORKDIR /app

# copy package.json and package-lock.json
COPY package*.json ./

# install dependencies
RUN npm install

# copy project files and folders to the current working directory
COPY . .

# build the project
RUN npm run build

# expose port
EXPOSE 3000

# start command
CMD ["npm", "start"]
