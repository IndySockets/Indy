#!/bin/sh
OS=`uname -s`
if [ "$OS" = 'Darwin' ]
then
  S_PREFIX='/Volumes/E$/source/indy10/trunk'
  FPCSRC=/Developer/FreePascalCompiler/$(fpc -iV)/Source
else
  S_PREFIX='/mnt/hgfs/IndyTiburon'
  FPCSRC=/usr/share/fpcsrc/$(fpc -iV)
  if [ ! -d $FPCSRC ]
  then
    FPCSRC=/usr/share/fpcsrc
  fi
fi
DOS2_UNIX='tr -d ''\r'
INDYVERSION=`cat $S_PREFIX/lib/System/IdVers.inc | grep ' *gsIdVersion *=.*;' | sed -e 's/[^0-9.]//g'` 
INDYDIR=indy-$INDYVERSION
FPCINDYDIR=$INDYDIR/fpc
LAZINDYDIR=$INDYDIR/lazarus

echo parameter 1 = $1
if [ "$1" != "buildonly" ]
then
  rm -rf $INDYDIR
  mkdir -p $INDYDIR/fpc 

  cp -p $S_PREFIX/lib/fpcnotes/* $INDYDIR
  cp -p $S_PREFIX/lib/makeindyrpm.sh $INDYDIR
  cp -p $S_PREFIX/lib/indy-fpc.spec.template $INDYDIR
  FILENAMES=$(cat $S_PREFIX/lib/RTFileList.txt | $DOS2_UNIX | tr '\\' '/') 
  for i in $FILENAMES
  do
    cp -p $S_PREFIX//lib/$i $FPCINDYDIR
  done
  cp -p $S_PREFIX/lib/System/IdCompilerDefines.inc $FPCINDYDIR
  cp -p $S_PREFIX/lib/System/IdVers.inc $FPCINDYDIR
  cp -p $S_PREFIX/lib/System/indysystemfpc.pas $FPCINDYDIR
  cp -p $S_PREFIX/lib/Core/indycorefpc.pas $FPCINDYDIR
  cp -p $S_PREFIX/lib/Protocols/indyprotocolsfpc.pas $FPCINDYDIR
  cp -p $S_PREFIX/lib/indymaster-Makefile.fpc $FPCINDYDIR/Makefile.fpc
  mkdir -p $FPCINDYDIR/examples
  cp -rp $S_PREFIX/lib/Examples/* $FPCINDYDIR/examples 
  find $FPCINDYDIR/examples -type d -name ".svn" -exec rm -rf '{}' \;
  mkdir -p $FPCINDYDIR/debian
  cp -rp $S_PREFIX/lib/debian/* $FPCINDYDIR/debian
  find $FPCINDYDIR/debian -type d -name ".svn" -exec rm -rf '{}' \;
fi
make

FPCDIR=$FPCSRC;export FPCDIR
cd $FPCINDYDIR
echo $(pwd)
fpcmake -rTall
make
cd examples
fpcmake -rTall
cd ..




