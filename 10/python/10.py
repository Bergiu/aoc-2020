from functools import reduce
from itertools import combinations
import unittest


def read_file(filename: str):
    with open(filename) as file:
        data = list(map(int, file.readlines()))
        return data


def count_differences(numbers):
    numbers = sorted(numbers)
    one_jolt = 0
    three_jolt = 0
    for i, num in enumerate(numbers[1:]):
        jolt = num - numbers[i]
        if jolt == 1:
            one_jolt += 1
        elif jolt == 3:
            three_jolt += 1
    return (one_jolt, three_jolt)


def validate(numbers):
    numbers = sorted(numbers)
    for i, num in enumerate(numbers[1:]):
        jolt = num - numbers[i]
        if jolt > 3:
            return False
    return True


def find_invalid(length: int):
    if length < 3:
        return 1
    return ((length - 1) * 2) - 1


def count_combinations(numbers):
    numbers.append(0)
    numbers.append(max(numbers) + 3)
    numbers = sorted(numbers)
    cache = [0] * (numbers[len(numbers) - 1] + 3)
    cache.append(1)
    for i in range(len(numbers))[::-1]:
        x = numbers[i]
        cache[x] = cache[x + 1] + cache[x + 2] + cache[x + 3]
    return cache[0]


def part1(filename):
    lines = read_file(filename)
    lines.append(0)
    lines.append(max(lines) + 3)
    one_jolt, three_jolt = count_differences(lines)
    print(one_jolt, three_jolt)
    print(one_jolt * three_jolt)


def part2(filename):
    lines = read_file(filename)
    print(count_combinations(lines))


test_input = """28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3"""


test_input_2 = """16
10
15
5
1
11
7
19
6
12
4"""


class Part1(unittest.TestCase):
    def test(self):
        lines = list(map(int, test_input.splitlines()))
        lines.append(0)
        lines.append(max(lines) + 3)
        one_jolt, three_jolt = count_differences(lines)
        self.assertEqual(one_jolt * three_jolt, 220)


class Part2(unittest.TestCase):
    def test(self):
        lines = list(map(int, test_input.splitlines()))
        combine = count_combinations(lines)
        self.assertEqual(combine, 19208)


if __name__ == '__main__':
    part1("input.txt")
    part2("input.txt")
