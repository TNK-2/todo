# base image
FROM node:14.17.5-alpine3.14

# set working directory
WORKDIR /app

# copy project files and folders to the current working directory
COPY . .

# install dependencies
RUN npm install

# expose port
EXPOSE 3000

# start command
CMD ["npm", "start"]
