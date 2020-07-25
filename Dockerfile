FROM alpine:3.12 as base
LABEL maintainer="Brian Youngstrom <briany@briany.org>"
LABEL LAST_BUILD=2020-07-25-1627
RUN apk add --no-cache \
    rcon
ENTRYPOINT ["/usr/bin/rcon"]
