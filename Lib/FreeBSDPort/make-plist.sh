#!/bin/sh
# taken from 
#http://www.freebsd.org/doc/en_US.ISO8859-1/books/porters-handbook/book.html#PLIST-DYNAMIC
mkdir /var/tmp/$(make -V PORTNAME)
mtree -U -f $(make -V MTREE_FILE) -d -e -p /var/tmp/$(make -V PORTNAME)
make depends PREFIX=/var/tmp/$(make -V PORTNAME)
#Store the directory structure in a new file.
(cd /var/tmp/$(make -V PORTNAME) && find -d * -type d) | sort > OLD-DIRS
touch pkg-plist
#If your port honors PREFIX (which it should) you can then install the 
#port and create the package list.
make install PREFIX=/var/tmp/$(make -V PORTNAME)
(cd /var/tmp/$(make -V PORTNAME) && find -d * \! -type d) | sort > pkg-plist
#You must also add any newly created directories to the packing list.
(cd /var/tmp/$(make -V PORTNAME) && find -d * -type d) | sort | comm -13 OLD-DIRS - | 
sort -r | sed -e 's#^#@dirrm #' >> pkg-plist
#Clean package
make deinstall PREFIX=/var/tmp/$(make -V PORTNAME)
rm -rf /var/tmp/$(make -V PORTNAME)
