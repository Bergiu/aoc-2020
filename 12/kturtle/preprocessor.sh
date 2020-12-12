#!/bin/bash
cp part1.kturtle out_part1.kturtle
sed -e 's/^./& /g' input.txt >> out_part1.kturtle
echo "manhattandistance" >> out_part1.kturtle

cp part2.kturtle out_part2.kturtle
sed -e 's/^./& /g' input.txt >> out_part2.kturtle
echo "manhattandistance" >> out_part2.kturtle
