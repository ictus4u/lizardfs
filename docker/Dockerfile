FROM ictus4u/yacpp:1.0.1

COPY ./tests/setup_machine.sh /tmp/setup_machine.sh

RUN apt-get update \
  && cat /tmp/setup_machine.sh \
    | awk '/LinuxMint\/\*\|Ubuntu\/\*\|Debian\/\*\)/,/;;/' \
    | grep -E 'apt-get (-y )?install' \
    | sed -E 's/apt-get (-y )?install//g' \
    | xargs apt-get install -y --no-install-recommends \
  && cat /tmp/setup_machine.sh \
    | awk '/LinuxMint\/\*\|Ubuntu\/\*\|Debian\/\*\)/,/;;/' \
    | grep -E 'pip3 install' \
    | sed -E 's/pip3 install//g' \
    | xargs pip3 install \
  && apt-get install -y --no-install-recommends \
    docbook-xml \
    docbook-xsl \
    lsb-release \
    psmisc \
    rsyslog \
    sgml-base \
    sgml-data \
    sudo \
    xml-core \
  && rm -rf /var/lib/apt/lists/* \
  && rm /tmp/setup_machine.sh 
