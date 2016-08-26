FROM redwyvern/ubuntu-devenv-base
MAINTAINER Nick Weedon <nick@weedon.org.au>

ARG GIT_USER=Jenkins
ARG GIT_EMAIL=jenkins@weedon.org.au

# Set user jenkins to the image
RUN useradd -m -d /home/jenkins -s /bin/bash jenkins

USER jenkins
COPY authorized_keys /home/jenkins/.ssh/authorized_keys


RUN git config --global user.name "${GIT_USER}" && \
    git config --global user.email "${GIT_EMAIL}"

USER root

COPY ./usr /usr
COPY settings.xml /home/jenkins/.m2/settings.xml

RUN chown -R jenkins.jenkins /home/jenkins

# Standard SSH port
EXPOSE 22

# Default command
CMD ["/usr/sbin/sshd", "-D"]

