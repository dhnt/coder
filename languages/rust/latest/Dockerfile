FROM openfaas/classic-watchdog:0.18.1 as watchdog

FROM rust:1.41-alpine3.10

RUN apk add --no-cache bash

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

ENV USER=app

RUN addgroup "$USER" \
    && adduser \
    --disabled-password \
    --gecos "" \
    --shell "/bin/bash" \
    --home "/home/$USER" \
    --ingroup "$USER" \
    "$USER"

# Install code-runner
ADD https://github.com/prasmussen/glot-code-runner/releases/download/2017-04-12/runner /home/$USER/runner
RUN chmod +x /home/$USER/runner


USER $USER
WORKDIR /home/$USER/

ENV fprocess="/home/$USER/runner"
# Set to true to see request in function logs
ENV write_debug="false"

EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
