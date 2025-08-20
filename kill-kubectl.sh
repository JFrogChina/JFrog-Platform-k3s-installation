#!/bin/bash

pids=$(ps -ef | grep kubectl | grep -v grep | awk '{print $2}')

if [ -z "$pids" ]; then
    echo "No running kubectl process found."
else
    echo "Killing the following kubectl processes: $pids"
    kill -9 $pids
fi
