#!/usr/bin/env bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <x> <y>"
    exit 1
fi

if ! [[ $1 =~ ^-?[0-9]+.?[0-9]*$ ]] || ! [[ $2 =~ ^-?[0-9]+.?[0-9]*$ ]]; then
    echo "Arguments must be numeric"
    exit 1
fi

x=$1
y=$2

r2=$(bc <<< "($x)^2 + ($y)^2")

if [[ "$(bc <<< "$r2 <= 1")" == "1" ]]; then
    # Radius 1
    echo "10"
elif [[ "$(bc <<< "$r2 <= 25")" == "1" ]]; then
    # Radius 5
    echo "5"
elif [[ "$(bc <<< "$r2 <= 100")" == "1" ]]; then
    # Radius 10
    echo "1"
else
    # Miss
    echo "0"
fi
