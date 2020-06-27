FROM ubuntu:focal as base
LABEL maintainer="Brian Youngstrom <briany@briany.org>"

FROM base as build
RUN apt-get update && \
    apt-get -y install \
    build-essential \
    check \
    cmake \
    git \
    libbsd-dev \
    libglib2.0-dev
RUN mkdir /build
RUN cd /build
RUN git clone https://github.com/n0la/rcon.git .
RUN cmake . -DCMAKE_INSTALL_PREFIX=/usr
RUN sudo make install

FROM base as run
COPY --from=build /usr/bin/rcon /usr/bin/rcon
