FROM jenkins/jenkins:lts-jdk11

USER root

# Install Docker
RUN apt-get update && \
    apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io

# Install Maven
RUN apt-get install -y maven

# Add Jenkins to docker group
RUN usermod -aG docker jenkins

USER jenkins

# Install plugins
RUN jenkins-plugin-cli --plugins "docker-workflow:1.29 git:4.11.3 workflow-aggregator:2.6"