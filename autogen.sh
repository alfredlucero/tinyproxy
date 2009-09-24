#!/bin/sh
# -*- sh -*-
#
# Make the Autotools scripts after checking out the source code from CVS.
# This script was taken from the Autotool Book.  I wonder if autoreconf
# can now be used...
#

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.
ORIGDIR=`pwd`

set -x

cd $srcdir

aclocal -I m4macros \
  && autoheader \
  && automake --gnu --add-missing \
  && autoconf

cd $ORIGDIR

set -

echo $srcdir/configure --enable-maintainer-mode "$@"
$srcdir/configure --enable-maintainer-mode "$@"
RC=$?
if test $RC -ne 0; then
  echo
  echo "Configure failed or did not finish!"
  exit $RC
fi

echo
echo "Now type 'make' to compile Tinyproxy."
