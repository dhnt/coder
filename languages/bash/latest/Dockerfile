FROM openfaas/classic-watchdog:0.18.1 as watchdog

FROM ubuntu:latest
MAINTAINER Petter Rasmussen "petter.rasmussen@gmail.com"

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

ENV USER=app

# Add user
RUN groupadd $USER
RUN useradd -m -d /home/$USER -g $USER -s /bin/bash $USER

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
