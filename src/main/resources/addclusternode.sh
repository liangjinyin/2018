#!/usr/bin/env bash
dir=`dirname $0`
if [ $# -ne 5 ];then
   echo "usage: ip  usrname password soucefile installpath"
   exit -1
fi
ip=$1
user=$2
pwd=$3
source=$4
dest=$5
expect scp-files.exp $ip $user $pwd $dir/$source $dest
echo "success!"
exit 0

