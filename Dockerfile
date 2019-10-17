ARG BASE_IMAGE

FROM ${BASE_IMAGE}

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=production
COPY . .

CMD [ "npm", "start" ]
