#!/bin/bash

SCRIPT=`basename ${BASH_SOURCE[0]}`
PUPPET_MASTER= 
CERTNAME= 
function USAGE {
  echo -e "\\n-------------------------------------------------------------"\\n
  echo -e "Usage:$SCRIPT -m master_hostname -c certname_to_register"\\n
  echo "Command line switches are must. The following switches are recognized."
  echo "-a  --Sets the value for "
  echo "-b  --Sets the value for "
  echo -e "-h  --Displays this help message. No further functions are performed."\\n
  echo -e "Example: $SCRIPT -m puppet.example.org  -c node1.example.org "\\n
  echo -e "\\n-------------------------------------------------------------"\\n
  exit 1
}

NUMARGS=$#
if [ $NUMARGS -lt 2 ]; then
  USAGE
fi

while getopts mc: OPTION; do
  case $OPTION in
    m)
      PUPPET_MASTER=$OPTARG
      ;;
    c)  
      CERTNAME=$OPTARG
      ;;
    h) 
      USAGE
      ;;
  esac
done

echo "master: $PUPPET_MASTER"
echo "cert:  $CERTNAME"