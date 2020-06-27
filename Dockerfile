FROM ubuntu:focal as base
LABEL maintainer="Brian Youngstrom <briany@briany.org>"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt -y install \
    libglib2.0-0 \
    libbsd0

FROM base as build
#ENV DEBIAN_FRONTEND=noninteractive
RUN apt -y install \
    build-essential \
    check \
    cmake \
    git \
    libbsd-dev \
    libglib2.0-dev
RUN mkdir /build
WORKDIR /build
RUN git clone https://github.com/n0la/rcon.git 
RUN mkdir /build/rcon/build
WORKDIR /build/rcon/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/usr
RUN make install

FROM base as run
COPY --from=build /usr/bin/rcon /usr/bin/rcon
COPY --from=build /usr/share/man/man1/rcon.1 /usr/share/man/man1/rcon.1
ENTRYPOINT ["/usr/bin/rcon"]
