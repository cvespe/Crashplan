#!/bin/bash
VERSION="4.3.0"
INSTALLDIR=/src/CrashPlanPROServer_${VERSION}_Linux

if [ ! -f /var/log/proserver/app.log ]
then
    echo "Download and unpack CrashPlanPROServer"
    curl -SL http://download.crashplan.com/installs/proserver/${VERSION}/CrashPlanPROServer_${VERSION}_Linux.tgz \
    | tar -xz
    echo "Starting installation of CrashPlanPROServer v$VERSION!"
    sed -i 's/INSTALL_UNATTENDED=0/INSTALL_UNATTENDED=1/g' ${INSTALLDIR}/install.sh
    sed -i 's/AUTO_ACCEPT_EULA=0/AUTO_ACCEPT_EULA=1/g' ${INSTALLDIR}/install.sh
    cd $INSTALLDIR && ./install.sh
    rm -rf $INSTALLDIR
fi

if [ ! -f $INSTALLDIR/install.sh ]
then
    echo "Removing CrashPlanPROServer installation files"
    rm -rf $INSTALLDIR
fi

# attach to logs (stops container from stopping)
sleep 50
tail -f /var/log/proserver/app.log
