#just test
FROM debian:wheezy      

RUN apt-get update && apt-get install --no-install-recommends -y --force-yes \
    ca-certificates \
    curl \
    mercurial \
    git-core

RUN curl -s https://storage.googleapis.com/golang/go1.3.linux-amd64.tar.gz | tar -v -C /usr/local -xz

ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV PATH $PATH:/usr/local/go/bin:/go/bin


ADD . /app/
WORKDIR /app/
RUN go build dockerui.go
EXPOSE 9000
ENTRYPOINT ["./dockerui"]
