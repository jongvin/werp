#!/bin/sh
# -----------------------------------------------------
# Run with -help for usage.
# If $JAVA_HOME is set, editing this script should not be required.
# Send any questions to fchoong@user.sourceforge.net
# -----------------------------------------------------

# the value set here will override the value passed by $JAVA_HOME or the -jdkhome switch
# Make sure prerequisite environment variables are set
if [ -z "$JAVA_HOME" ]; then
  echo "The JAVA_HOME environment variable is not defined"
  echo "This environment variable is needed to run this program"
  exit 1
fi

if [ ! -r "$JAVA_HOME"/bin/java -o ! -r "$JAVA_HOME"/bin/jdb -o ! -r "$JAVA_HOME"/bin/javac ]; then
  echo "The JAVA_HOME environment variable is not defined correctly"
  echo "This environment variable is needed to run this program"
  exit 1
fi

# Set standard commands for invoking Java.
_RUNJAVA="$JAVA_HOME"/bin/java

#jdkhome="/usr/java/jdk1.3.1_10"
#_RUNJAVA="$jdkhome"/bin/java
jargs="../WEB-INF/lib/hsqldb.jar"

PRG=$0

#
# resolve symlinks
#

while [ -h "$PRG" ]; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '^.*-> \(.*\)$' 2>/dev/null`
    if expr "$link" : '^/' 2> /dev/null >/dev/null; then
	PRG="$link"
    else
	PRG="`dirname $PRG`/$link"
    fi
done

progdir=`dirname $PRG`
progname=`basename $0`

# ../ will lead us to the home
dbhome="$progdir/.."

# absolutize dbhome

dbhome=`cd ${dbhome}; pwd`
CLASSPATH="$dbhome"/WEB-INF/lib/hsqldb.jar
# ----- Execute The Requested Command -----------------------------------------
echo "Using dbhome:         $dbhome"
echo "Using CLASSPATH:       $CLASSPATH"

#
# let's go
#
    cd ../sample40
    "$_RUNJAVA" \
    -classpath "$CLASSPATH":.: org.hsqldb.Server -database gauce
# and we exit.
