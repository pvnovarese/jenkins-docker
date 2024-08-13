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
    kubectl \
    sudo \
    python3 && \
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

    
# Setting WORKDIR and USER 
USER jenkins
