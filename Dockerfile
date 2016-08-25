FROM redwyvern/jenkins-ubuntu-slave-base
MAINTAINER Nick Weedon <nick@weedon.org.au>

RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends \
    bzip2 \
    nodejs \
    nodejs-legacy \
    npm \
    maven \
    git \
    ruby \
    software-properties-common \
    libfontconfig1 \
    libfontconfig1-dev \
    libfreetype6 \
    libfreetype6-dev \
    curl \
    unzip \
    xml2 && \
    apt-get -q autoremove && \
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

RUN npm install -g \
    bower \
    grunt \
    less

COPY sencha/install-5.1.3.61.sh /tmp

RUN mkdir /opt/jenkins && chown jenkins.jenkins /opt/jenkins

USER jenkins


ENV PATH="${PATH}:/opt/jenkins/Sencha/Cmd/5.1.3.61"

RUN cd /tmp && \
    ./install-5.1.3.61.sh && \
    sencha package repo init -name "Nick Weedon" -email "nick@weedon.org.au"

USER root

COPY settings.xml /home/jenkins/.m2/settings.xml

RUN chown -R jenkins.jenkins /home/jenkins

