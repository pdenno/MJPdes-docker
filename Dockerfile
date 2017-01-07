FROM ubuntu:16.04
MAINTAINER Peter Denno <podenno@gmail.com>

ENV MJPDES_PATH $HOME/MJPdes
ENV RESULTS_PATH $HOME/results
ENV LEIN_ROOT=1

# This appears to be for 14.04 (trusty)
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0xb8d7f7791716c8a4
#RUN echo "deb     http://ppa.launchpad.net/mikegedelman/leiningen-git-stable/ubuntu trusty main" >> /etc/apt/sources.list
#RUN echo "deb-src http://ppa.launchpad.net/mikegedelman/leiningen-git-stable/ubuntu trusty main" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -yq curl default-jre 

RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/bin/lein
RUN chmod a+x /usr/bin/lein
RUN lein self-install

# Install MJPdes (I'll fork this before adding the compute stuff.)
RUN git clone https://github.com/usnistgov/MJPdes.git
WORKDIR $MJPDES_PATH
RUN lein deps
RUN lein bin

#VOLUME $RESULTS_PATH
CMD target/MJPdes resources/example.clj > $RESULTS_PATH/results.clj


