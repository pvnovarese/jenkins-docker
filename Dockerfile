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
    kubectl \
    buildctl \
    python3 && \
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    mkdir -p /usr/local/gcloud && \
    curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz && \
    tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz && \
    /usr/local/gcloud/google-cloud-sdk/install.sh --quiet --usage-reporting false --rc-path /var/jenkins_home/.bashrc --command-completion true --bash-completion true --path-update true --additional-components gke-gcloud-auth-plugin

## need to run 
## gcloud init
## gcloud container clusters get-credentials <cluster-name> --region=<region>
    
# Setting WORKDIR and USER 
USER jenkins
