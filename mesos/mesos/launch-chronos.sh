#!/bin/bash

if [ "$#" -ne 1 ]; then
    	echo "script takes json file as an argument"
	exit 1;
fi

curl -i -L -H 'Content-Type: application/json' -X POST -d@"$@"  10.0.0.128:8081/scheduler/iso8601
