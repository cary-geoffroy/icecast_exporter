FROM golang:alpine AS build

WORKDIR /go/src/icecast_exporter

RUN apk add --no-cache git

COPY . /go/src/icecast_exporter

RUN go get .
RUN go build -buildvcs=false .

# Final stage
FROM alpine

COPY --from=build /go/src/icecast_exporter/icecast_exporter /icecast_exporter

EXPOSE 9146
USER nobody
ENTRYPOINT ["/icecast_exporter"]

