#!/usr/bin/env bash

input=$1
# Anything other than digits and spaces is invalid
if [[ ! $input =~ ^[[:digit:][:space:]]*$ ]]; then
    echo "false"
    exit
fi

# Strip to just digits
number=${1//[^0-9]/}

# Single digits are invalid
if [[ ${#number} -le 1 ]]; then
    echo "false"
    exit
fi

# Create array from digits
mapfile -t digits < <(fold -w1 <<< "$number")

# Double every second digit from right
# So if length odd, every second digit from the left
# or if even every first digit from the left
if (( ${#digits[@]} % 2 == 1 )); then
    double_index=1
else
    double_index=0
fi

sum=0
for i in "${!digits[@]}"; do
    if (( i % 2 == double_index )); then
        new_number=$(( digits[i] * 2 ))
        if [[ ${#new_number} -eq 2 ]]; then
            new_number=$(( new_number - 9 ))
        fi
    else
        new_number=${digits[i]}
    fi

    sum=$(( sum + new_number ))
done


# Valid if result is factor of ten
(( sum % 10 == 0 )) && echo "true" || echo "false"
