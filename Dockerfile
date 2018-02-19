FROM jess/pastebinit-server as pastebinit

FROM alpine
RUN apk update && apk add bash
COPY --from=pastebinit /usr/bin/pastebinit-server /usr/bin/pastebinit-server
COPY --from=pastebinit /etc/ssl/certs/ /etc/ssl/certs
COPY --from=pastebinit /src/static /src/static

RUN echo "#!/bin/bash" > /start.sh
RUN echo "pastebinit-server -b \$PASTEBINIT_URI" >> /start.sh
RUN chmod +x /start.sh

ENTRYPOINT [ "/start.sh" ]
CMD []
