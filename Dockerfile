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
  docker \
	openbox \
	xterm \
	net-tools \
	ruby-dev \
	python-pip \
	xvfb && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

CMD docker images
