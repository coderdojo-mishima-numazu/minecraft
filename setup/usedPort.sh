#!/bin/bash

function isUsedPort()
{

    cmd=$(eval "sudo lsof -i:$1 | awk 'NR==2{print \$1}'")

    if [ -n "$cmd" ]; then
        return 1
    else
        return 0
    fi

}
