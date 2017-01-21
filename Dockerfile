FROM ubuntu:16.04
MAINTAINER Peter Denno <podenno@gmail.com>

ENV MJPDES_PATH $HOME/MJPdes
ENV LEIN_ROOT=1

RUN apt-get update && apt-get install -yq curl default-jre git
RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/bin/lein
RUN chmod a+x /usr/bin/lein
RUN lein self-install

# Install MJPdes 
RUN git clone https://github.com/usnistgov/MJPdes.git
WORKDIR $MJPDES_PATH
RUN lein deps
RUN lein bin

COPY ./docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]





