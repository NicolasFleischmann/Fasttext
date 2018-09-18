FROM ubuntu:xenial

RUN useradd docker \
	&& mkdir /home/docker \
	&& chown docker:docker /home/docker \
	&& addgroup docker staff

RUN apt-get update && apt-get install -y \
        build-essential \
        g++ \
        wget \
        git \
        python3 \
        python3-dev \
        python3-pip \
        unzip \
        locales \
        && rm -rf /var/cache/apk/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN git clone https://github.com/facebookresearch/fastText.git /home/docker/code && \
  cd /home/docker/code && \
  make

RUN python3 -m pip install pip --upgrade
ADD requirements.txt /home/docker/code/requirements.txt
RUN python3 -m pip install -r /home/docker/code/requirements.txt

ADD train_fasttext.sh /home/docker/code/train_fasttext.sh
ADD process_wikipedia.py /home/docker/code/process_wikipedia.py
WORKDIR /home/docker/code

CMD ["./train_fasttext.sh"]