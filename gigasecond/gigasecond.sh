#!/usr/bin/env bash

timestamp=$1

now=$(date -d "$timestamp" +%s)

future=$(( now + 10**9 ))

date -d "@$future" "+%Y-%m-%dT%H:%M:%S"
