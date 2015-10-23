FROM ivotron/phoronix

ADD user-config.xml /root/.phoronix-test-suite/
RUN apt-get update && \
    phoronix-test-suite download-test-files \
       pts/c-ray pts/crafty pts/stream && \
    sed -i -e 's/\(cc.*\)/\1 \$CFLAGS/g' ~/.phoronix-test-suite/test-profiles/pts/stream-1.2.0/install.sh && \
    sed -i -e 's/<TimesToRun.*10.*/<TimesToRun>2</TimesToRun>/' ~/.phoronix-test-suite/test-profiles/pts/stream-1.2.0/test-definition.xml && \
    sed -i -e 's/<TimesToRun.*3.*/<TimesToRun>1</TimesToRun>/' ~/.phoronix-test-suite/test-profiles/pts/crafty-1.3.0/test-definition.xml && \
    sed -i -e 's/<TimesToRun.*3.*/<TimesToRun>1</TimesToRun>/' ~/.phoronix-test-suite/test-profiles/pts/c-ray-1.1.0/test-definition.xml && \
    CFLAGS="-O0 -mtune=generic" phoronix-test-suite install \
       pts/c-ray pts/crafty pts/stream && \
    apt-get remove --auto-remove -y \
       build-essential autoconf libnuma-dev mesa-utils unzip && \
    apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD run.sh /root/
ENTRYPOINT ["/root/run.sh"]
