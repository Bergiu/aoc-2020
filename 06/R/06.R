library(stringr)
library(sets)


read_blocks <- function(filename) {
    lines <- readLines(filename)
    text <- unlist(paste(lines, sep="", collapse="\n"))
    x <- strsplit(text, "\n\n")
}


count_any <- function(group) {
    # count questions answered by anyone of the group
    # every line in the group is the union of all persons
    # when we make a set, we have all questions that are answered
    sets <- lapply(group, as.set)
    # sum up the length of the sets
    Reduce(sum, lapply(sets, length))
}


part1 <- function(raw_blocks) {
    # remove \n and split the string into single chars
    blocks <- lapply(lapply(raw_blocks, gsub, pattern="\n", replacement=""), strsplit, "")
    # count any question on the groups
    # somehow this is in a list. i don't know why
    lapply(blocks, count_any)
}

count_every <- function(person) {
    # makes every line to a set and then makes a intersection of these sets
    # returns the count of elements of the intersection
    length(Reduce(set_intersection, lapply(strsplit(person, ""), as.set)))
}

part2 <- function(raw_blocks) {
    for (blocks in raw_blocks) {
        # no idea why here is a loop
        len_sum <- 0
        for (block in blocks) {
            len_sum <- len_sum + Reduce(sum, lapply(strsplit(block, "\n"), count_every))
        }
        return(len_sum)
    }
}

main <- function() {
    filename <- "input.txt"
    raw_blocks = read_blocks(filename)
    print("Part 1")
    print(part1(raw_blocks))
    print("Part 2")
    print(part2(raw_blocks))
}


main()
