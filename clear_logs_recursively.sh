#!/bin/bash
cd /var/log
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
