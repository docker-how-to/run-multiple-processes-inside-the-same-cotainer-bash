FROM blang/alpine-bash

RUN mkdir /runner
COPY ./scripts/* /runner/
RUN chmod -R 777 /runner

WORKDIR /runner/
ENTRYPOINT ["/runner/run.sh"]
