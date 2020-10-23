#!/bin/bash
#hivestorm linux scripts


##########################################
# Functions
##########################################
function checkRoot {
    if [ "$EUID" -ne 0 ]
        then echo "Please run with sudo permissions."
        exit 
    fi     
}

function getUsers {
    while read line; do
        a="$(cut -d':' -f3 <<<$line)"
        if [ $a -ge 1000  ] && [ $a -ne 65534 ]; then 
            usNa="$(cut -d':' -f1 <<<$line)"
            users+=("$usNa")
            echo "$usNa"
        fi
    done < /etc/passwd
    echo ${users[*]}
}

function checkUsers {
    #YOU MUST CUSTOMIZE THIS
    authorized_users=("foo" "bar")
    for i in "${users[@]}"; do
        echo $i
        if [[ ! " ${authorized_users[@]} " =~ " $i " ]]; then
            echo Unauthorized User: $i
        fi
    done
}


users=()
checkRoot
getUsers
checkUsers