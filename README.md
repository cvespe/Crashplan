# docker-crashplanproserver

Crashplan Pro server container

## Usage

Run with `docker-compose up -d`. After a minute crashplanserver should be listening on ports 4285. You can connect with https://localhost:4285/console.
Please note that your clients will communicate with the server on TCP port 4282.
