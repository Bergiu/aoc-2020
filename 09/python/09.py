import unittest


def read_file(filename: str):
    with open(filename) as file:
        data = list(map(int, file.readlines()))
        return data


def find_pair(preamble, sum):
    for num in preamble:
        try:
            preamble.index(sum - num)
            return True
        except ValueError:
            pass


def validate(lines, preamble_length=25):
    for i, line in enumerate(lines[preamble_length:]):
        preamble = lines[i:i + preamble_length]
        if not find_pair(preamble, line):
            return line


def find_sum_set(lines, number):
    sum = 0
    sum_set = []
    for line in lines:
        sum += line
        sum_set.append(line)
        if sum == number:
            return sum_set
        elif sum >= number:
            return find_sum_set(lines[1:], number)
        else:
            continue
    raise Exception("Nothing found")


def part2_get_num(lines, preamble_length=25):
    number = validate(lines, preamble_length)
    sum_set = find_sum_set(lines, number)
    return min(sum_set) + max(sum_set)


def part1(filename):
    lines = read_file(filename)
    wrong_num = validate(lines)
    print(wrong_num)


def part2(filename):
    lines = read_file(filename)
    sum = part2_get_num(lines)
    print(sum)


test_input = """35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576"""


class Part1(unittest.TestCase):
    def test(self):
        lines = list(map(int, test_input.splitlines()))
        self.assertEqual(validate(lines, 5), 127)


class Part2(unittest.TestCase):
    def test(self):
        lines = list(map(int, test_input.splitlines()))
        self.assertEqual(part2_get_num(lines, 5), 62)


if __name__ == '__main__':
    part1("input.txt")
    part2("input.txt")
