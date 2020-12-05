#!/bin/bash
vim -u vimrc\
    --cmd "let step_down = $STEP_DOWN"\
    --cmd "let step_right = $STEP_RIGHT"\
    +"%normal N" `# execute N for every line`\
    +"normal ggdG" `# delete pattern`\
    +"put =tree_counter" `# insert count`\
    +"normal kdd" `# delete emptyline`\
    +"w! input_edited.txt" `# save in a new file`\
    +"q!" `# quit`\
    input.txt
