from typing import List
from functools import reduce


def part1(filename: str) -> List[int]:
    with open(filename) as file:
        data = map(lambda block: len(set(block.replace("\n", ""))), file.read().split("\n\n"))
        return sum(data)


def part2(filename: str) -> List[int]:
    with open(filename) as file:
        return sum(map(lambda x: len(reduce(lambda fs1, fs2: fs1.intersection(fs2), x)), map(lambda block: map(set, filter(None, block.split("\n"))), file.read().split("\n\n"))))


if __name__ == '__main__':
    result = part1("input.txt")
    print(result)
    result = part2("input.txt")
    print(result)
