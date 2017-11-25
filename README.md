Redwyvern Jenkins - C++ Slave 
================================

This is the Jenkins Docker slave image for Redwyvern software.

This slave contains software to build the following type of projects:
* GCC 6.1 => C++ 11, C++ 14 and C++ 17 (experimental features)
* CMake 3.6.1
* Boost 6.0 - Built with GCC 6.1 (At the time of writing, Boost 6.1 has some portibility issues)

Once a container from this image is running it is ready run as a Jenkins slave without further configuration.

Example YAML file:
```
version: '3'

services:
  cpp-slave:
    image:  docker.artifactory.weedon.org.au/redwyvern/jenkins-cpp-slave
    container_name: cpp-slave
    hostname: cpp-slave
    restart: always
    dns: 192.168.1.50
    networks:
      - dev_nw

networks:
  dev_nw:
```
