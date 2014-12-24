#just test
FROM debian:wheezy      

RUN echo "deb http://mirrors.163.com/debian unstable main contrib non-free" > /etc/apt/sources.list.d/unstable.list \
 && apt-get update \
 && apt-get install --no-install-recommends -y --force-yes \
    ca-certificates \
    curl \
    mercurial \
    git-core \
 && rm -rf /var/lib/apt/lists/* # 20141223

# fuck GFW!
#RUN curl -s https://storage.googleapis.com/golang/go1.3.linux-amd64.tar.gz | tar -v -C /usr/local -xz
ADD . /app/
RUN tar xzvf /app/go1.3.linux-amd64.tar.gz \
  && mv go /usr/local \
  && rm /app/go1.3.linux-amd64.tar.gz

ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV PATH $PATH:/usr/local/go/bin:/go/bin


#ADD . /app/
WORKDIR /app/
RUN go build dockerui.go
EXPOSE 9000
ENTRYPOINT ["./dockerui"]
