FROM ubuntu:focal as base
LABEL maintainer="Brian Youngstrom <briany@briany.org>"
LABEL LAST_BUILD=2020-07-23-1919
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt -y install \
    libglib2.0-0 \
    libbsd0

FROM base as build
#ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install --no-install-recommends \
    build-essential \
    ca-certificates \
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
RUN cmake -j 5 .. -DCMAKE_INSTALL_PREFIX=/usr
RUN make install

FROM base as run
COPY --from=build /usr/bin/rcon /usr/bin/rcon
COPY --from=build /usr/share/man/man1/rcon.1 /usr/share/man/man1/rcon.1
ENTRYPOINT ["/usr/bin/rcon"]
