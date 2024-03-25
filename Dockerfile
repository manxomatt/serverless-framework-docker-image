FROM node:14.16-alpine

# Install Serverless Framework
RUN npm install -g serverless@2.60.0

ENV GLIBC_VER=2.31-r0
ENV APK_CACHE_DIR=/var/cache/apk

RUN mkdir -p $APK_CACHE_DIR
# install glibc compatibility for alpine
# and install AWS CLI 2
ENV AWS_CLI_VER=2.0.30

RUN apk update && apk add --no-cache curl gcompat zip &&  \
    curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VER}.zip -o awscliv2.zip && \
    unzip awscliv2.zip && ./aws/install
    
#RUN apk --no-cache add \
#        binutils \
#        curl \
#    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
#    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
#    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    #&& apk add --no-cache \
    #    glibc-${GLIBC_VER}.apk \
    #    glibc-bin-${GLIBC_VER}.apk \
#    && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
#    && unzip awscliv2.zip \
#    && ./aws/install \
#    && rm -rf \
#        awscliv2.zip \
#        aws \
#        /usr/local/aws-cli/v2/*/dist/aws_completer \
#        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
#        /usr/local/aws-cli/v2/*/dist/awscli/examples \
    #&& apk --no-cache del \
    #    binutils \
    #    curl \
    #&& rm glibc-${GLIBC_VER}.apk \
    #&& rm glibc-bin-${GLIBC_VER}.apk \
    && rm -rf /var/cache/apk/*

RUN /usr/local/bin/aws --version
RUN /usr/local/bin/sls --version
