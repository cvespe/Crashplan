FROM debian:jessie
ENV DEBIAN_FRONTEND=noninteractive

# install prereqs
RUN apt-get update \
    && apt-get -qy --no-install-recommends install \
        openjdk-7-jre-headless \
        cpio \
        curl \
        sed \
        wget \
    && apt-get -q -y clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* \
    && rm -rf /usr/share/man/?? /usr/share/man/??_*

ENV VERSION="4.3.0"
ENV INSTALLDIR=/src/CrashPlanPROServer_${VERSION}_Linux

RUN mkdir /src
WORKDIR /src
COPY proserver.sh /src/
RUN chmod a+x /src/proserver.sh

# Download and unpack crashplan
RUN curl -SL http://download.crashplan.com/installs/proserver/${VERSION}/CrashPlanPROServer_${VERSION}_Linux.tgz \
    | tar -xz

EXPOSE 4280 4282 4285

ENTRYPOINT ["/src/proserver.sh"]
