#!/bin/bash
len=$(cat input.txt | wc -l)
len_valid=$(grep -E "^[0-9][0-9]?-[0-9][0-9]? .: .+$" input.txt| wc -l)
test $len -eq $len_valid && echo "Valid" || echo "Invalid"
