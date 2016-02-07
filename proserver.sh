#!/bin/bash
VERSION="4.3.5.2"
INSTALLDIR=/src/CrashPlanPROServer_${VERSION}_Linux
CMD=/opt/proserver/bin/proserver

if [ ! -f $CMD ]
then
    echo "Download and unpack CrashPlanPROServer"
    curl -SL https://download.code42.com/installs/proserver/${VERSION}/CrashPlanPROServer_${VERSION}_Linux.tgz \
    | tar -xz
    echo "Starting installation of CrashPlanPROServer v$VERSION!"
    sed -i 's/INSTALL_UNATTENDED=0/INSTALL_UNATTENDED=1/g' ${INSTALLDIR}/install.sh
    sed -i 's/AUTO_ACCEPT_EULA=0/AUTO_ACCEPT_EULA=1/g' ${INSTALLDIR}/install.sh
    cd $INSTALLDIR && ./install.sh
    rm -rf $INSTALLDIR
    #Stop the service and remove autostart
    /etc/init.d/proserver stop
    rm /etc/init.d/proserver
    sleep 10
fi

echo "Starting Services"
cd /opt/proserver && /usr/bin/java -Dapp=CPServer -server -Dnetworkaddress.cache.ttl=300 -Ddrools.compiler=JANINO \
    -Dfile.encoding=UTF-8 -Dc42.native.md5.enabled=false -XX:+DisableExplicitGC -XX:+UseAdaptiveGCBoundary \
    -XX:PermSize=256m -XX:MaxPermSize=256m -Xss256k -Xms256m -Xmx1024m -jar /opt/proserver/lib/com.backup42.app.jar \
    -prop conf/conf_proe.properties -prop conf/conf_local.properties -config conf/conf_proe.groovy -config conf/conf_local.groovy
