FROM debian:12.5 as builder
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y git dos2unix
RUN apt-get install -y git python3.11 build-essential cmake autoconf autogen automake libtool pkg-config ragel wget

COPY . /src

WORKDIR /src

RUN git submodule update --init --recursive
RUN sed -i 's/ -mno-ieee-fp//g' modules/vorbis/configure.ac

RUN find ./scripts -type f -name "*.sh" -exec dos2unix {} \;
RUN chmod +x ./scripts/*.sh

RUN ./scripts/docker-init.sh
RUN ./scripts/release.sh

FROM scratch
COPY --from=builder /src/wasm /wasm