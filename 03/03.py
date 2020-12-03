from typing import List, Tuple
import unittest
from functools import reduce
import math


def count_trees(pattern: List[str], steps_right: int = 3, steps_down: int = 1):
    return sum(map(
        lambda tup: tup[1][tup[0] * steps_right % len(tup[1])] == "#",
        enumerate(pattern[::steps_down])
    ))


def multiply(lines: List[str], traversal: List[Tuple[int, int]]) -> int:
    return math.prod(map(lambda tup: count_trees(lines, *tup), traversal))


def read_file(filename):
    with open(filename) as file:
        return file.read().splitlines()


test_pattern = """..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#"""


class Test(unittest.TestCase):
    def test_count_trees(self):
        self.assertEqual(count_trees(test_pattern.splitlines()), 7)

    def test_count_improved(self):
        self.assertEqual(count_trees(test_pattern.splitlines(), 1), 2)
        self.assertEqual(count_trees(test_pattern.splitlines(), 3), 7)
        self.assertEqual(count_trees(test_pattern.splitlines(), 5), 3)
        self.assertEqual(count_trees(test_pattern.splitlines(), 7), 4)
        self.assertEqual(count_trees(test_pattern.splitlines(), 1, 2), 2)

    def test_multiply(self):
        traversal = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
        self.assertEqual(multiply(test_pattern.splitlines(), traversal), 336)


def part1():
    lines = read_file("input.txt")
    print(count_trees(lines))


def part2():
    lines = read_file("input.txt")
    traversal = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
    print(multiply(lines, traversal))


if __name__ == '__main__':
    part1()
    part2()
