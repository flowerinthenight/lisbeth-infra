FROM golang

ADD . /go/src/github.com/flowerinthenight/lisbeth-infra/cheatd/
WORKDIR /go/src/github.com/flowerinthenight/lisbeth-infra/cheatd/
RUN go build -v
ENTRYPOINT ["/go/src/github.com/flowerinthenight/lisbeth-infra/cheatd/cheatd"]
# CMD ["serve", "--keep-alive=true"]

EXPOSE 8080
