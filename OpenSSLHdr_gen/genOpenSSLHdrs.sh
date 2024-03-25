#!/bin/sh

cd `dirname $0`

LIBSSLUNITS="IdOpenSSLHeaders_ssl IdOpenSSLHeaders_sslerr IdOpenSSLHeaders_tls1"
SRCDIR=sslheaders_source
if [ -d ../runtime/protocols ]; then
  DESTDIR=../runtime/protocols/opensslHdrs
elif [ -d ../Lib/Protocols ]; then
  DESTDIR=../Lib/Protocols/opensslHdrs
fi
if [ -n "$1" ]; then
  DESTDIR="$1"
fi
mkdir -p "$DESTDIR"
ALLHEADERS="$DESTDIR"/AllOpenSSLHeaders.pas

#Define some common regular expressions for later use by sed and grep
INTRODUCED='introduced *\([0-9]\+\)\.\([0-9]\+\)\.\([0-9]\+\)'
REMOVED='removed *\([0-9]\+\)\.\([0-9]\+\)\.\([0-9]\+\)'
ALLOW_NIL='allow_nil'
INTRODUCEDONLYFILTER="{ *$INTRODUCED *}"
INTRODUCEDFILTER="{ *$INTRODUCED *\($REMOVED *\|\)}"
REMOVEDFILTER="{ *\(introduced *[0-9]\+\.[0-9]\+\.[0-9]\+\|\) *$REMOVED *\(allow_nil\|\)}"
REMOVEDNOTNILFILTER="{ *\(introduced *[0-9]\+\.[0-9]\+\.[0-9]\+\|\) *$REMOVED *}"
INTRODUCEDANDREMOVEDFILTER="\($INTRODUCEDONLYFILTER\|$REMOVEDFILTER\)"
PROCFILTER='^ *\(function \|procedure \) *\([A-Za-z0-9_]*\+\)\((.*) *: *[A-Za-z0-9_]\+ *\| *: *[A-Za-z0-9_]\+ *\|(.*) *\| *\)\(; *cdecl;\| *cdecl\|\);'
HELPERS='/^{helper_functions}/,/^{\/helper_functions}/'
FORWARDS='/^{forward_compatibility}/,/^{\/forward_compatibility}/'
DEFINES='/^ *{\$\(IFNDEF\|IFDEF\|ENDIF\)/'
DELAYED_LOADING='{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}'

#Initialise AllHeaders Unit
(
  echo "Unit AllOpenSSLHeaders;"
  echo ""
  echo "interface"
  echo ""
  echo "uses"
) > $ALLHEADERS
ALLHEADERS_SEPARATOR=

for FILE in `ls -1 $SRCDIR/*.h2pas`; do
  UNITNAME=`basename -s '.h2pas' "$FILE"`
  SRCFILE=${UNITNAME}.h2pas
  UNITFILE="$DESTDIR"/${UNITNAME}.pas
  echo "Processing $UNITNAME"

  LIBNAME=LibCrypto #default
  #Check to see if function declared by unit should be in LibSSL
  for UNIT in $LIBSSLUNITS; do
    if [ "$UNIT" = "$UNITNAME" ]; then
      LIBNAME=LibSSL
      break
    fi
  done

  #Initalise output unitfile - everything from start to line before first procedure/function definition
  #and preceded by warning notice
   cat <<EOT >$UNITFILE
  (* This unit was generated using the script `basename $0` from the source file $SRCFILE
     It should not be modified directly. All changes should be made to $SRCFILE
     and this file regenerated. $SRCFILE is distributed with the full Indy
     Distribution.
   *)
   
{\$i IdCompilerDefines.inc} 
{\$i IdSSLOpenSSLDefines.inc} 
{\$IFNDEF USE_OPENSSL}
  {$message error Should not compile if USE_OPENSSL is not defined!!!}
{\$ENDIF}
EOT
  #copy everything from source to dest up to the first function/procedure declaration
  sed '/^ *\(procedure \|function \)/,$d' $FILE |sed 's/[[:blank:]]*$//' >>$UNITFILE
  
  #ignore files without a procedure/function definition
  if grep -i '^ *\(procedure \|function \)' $FILE >/dev/null 2>&1; then 
  
    #Add EXTERNALSYM directive for each function/procedure not removed in most recent version of OpenSSL
  
    cat <<EOT >> $UNITFILE
    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
