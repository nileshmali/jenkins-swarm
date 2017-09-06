FROM openjdk:8-jdk-alpine

USER root

RUN apk update && \
	apk upgrade && \
	apk add curl && \
	apk add git && \
	apk add docker

# Create workspace directory for Jenkins
RUN mkdir /workspace && \
	chmod 777 /workspace

ENV JENKINS_SWARM_VERSION 3.4

# Download the latest Jenkins swarm client with curl
# Browse all versions here: https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/
RUN curl -O https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION.jar

COPY cmd.sh /cmd.sh

CMD ["cmd.sh"]
