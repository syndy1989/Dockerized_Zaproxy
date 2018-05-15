FROM owasp/zap2docker-weekly

RUN yum install -y docker

RUN docker images
