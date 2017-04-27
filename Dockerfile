FROM alpine

ENV GOPATH /home/hound

EXPOSE 6080

RUN apk update \
	&& apk add go git openssh \
	&& rm -f /var/cache/apk/*

RUN adduser -u 998 -D hound

COPY . /home/hound/src/github.com/etsy/hound

RUN chown -R hound:hound /home/hound

VOLUME ["/home/hound]

USER hound

RUN go install github.com/etsy/hound/cmds/houndd \
	&& rm -rf /home/hound/src /home/hound/pkg

ENTRYPOINT ["/go/bin/houndd", "-conf", "/home/hound/data/config.json"]
