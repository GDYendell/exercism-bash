#!/usr/bin/env bash

series=$1
slice=$2

if [[ $slice -lt 0 ]]; then
    echo "slice length cannot be negative"
    exit 1
elif [[ $slice -eq 0 ]]; then
    echo "slice length cannot be zero"
    exit 1
elif [[ ${#series} -eq 0 ]]; then
    echo "series cannot be empty"
    exit 1
elif [[ $slice -gt ${#series} ]]; then
    echo "slice length cannot be greater than series length"
    exit 1
fi

sub_series=()
for (( i=0; i < ${#series} - (slice - 1); i++ )); do
    sub_series+=("${series:$i:$slice}")
done
IFS=' ' echo "${sub_series[*]}"
