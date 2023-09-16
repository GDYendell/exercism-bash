#!/usr/bin/env bash

PLAIN="abcdefghijklmnopqrstuvwxyz1234567890"
CIPHER="zyxwvutsrqponmlkjihgfedcba1234567890"

map_letter() {
    letter=$1
    letter=${letter,,} # To lower case
    input=$2
    output=$3

    # If `letter` is not empty find its replacement
    if [[ -n "$letter" ]]; then
        # Strip `letter` and remaining string from `input`
        stripped=${input%%"$letter"*}
        # The remaining length is the `index` of the `letter` in `input`
        index=${#stripped}

        # `index` less than `output` length means a match
        if [ "$index" -lt "${#output}" ]; then
            # Lookup the resulting letter by indexing `output`
            encoded=${output:index:1}

            echo "$encoded"
        fi
    fi
}

encode_letter() {
    map_letter "$letter" "$PLAIN" "$CIPHER"
}

decode_letter() {
    map_letter "$letter" "$CIPHER" "$PLAIN"
}

encode() {
    encoded=""
    i=0
    while read -r -d '' -n 1 letter; do
        encoded_letter=$(encode_letter "$letter")

        # If encoded letter is not empty then add it
        if [[ -n "$encoded_letter" ]]; then
            # Insert a space every 5 letters
            if (( i == 5 )); then
                encoded+=" "
                i=0
            fi
            i=$((i + 1))

            encoded+="$encoded_letter"
        fi
    done < <(printf %s "$1")

    echo "$encoded"
}

decode() {
    decoded=""
    while read -r -d '' -n 1 letter; do
        decoded+=$(decode_letter "$letter")
    done < <(printf %s "$1")

    echo "$decoded"
}

main() {
    if [[ "$1" == "encode" ]]; then
        encode "$2"
    elif [[ "$1" == "decode" ]]; then
        decode "$2"
    fi
}

main "$@"
