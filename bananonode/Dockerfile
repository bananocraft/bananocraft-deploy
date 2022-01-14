FROM bananocoin/banano

RUN apt-get update
RUN apt-get install curl gzip -y

COPY --chmod=755 entrypoint.sh .

COPY config /usr/share/nano/config

ENTRYPOINT ["./entrypoint.sh"]

