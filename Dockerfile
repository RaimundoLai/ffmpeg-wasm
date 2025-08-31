FROM debian:12.5 as builder
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y git dos2unix

COPY . /src

WORKDIR /src

RUN git submodule update --init --recursive

RUN find ./scripts -type f -name "*.sh" -exec dos2unix {} \;
RUN chmod +x ./scripts/*.sh

RUN ./scripts/docker-init.sh
RUN ./scripts/release.sh

FROM scratch
COPY --from=builder /src/wasm /wasm