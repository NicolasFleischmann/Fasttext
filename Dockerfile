FROM ubuntu:xenial

RUN useradd docker \
	&& mkdir /home/docker \
	&& chown docker:docker /home/docker \
	&& addgroup docker staff

RUN apt-get update && apt-get install -y \
        build-essential \
        wget \
        git \
        python-dev \
        unzip \
        python-numpy \
        python-scipy \
        locales \
        && rm -rf /var/cache/apk/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN git clone https://github.com/facebookresearch/fastText.git /home/docker/code && \
  cd /home/docker/code && \
  make

ADD train_fasttext.sh /home/docker/code/train_fasttext.sh
WORKDIR /home/docker/code

CMD ["./train_fasttext.sh"]