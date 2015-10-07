FROM ivotron/phoronix

ADD user-config.xml /root/.phoronix-test-suite/
RUN apt-get update && \
    CFLAGS="-O0" phoronix-test-suite install \
       pts/c-ray pts/crafty pts/ramspeed pts/stream && \
    apt-get remove --auto-remove -y \
       build-essential autoconf libnuma-dev mesa-utils unzip && \
    apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD run.sh /root/
ENTRYPOINT ["/root/run.sh"]
