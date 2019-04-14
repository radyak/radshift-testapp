ARG BASE_IMAGE

FROM ${BASE_IMAGE}

COPY ./qemu-arm-static /usr/bin/qemu-arm-static

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=production
COPY . .

CMD [ "npm", "start" ]
