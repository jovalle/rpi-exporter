FROM --platform=$BUILDPLATFORM golang:1.13 AS build
LABEL maintainer="Jay Ovalle <jay.ovalle@gmail.com>"
ARG TARGETARCH
ENV GOARCH=$TARGETARCH
RUN go get github.com/jovalle/rpi-exporter && \
  cd /go/src/github.com/jovalle/rpi-exporter && \
  make build

FROM debian
LABEL maintainer="Jay Ovalle <jay.ovalle@gmail.com"
COPY --from=build /go/src/github.com/jovalle/rpi-exporter/rpi-exporter /bin/rpi-exporter
EXPOSE 9243
ENTRYPOINT ["/bin/rpi-exporter"]