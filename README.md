![](https://img.shields.io/docker/stars/redwyvern/jenkins-ubuntu-slave.svg)
![](https://img.shields.io/docker/pulls/redwyvern/jenkins-ubuntu-slave.svg)
![](https://img.shields.io/docker/automated/redwyvern/jenkins-ubuntu-slave.svg)
[![](https://images.microbadger.com/badges/image/redwyvern/jenkins-ubuntu-slave.svg)](https://microbadger.com/images/redwyvern/jenkins-ubuntu-slave "Get your own image badge on microbadger.com")

Redwyvern Jenkins - Ubuntu Slave 
================================

This is the Jenkins Docker slave image for Redwyvern software.

This slave contains software to build the following type of projects:
* Java 8 Maven
* Javascript with NPM, Node & Bower
* Sencha Ext JS
* GCC 6.1 => C++ 11, C++ 14 and C++ 17 (experimental features)
* CMake 3.6.1
* Boost 6.0 - Built with GCC 6.1 (At the time of writing, Boost 6.1 has some portibility issues)

Once a container from this image is running it is ready run as a Jenkins slave without further configuration.

Example YAML file:
```
version: '3'

services:
  ubuntu-slave:
    image:  docker.artifactory.weedon.org.au/redwyvern/jenkins-cpp-slave
    container_name: ubuntu-slave
    hostname: ubuntu-slave
    restart: always
    dns: 192.168.1.50
    networks:
      - dev_nw

networks:
  dev_nw:
```
