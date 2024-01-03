FROM node:18.18.0
ARG context ""
ARG DEFAULT_PORT 4010
ENV PORT=$DEFAULT_PORT
ENV context_env=$context
RUN mkdir -p /usr/src/
WORKDIR /usr/src/
COPY . /usr/src/
RUN npm install
RUN npm install -g cross-env nuxt
RUN npm run build
RUN npm run generate
COPY server.js dist/
RUN context_env=${context_env#/} && cd dist/ && mkdir $context_env && cp -r _nuxt $context_env && rm -rf _nuxt
WORKDIR /usr/src/dist
CMD ["node", "server.js"]
