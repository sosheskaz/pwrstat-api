FROM --platform=$TARGETPLATFORM python:3-bookworm
MAINTAINER Eric Miller

ARG PPL_VERSION=v1.4.1

ARG TARGETARCH
RUN wget https://dl4jz3rbrsfum.cloudfront.net/software/PPL_64bit_${PPL_VERSION}.deb \
  && dpkg -i PPL_64bit_${PPL_VERSION}.deb \
  && rm -f PPL_64bit_${PPL_VERSION}.deb \
  && pip install --trusted-host pypi.python.org flask flask_restful flask-jsonpify
COPY pwrstat-api.py init.sh /app/
COPY --from=instructure/tini /tini /bin/tini
WORKDIR /app
ENTRYPOINT ["/bin/tini"]
CMD ["/app/init.sh"]
