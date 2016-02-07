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
fi

echo "Starting Services"
/etc/init.d/proserver start
touch /var/log/proserver/app.log
tail -f /var/log/proserver/app.log
