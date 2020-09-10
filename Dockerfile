FROM node:13.6.0-alpine

ARG IMAGE_CREATE_DATE
ARG IMAGE_VERSION
ARG IMAGE_SOURCE_REVISION

# Metadata as defined in OCI image spec annotations - https://github.com/opencontainers/image-spec/blob/master/annotation.md
LABEL org.opencontainers.image.title="Hello Kubernetes!" \
      org.opencontainers.image.description="Provides a demo image to deploy to a Kubernetes cluster. It displays a mesage, the name of the pod and details of the node it is deployed to." \
      org.opencontainers.image.created=$IMAGE_CREATE_DATE \
      org.opencontainers.image.version=$IMAGE_VERSION \
      org.opencontainers.image.authors="Santhosh Reddy" \
      org.opencontainers.image.url="https://sanartifactory.jfrog.io/artifactory/docker-local/hello-kubernetes" \
      org.opencontainers.image.documentation="https://github.com/santhosh256/hello-kube/README.md" \
      org.opencontainers.image.vendor="santhosh256" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/santhosh256/hello-kube.git" \
      org.opencontainers.image.revision=$IMAGE_SOURCE_REVISION 

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

USER node
CMD [ "npm", "start" ]
