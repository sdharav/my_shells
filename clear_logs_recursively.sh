#!/bin/bash

<<README
   supply the parent directory, in which all the log files should emptied.
   ex: bash lear_logs_recursively.sh /var/log
   This does not work in redhat based operating systems
README

cd $1
directories=`ls -d */`
for directory in $directories;
do
    cd $directory
    echo `pwd`
    for file in *
    do
        if [ ${file: -4} == ".log" ]; then
            > $file
        fi
    done
    cd -
done
