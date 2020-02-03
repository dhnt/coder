# FROM node:latest
# MAINTAINER Petter Rasmussen "petter.rasmussen@gmail.com"

FROM node:13.7-alpine3.10

# Install traceur globaly
RUN npm install -g traceur

# Add user
# RUN groupadd glot
# RUN useradd -m -d /home/glot -g glot -s /bin/bash glot

RUN apk add --no-cache bash

ENV USER=glot

RUN addgroup "$USER" \
    && adduser \
    --disabled-password \
    --gecos "" \
    --shell "/bin/bash" \
    --home "/home/$USER" \
    --ingroup "$USER" \
    "$USER"

# Override node and traceur to get them working with the code runner
COPY files/node /usr/local/sbin/node
COPY files/traceur /usr/local/lib/node_modules/traceur/traceur
RUN chmod +x /usr/local/sbin/node
RUN chmod +x /usr/local/lib/node_modules/traceur/traceur

# Install code-runner
ADD https://github.com/prasmussen/glot-code-runner/releases/download/2017-04-12/runner /home/glot/runner
RUN chmod +x /home/glot/runner

USER glot
WORKDIR /home/glot/
CMD ["/home/glot/runner"]
ENTRYPOINT "/home/glot/runner"
