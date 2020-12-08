from typing import List, Dict
import unittest
from dataclasses import dataclass


def read_file(filename: str):
    with open(filename) as file:
        data = file.readlines()
        return data


@dataclass
class Dependency:
    color: str
    amount: int


def parse_colors(lines: List[str]) -> Dict[str, Dependency]:
    colors = {}
    for line in lines:
        split = line.split(" ")
        color = " ".join(split[:2])
        dependencies = []
        i = 4
        while True:
            if len(split) < i + 3:
                break
            dep = line.split(" ")[i:i + 3]
            amount = dep[0]
            if amount == "no":
                break
            inner_color = " ".join(dep[1:])
            dependencies.append(Dependency(inner_color, int(amount)))
            i += 4
        colors[color] = dependencies
    return colors


def _count_dependencies(colors, bag):
    count = 0
    for dep in colors[bag]:
        count += _count_dependencies(colors, dep.color) * dep.amount
    return count + 1


def count_dependencies(colors, bag):
    return _count_dependencies(colors, bag) - 1


def _find_possible_parents(colors, bag, parents):
    for color, dependencies in colors.items():
        for dep in dependencies:
            if dep.color == bag:
                parents.add(color)
                _find_possible_parents(colors, color, parents)


def find_possible_parents(colors, bag):
    parent_colors = set()
    _find_possible_parents(colors, bag, parent_colors)
    return parent_colors


example = """light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags."""


example2 = """shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags."""


class Test(unittest.TestCase):
    def test_count_dependencies(self):
        colors = parse_colors(example.splitlines())
        self.assertEqual(count_dependencies(colors, "faded blue"), 0)
        self.assertEqual(count_dependencies(colors, "dotted black"), 0)
        self.assertEqual(count_dependencies(colors, "vibrant plum"), 11)
        self.assertEqual(count_dependencies(colors, "dark olive"), 7)
        self.assertEqual(count_dependencies(colors, "shiny gold"), 32)
        colors = parse_colors(example2.splitlines())
        self.assertEqual(count_dependencies(colors, "shiny gold"), 126)

    def test_find_possible_parents(self):
        colors = parse_colors(example.splitlines())
        self.assertEqual(len(find_possible_parents(colors, "shiny gold")), 4)


def part1(filename):
    lines = read_file(filename)
    colors = parse_colors(lines)
    my_bag = "shiny gold"
    cnt = find_possible_parents(colors, my_bag)
    print(len(cnt))


def part2(filename):
    lines = read_file(filename)
    colors = parse_colors(lines)
    my_bag = "shiny gold"
    cnt = count_dependencies(colors, my_bag)
    print(cnt)


if __name__ == '__main__':
    part1("input.txt")
    part2("input.txt")

