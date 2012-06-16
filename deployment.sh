#!/bin/bash
#
# Wrapper script for our fabfile, to be called from Jenkins
#

# Where our fabfile is
FABFILE=/usr/local/bin/fabfile.py

HOST=$1
SITE=$2
PROFILE=$3
WEBSERVER=$4
DBSERVER=$5
MAKEFILE=$6
BUILD_NUMBER=$7
DATE=`date +%Y%m%d%H%M%S`

if [[ -z $HOST ]] || [[ -z $SITE ]] || [[ -z $PROFILE ]] || [[ -z $WEBSERVER ]] || [[ -z $DBSERVER ]] || [[ -z $MAKEFILE ]] || [[ -z $BUILD_NUMBER ]]
then
  echo "Missing args! Exiting"
  exit 1
fi


# Array of tasks - these are actually functions in the fabfile, as an array here for the sake of abstraction
if [ $BUILD_NUMBER -eq "1" ]; then
  # This is a first-time ever build. Let's install a site instead of migrate it
  TASKS=(
   build_platform
   save_alias
   install_site
   run_tests
  )
else
  TASKS=(
    build_platform
    migrate_site
    save_alias
    import_site
    run_tests
  )
fi

# Loop over each 'task' and call it as a function via the fabfile, 
# with some extra arguments which are sent to this shell script by Jenkins
for task in ${TASKS[@]}; do
  fab -f $FABFILE -H $HOST $task:site=$SITE,profile=$PROFILE,webserver=$WEBSERVER,dbserver=$DBSERVER,makefile=$MAKEFILE,build=$DATE || exit 1
done
