FROM redwyvern/jenkins-ubuntu-slave-base
MAINTAINER Nick Weedon <nick@weedon.org.au>

# The timezone for the image (set to Etc/UTC for UTC)
ARG IMAGE_TZ=America/New_York
ARG GIT_USER=Jenkins
ARG GIT_EMAIL=jenkins@weedon.org.au

USER root

# Set the timezone
# Normally this would be done via: echo ${IMAGE_TZ} >/etc/timezone && dpkg-reconfigure -f noninteractive tzdata 
# A bug in the current version of Ubuntu prevents this from working: https://bugs.launchpad.net/ubuntu/+source/tzdata/+bug/1554806
# Change this to the normal method once this is fixed.
RUN ln -fs /usr/share/zoneinfo/${IMAGE_TZ} /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

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

RUN git config --global user.name "${GIT_USER}" && \
    git config --global user.email "${GIT_EMAIL}"
    
ENV PATH="${PATH}:/opt/jenkins/Sencha/Cmd/5.1.3.61"

RUN cd /tmp && \
    ./install-5.1.3.61.sh && \
    sencha package repo init -name "Nick Weedon" -email "nick@weedon.org.au"

USER root

COPY ./usr /usr
COPY settings.xml /home/jenkins/.m2/settings.xml

RUN chown -R jenkins.jenkins /home/jenkins

