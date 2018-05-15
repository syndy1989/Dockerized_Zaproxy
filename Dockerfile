FROM ubuntu:16.04

RUN apt-get update && apt-get install -q -y --fix-missing \
	make \
	automake \
	autoconf \
	gcc g++ \
	openjdk-8-jdk \
	ruby \
	wget \
	curl \
	xmlstarlet \
	unzip \
	git \
	openbox \
	xterm \
	net-tools \
	ruby-dev \
	python-pip \
	xvfb && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN gem install zapr
RUN pip install zapcli
# Install latest dev version of the python API
RUN pip install python-owasp-zap-v2.4

RUN mkdir /zap 
WORKDIR /zap

# Download and expand the latest stable release 
RUN curl -s https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions-dev.xml | xmlstarlet sel -t -v //url |grep -i Linux | wget --content-disposition -i - -O - | tar zxv && \
	cp -R ZAP*/* . &&  \
	rm -R ZAP* && \
	curl -s -L https://bitbucket.org/meszarv/webswing/downloads/webswing-2.3-distribution.zip > webswing.zip && \
	unzip *.zip && \
	rm *.zip && \
	touch AcceptedLicense


ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH $JAVA_HOME/bin:/zap/:$PATH
ENV ZAP_PATH /zap/zap.sh

# Default port for use with zapcli
ENV ZAP_PORT 8080
ENV HOME /home/zap/

COPY zap-x.sh /zap/ 
COPY zap-* /zap/ 
COPY zap_* /zap/ 
COPY webswing.config /zap/webswing-2.3/ 
COPY policies /home/zap/.ZAP/policies/
COPY .xinitrc /home/zap/

HEALTHCHECK --retries=5 --interval=5s CMD zap-cli status
