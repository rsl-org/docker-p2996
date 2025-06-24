ARG BASE
FROM $BASE

COPY root/root /root/
COPY root/usr/ /usr/

ARG PARENT
COPY configs/${PARENT}.sh /tmp/install.sh
RUN chmod +x /tmp/install.sh && /tmp/install.sh

ENV PATH="/usr/bin:$PATH"
ENV LD_LIBRARY_PATH="/usr/lib/x86_64-unknown-linux-gnu:$LD_LIBRARY_PATH"

RUN clang --version
WORKDIR /src