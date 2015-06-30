FROM diogogmt/node-js-ubuntu:0.12.3

ENV GHOST_HOME /usr/local/ghost
ENV GHOST_CONTENT /var/lib/ghost

RUN wget -O /tmp/ghost.tar.gz https://github.com/diogogmt/Ghost/archive/stable.tar.gz && \
    mkdir $GHOST_HOME && \
    tar -xvf /tmp/ghost.tar.gz -C $GHOST_HOME --strip-components=1

WORKDIR $GHOST_HOME
RUN npm install
RUN grunt init --force
RUN grunt prod --force

RUN wget -O /tmp/ghost-config.tar.gz https://github.com/diogogmt/ghost-config/archive/master.tar.gz && \
    tar -xvf /tmp/ghost-config.tar.gz -C $GHOST_HOME --strip-components=1

VOLUME $GHOST_CONTENT
WORKDIR $GHOST_HOME

EXPOSE 2368
CMD ["npm", "start", "--production"]