FROM jess/pastebinit-server:v0.2.1 as pastebinit

FROM alpine
RUN apk update && apk add bash
COPY --from=pastebinit /usr/bin/pastebinit-server /usr/bin/pastebinit-server
COPY --from=pastebinit /etc/ssl/certs/ /etc/ssl/certs
COPY --from=pastebinit /src/static /src/static

CMD ["sh", "-c", "/usr/bin/pastebinit-server -b $PASTEBINIT_URI -s $PASTEBINIT_STORAGE_DIR"]