EOT
    sed  '/^implementation.*$/,$d' $FILE | sed "${HELPERS}d" | sed -n '/^ *\(procedure \|function \)/,$p' | grep -v "$REMOVEDFILTER" |\
    sed "s/$PROCFILTER/  {\$EXTERNALSYM \2}/" |grep 'EXTERNALSYM' >>$UNITFILE
    
    #copy helper functions from interface
    sed  '/^implementation.*$/,$d' $FILE | sed -n "${HELPERS}p" >>$UNITFILE
    
    #Dynamic Library Interface section
    #Copy all function/procedures as function/procedure variable definitions
    (
    echo ""
    echo '{$IFNDEF USE_EXTERNAL_LIBRARY}'
    echo "var"    
    ) >>$UNITFILE

    #Include EXTERNALSYM declarations for removed functions
    sed  '/^implementation.*$/,$d' $FILE | sed "${HELPERS}d" | sed -n '/^ *\(procedure \|function \)/,$p' | grep "$REMOVEDFILTER" |\
    sed "s/$PROCFILTER/  {\$EXTERNALSYM \2}/" |grep 'EXTERNALSYM' >>$UNITFILE

    #Note assumes that all function and procedure declarations are contained in a single line

    #Generate dynamic library interface
    sed  '/^implementation.*$/,$d' $FILE | sed "${HELPERS}d" | sed "${DEFINES}d" |sed -n '/^ *\(procedure \|function \)/,$p' |\
    sed "s/$PROCFILTER/  \2: \1\3; cdecl = nil;/" >> $UNITFILE

    echo '{$ELSE}' >>$UNITFILE

    #Generate static library interface
    
    #All functions/procedures in interface section other than helper functions that have not been commented as removed are included and made external
    sed  '/^implementation.*$/,$d' $FILE | sed "${HELPERS}d" | sed -n '/^ *\(procedure \|function \)/,$p' | grep -v "$REMOVEDFILTER"  |sed "s/{${ALLOW_NIL}}//" | \
    sed "s/^ *\(function\|procedure\) *\(.*\);/  \1 \2 cdecl; external {\$IFNDEF OPENSSL_USE_STATIC_LIBRARY}C$LIBNAME{\$ENDIF}$DELAYED_LOADING;/" >> $UNITFILE
    
    #All functions/procedures in interface section that have been commented as removed are included as normal 
    #function/procedure definitions provided that a function/procedure with the same name is located in the implementation section.

    sed  '/^implementation.*$/,$d' $FILE | sed "${HELPERS}d" | sed -n '/^ *\(procedure \|function \)/,$p' | grep  "$REMOVEDFILTER" | \
    sed "s/$PROCFILTER/\2/" | sed 's/ {.*//' | while read FUNC_NAME; do 
      if sed '0,/^implementation.*$/d' $FILE | grep "^ *\(function\|procedure\) *$FUNC_NAME *[(:;]" >/dev/null 2>&1; then
        sed  '/^implementation.*$/,$d' $FILE | grep "^ *\(procedure \|function \) *$FUNC_NAME *[(:;)]" >> $UNITFILE
      fi
    done

    cat <<EOT >>$UNITFILE
{\$ENDIF}

implementation

EOT
  #Update uses clause and add if necessary
    USESFILTER='^uses.*;'
    USESUNITS="\n\
  {\$IFNDEF USE_EXTERNAL_LIBRARY}\n\
  classes,\n\
  IdSSLOpenSSLLoader,\n\
  {\$ENDIF}\n\
  IdSSLOpenSSLExceptionHandlers,\n\
  IdResourceStringsOpenSSL,\n"
      if sed '0,/^implementation.*$/d' $FILE| sed '/^end\..*$/,$d' | grep '^uses.*;' >/dev/null 2>&1; then
      #Update uses clause
      sed '0,/^implementation.*$/d' $FILE| sed -n "/$USESFILTER/p"| sed "s/^uses/uses $USESUNITS/" >> $UNITFILE
    elif sed '0,/^implementation.*$/d' $FILE| sed '/^end\..*$/,$d' | grep '^uses' >/dev/null 2>&1; then
      #Update uses clause
      USESFILTER='^uses/,/.*;'
      sed '0,/^implementation.*$/d' $FILE| sed '/^end\..*$/,$d' | sed -n "/$USESFILTER/p"| sed "s/^uses/uses $USESUNITS/" >> $UNITFILE
    else
      USESFILTER=
      cat <<EOT >>$UNITFILE
  uses
    classes, 
    IdSSLOpenSSLExceptionHandlers, 
    IdResourceStringsOpenSSL
  {\$IFNDEF USE_EXTERNAL_LIBRARY}
    ,IdSSLOpenSSLLoader
  {\$ENDIF};
