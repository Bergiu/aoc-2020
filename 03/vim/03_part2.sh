#!/bin/bash

# $1 := input file

multi=1

export STEP_DOWN=1
i=0
for STEP_RIGHT in {1..7..2}
do
    export STEP_RIGHT
    i=$((i+1))
    ./03_part1.sh "$1" "tmp$i"
    multi=$((multi*$(cat "tmp$i")))
done

export STEP_DOWN=2
export STEP_RIGHT=1
i=$((i+1))
./03_part1.sh "$1" "tmp$i"
multi=$((multi*$(cat "tmp$i")))

echo $multi
rm tmp*
