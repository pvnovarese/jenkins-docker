FROM jenkins/jenkins:alpine

MAINTAINER Paul Novarese <pvn@novarese.net>
LABEL maintainer="pvn@novarese.net"
LABEL name="jenkins-docker"
LABEL org.opencontainers.image.title="jenkins-docker"
LABEL org.opencontainers.image.description="alpine-based jenkins image with docker"

HEALTHCHECK --timeout=10s CMD /bin/true || exit 1

USER 0
# Installing required packages
RUN apk add --no-cache --upgrade \
    curl \
    wget \
    grep \
    jq \
    bash \
    bash-completion \
    git \
    openssh-client \
    docker \
    sudo \
    python3 && \
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    mkdir -p /usr/local/gcloud && \
    curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz && \
    tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz

## need to run /usr/local/gcloud/google-cloud-sdk/install.sh interactively and then run gcloud init

    
# Setting WORKDIR and USER 
USER jenkins