EOT
    fi
    
    cat <<EOT >> $UNITFILE
  
EOT
    if sed  '/^implementation.*$/,$d' $FILE | sed "${HELPERS}d" |sed "${FORWARDS}d" | sed -n '/^ *\(procedure \|function \)/,$p' | grep "$INTRODUCEDANDREMOVEDFILTER" >/dev/null 2>&1; then
      echo "const" >>$UNITFILE
      #A list of consts is included to give the SSLeary formatted version number of each introduced and removed function
      sed  '/^implementation.*$/,$d' $FILE | sed "${HELPERS}d" |sed "${FORWARDS}d"| sed -n '/^ *\(procedure \|function \)/,$p' | grep "$INTRODUCEDFILTER" |\
      sed "s/$PROCFILTER *$INTRODUCEDFILTER/  \2_introduced = (byte(\5) shl 8 or byte(\6)) shl 8 or byte(\7);/" >> $UNITFILE
      sed  '/^implementation.*$/,$d' $FILE | sed "${HELPERS}d" |sed "${FORWARDS}d"| sed -n '/^ *\(procedure \|function \)/,$p' | grep "$REMOVEDFILTER" |\
      sed "s/$PROCFILTER *$REMOVEDFILTER/  \2_removed = (byte(\6) shl 8 or byte(\7)) shl 8 or byte(\8);/" >> $UNITFILE
    fi

  
	#Copy consts and types until first function/procedure definition
	if [ -z "$USESFILTER" ] ; then
      sed  '0,/^implementation.*$/d' $FILE | sed '/^end\..*$/,$d' |sed "${HELPERS}d" |sed "${FORWARDS}d"|sed '/^ *\(procedure \|function \)/,$d' | sed 's/[[:blank:]]*$//' >>$UNITFILE
	else
      sed  '0,/^implementation.*$/d' $FILE | sed '/^end\..*$/,$d' |sed "${HELPERS}d" |sed "${FORWARDS}d"|sed "/${USESFILTER}/d" | sed '/^ *\(procedure \|function \)/,$d' | sed 's/[[:blank:]]*$//' >>$UNITFILE
    fi
    
    #Copy helper functions to implementation section
    sed '0,/^implementation.*$/d' $FILE| sed '/^end\..*$/,$d' | sed -n "${HELPERS}p" >>$UNITFILE
    
    #Start Dynamic Interface section
    echo "{\$IFNDEF USE_EXTERNAL_LIBRARY}" >>$UNITFILE

    #include implementation body for dynamic interface
	if [ -z "$USESFILTER" ] ; then
      sed '0,/^implementation.*$/d' $FILE| sed '/^end\..*$/,$d' | sed "${HELPERS}d" |sed "${FORWARDS}d" |\
      sed "s/$PROCFILTER/\1 _\2\3; cdecl;/" >> $UNITFILE
	else
      sed '0,/^implementation.*$/d' $FILE| sed '/^end\..*$/,$d' | sed "/$USESFILTER/d" | sed "${HELPERS}d" |sed "${FORWARDS}d" |\
      sed "s/$PROCFILTER/\1 _\2\3; cdecl;/" >> $UNITFILE
    fi

    #Copy forward compatibility functions to implementation section
    sed '0,/^implementation.*$/d' $FILE| sed '/^end\..*$/,$d' | sed -n "${FORWARDS}p" | sed "s/$PROCFILTER/\1 FC_\2\3; cdecl;/" >>$UNITFILE
    
    #Add Exception generators for each introduced/removed procedure/function
    echo '{$WARN  NO_RETVAL OFF}' >>$UNITFILE
    sed  '/^implementation.*$/,$d' $FILE | sed -n '/^ *\(procedure \|function \)/,$p'  | grep  "\($INTRODUCED\|$REMOVEDNOTNILFILTER\)" |\
    sed "s/$PROCFILTER *\({.*}\)/\
\1 ERR_\2\3; \4\n\
begin\n\
  EIdAPIFunctionNotPresent.RaiseException('\2');\n\
end;\n\\n/" >>$UNITFILE
    echo '{$WARN  NO_RETVAL ON}' >>$UNITFILE



    cat <<EOT >>$UNITFILE

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) and Assigned(AFailed) then
      AFailed.Add(AMethodName);
  end;

