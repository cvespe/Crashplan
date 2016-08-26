# Crashplanproserver

Crashplan Code42 server container
http://support.code42.com/Administrator/5/Planning_And_Installing/Code42_Platform_Installers

## Usage

Create a docker-compose.yml file added an example. Run with `docker-compose up -d`. After a minute crashplanserver should be listening on ports 4285. You can connect with https://DOCKERIP:4285/console.
Please note that your clients will communicate with the server on TCP port 4282.

#### docker-compose.yml
```
proserver:
  build: .
  container_name: proserver
  ports:
    - "4282:4282"
    - "4283:4283"
    - "4285:4285"
    - "4286:4286"
  volumes_from:
    - data
data:
  image: busybox:latest
  container_name: proserver_data
  volumes:
    # Log files
    - /var/log/proserver
    # Default backup destination
    - /var/opt/proserver
    # System settings and binarys
    - /opt/proserver
    # Using synology local disk space outside container.
    #- /volume1/code42/:/opt/code42
  command: /bin/echo
```

## Maintainers

* [Erik Aulin](mailto:erik@aulin.co)
