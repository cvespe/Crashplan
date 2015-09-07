# Crashplanproserver

Crashplan PROe server container

## Usage

Create a docker-compose.yml file added an example. Run with `docker-compose up -d`. After a minute crashplanserver should be listening on ports 4285. You can connect with https://DOCKERIP:4285/console.
Please note that your clients will communicate with the server on TCP port 4282.

#### docker-compose.yml
```
proserver:
  build: .
  container_name: proserver
  ports:
    - "4280:4280"
    - "4282:4282"
    - "4285:4285"
  volumes_from:
    - data
data:
  # image: tianon/true:latest
  image: busybox:latest
  container_name: proserver_data
  volumes:
    - /var/log/proserver
    - /var/opt/proserver
    - /opt/proserver
    # Using synology local disk space outside container.
    #- /volume1/code42/:/opt/code42
  command: /bin/echo
```
