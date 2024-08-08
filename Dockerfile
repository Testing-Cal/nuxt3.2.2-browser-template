
# stage1 as builder
FROM node:20.11.1 as builder

# copy the package.json to install dependencies
COPY package.json ./

# Install the dependencies and make the folder
RUN npm install && mkdir /nuxt-ui && mv ./node_modules ./nuxt-ui

WORKDIR /nuxt-ui

COPY . .
COPY .env .
ARG CONTEXT='/'
RUN sed -i "s|"/\basepath"|"${CONTEXT}"|g" .env

# Build the project and copy the files
RUN context_env=${CONTEXT} npm run build
RUN context_env=${CONTEXT} npm run generate

FROM node:20.11.1
ARG CONTEXT='/'

#!/bin/sh
#RUN apk add sudo && addgroup -S lazsa && adduser -S -G root --uid 1001  lazsa
#RUN echo "lazsa ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/lazsa

# Copy from the stahg 1
COPY --from=builder /nuxt-ui/dist /nuxt-ui/dist
COPY ./server.js /nuxt-ui
WORKDIR /nuxt-ui

# USER lazsa
RUN npm install express
CMD context_env=${CONTEXT} node server.js