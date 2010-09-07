#!/bin/sh

set -x
#set -e
echo "Extracting Program and RPM Values:"
INDYVERSION=10.2.0.1
# You actually should use three version values.
# FPCVer is for the value reported by fpc for some path specs.
# FPCRPMVER is used for our "Requires section so that this is
# tied to the EXACT version of the fpc RPM you used to build
# this.
# FPCSRCRPMVER is used for our "Requires section so that this
# is tied to the EXACT version of the fpc-src RPM you used 
# you have to prevent errors.
INDYRELNO=8
FPCVER=`fpc -iV`
FPCRPMVER=$(rpm -qa | egrep '^fpc-[0-9]')
FPCRPMVER=${FPCRPMVER:4}
FPCSRCRPMVER=$(rpm -qa | egrep '^fpc-src-[0-9]')
FPCSRCRPMVER=${FPCSRCRPMVER:8}
echo "FPC Version: $FPCVER"
echo "FPC RPM Ver: $FPCRPMVER"
echo "FPCSRC RPM Ver: $FPCSRCRPMVER"

echo "making tarball"

#rm indy-$INDY_Version.tar.bz2
tar jcf indy-$INDYVERSION.tar.bz2 .
pwd
echo "copying tarball to ~/rpmbuild/SOURCES"
cp  indy-$INDYVERSION.tar.bz2 ~/rpmbuild/SOURCES
echo "Making RPM spec file"
  cat indy-fpc.spec.template| \
    sed -e "s/^%define _FPC_Version .*/%define _FPC_Version $FPCVER/" \
        -e "s/^%define _FPC_RPM_Ver .*/%define _FPC_RPM_Ver $FPCRPMVER/" \
        -e "s/^%define _FPC_SRC_RPM_Ver .*/%define _FPC_SRC_RPM_Ver $FPCSRCRPMVER/" \
        -e "s/^Version:   .*/Version:   $INDYVERSION/" \
        -e "s/^Release:   .*/Release:   $INDYRELNO/" \
    > indy-fpc.spec

echo "Building RPM"
rpmbuild -bb -v indy-fpc.spec