begin
EOT


    #Generate Load procedures
    #If the procedure/function is neither "introduced" nor "removed" then a failure to load is handled 
    #by adding the procedure/function name to the "failed" list
    sed  '/^implementation.*$/,$d' $FILE |sed "${HELPERS}d" |  grep -i '^ *\(procedure \|function \)' | grep -v "$REMOVED" | grep -v "$INTRODUCED" | grep -v "$ALLOW_NIL" |\
    sed "s/$PROCFILTER/  \2 := LoadFunction('\2',AFailed);/" >> $UNITFILE
    
    sed  '/^implementation.*$/,$d' $FILE | sed "${HELPERS}d" | sed -n '/^ *\(procedure \|function \)/,$p'  | grep  "\($REMOVED\|$INTRODUCED\|$ALLOW_NIL\)" | \
    sed "s/$PROCFILTER/  \2 := LoadFunction('\2',nil);/" >> $UNITFILE
    
      
    sed  '/^implementation.*$/,$d' $FILE | sed "${HELPERS}d" | sed -n '/^ *\(procedure \|function \)/,$p'  | grep  "\($REMOVED\|$INTRODUCED\)" |\
    sed "s/$PROCFILTER *\({.*}\)/\
  if not assigned(\2) then \n\
  begin\n\
    {\$if declared(\2_introduced)}\n\
    if LibVersion < \2_introduced then\n\
      {\$if declared(FC_\2)}\n\
      \2 := @FC_\2\n\
      {\$else}\n\
      \2 := @ERR_\2\n\
      {\$ifend}\n\
    else\n\
    {\$ifend}\n\
   {\$if declared(\2_removed)}\n\
   if \2_removed <= LibVersion then\n\
     {\$if declared(_\2)}\n\
     \2 := @_\2\n\
     {\$else}\n\
       {\$IF declared(ERR_\2)}\n\
       \2 := @ERR_\2\n\
       {\$ifend}\n\
     {\$ifend}\n\
    else\n\
   {$\ifend}\n\
   if not assigned(\2) and Assigned(AFailed) then \n\
     AFailed.Add('\2');\n\
  end;\n\n/" >>$UNITFILE

    cat <<EOT >> $UNITFILE
end;

procedure Unload;
begin
EOT
    #Generate Unload procedures
    sed  '/^implementation.*$/,$d' $FILE | sed "${HELPERS}d" | grep -i '^ *\(procedure \|function \)' |\
    sed "s/$PROCFILTER/  \2 := nil;/" >> $UNITFILE

    #Complete Unit File
    cat <<EOT >> $UNITFILE
end;
{\$ELSE}
EOT
    #Static Library section
    #Copy functions to implementation section
    sed '0,/^implementation.*$/d' $FILE| sed '/^end\..*$/,$d'| sed "${HELPERS}d" | sed "${FORWARDS}d" | sed -n '/^ *\(procedure \|function \)/,$p' >>$UNITFILE
    
    cat <<EOT >> $UNITFILE
{\$ENDIF}

{\$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'$LIBNAME');
  Register_SSLUnloader(@Unload);
{\$ENDIF}
end.
EOT
fi
  
  #Add to All Headers
  echo  "$ALLHEADERS_SEPARATOR"  >>$ALLHEADERS
  echo -n "  $UNITNAME" >>$ALLHEADERS
  ALLHEADERS_SEPARATOR=,

done

#Complete Allheaders
(
  echo "  ;"
  echo ""
  echo "implementation"
  echo "end."
) >> "$ALLHEADERS"

