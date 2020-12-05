#!/bin/bash
# $1 := input pattern
# $2 := output file
# ./03_part1.sh input.txt output.txt

echo "Traversal: $STEP_DOWN - $STEP_RIGHT"

vim -u vimrc\
    --cmd "let step_down = $STEP_DOWN"\
    --cmd "let step_right = $STEP_RIGHT"\
    +"normal @q" `# execute q macro`\
    +"normal ggdG" `# delete pattern`\
    +"put =tree_counter" `# insert count`\
    +"normal kdd" `# delete emptyline`\
    +"w! $2" `# save in a new file`\
    +"q!" `# quit`\
    "$1"

cat "$2"
