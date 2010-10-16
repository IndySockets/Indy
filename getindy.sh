#!/bin/sh
OS=`uname -s`
if [ "$OS" = 'Darwin' ]
then
  S_PREFIX='/Volumes/E$/source/indy10/branches/Tiburon'
  DOS2_UNIX='tr -d ''\r' 
  echo $DOS2_UNIX
  FPCSRC=/Developer/FreePascalCompiler/$(fpc -iV)/Source
else
  S_PREFIX='/mnt/hgfs/IndyTiburon'
  DOS2_UNIX='dos2unix'
  FPCSRC=/usr/share/fpcsrc/$(fpc -iV)
  if [ ! -d $FPCSRC ]
  then
    FPCSRC=/usr/share/fpcsrc
  fi
fi

INDYVERSION=`cat $S_PREFIX/lib/System/IdVers.inc | grep ' *gsIdVersion *=.*;' | sed -e 's/[^0-9.]//g'` 
INDYDIR=indy-$INDYVERSION
FPCINDYDIR=$INDYDIR/fpc
LAZINDYDIR=$INDYDIR/lazarus

echo parameter 1 = $1
if [ "$1" != "buildonly" ]
then
  rm -rf $INDYDIR
  mkdir -p $INDYDIR/fpc 

  cp $S_PREFIX/lib/fpcnotes/* $INDYDIR
  cp $S_PREFIX/lib/makeindyrpm.sh $INDYDIR
  cp $S_PREFIX/lib/indy-fpc.spec.template $INDYDIR
  FILENAMES=$(cat $S_PREFIX/lib/RTFileList.txt | $DOS2_UNIX | tr '\\' '/') 
  for i in $FILENAMES
  do
    cp $S_PREFIX//lib/$i $FPCINDYDIR
  done
  cp $S_PREFIX/lib/System/IdCompilerDefines.inc $FPCINDYDIR
  cp $S_PREFIX/lib/System/IdVers.inc $FPCINDYDIR
  cp $S_PREFIX/lib/System/indysystemfpc.pas $FPCINDYDIR
  cp $S_PREFIX/lib/Core/indycorefpc.pas $FPCINDYDIR
  cp $S_PREFIX/lib/Protocols/indyprotocolsfpc.pas $FPCINDYDIR
  cp $S_PREFIX/lib/indymaster-Makefile.fpc $FPCINDYDIR/Makefile.fpc
  mkdir $FPCINDYDIR/examples
  cp -r $S_PREFIX/lib/Examples/* $FPCINDYDIR/examples 
  find $FPCINDYDIR/examples -type d -name ".svn" -exec rm -rf '{}' \;
  mkdir $FPCINDYDIR/debian
  cp -r $S_PREFIX/lib/debian/* $FPCINDYDIR/debian
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




