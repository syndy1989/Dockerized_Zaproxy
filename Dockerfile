FROM owasp/zap2docker-weekly

RUN sudo yum install -y docker

RUN docker images
