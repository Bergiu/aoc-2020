import unittest
from ddt import ddt, data, unpack

import re
from typing import List


def check_password(line: str) -> bool:
    reg = "(\\d+)-(\\d+) (.): (.*)"
    match = re.search(reg, line)
    if match:
        z1, z2, char, passwd = match.groups()
        amount_chars = len(passwd.split(char)) - 1
        if amount_chars >= int(z1) and amount_chars <= int(z2):
            return True
        return False
    print("No match")
    raise Exception("Wrong format")


def count_valid_passwords(lines: List[str]) -> int:
    return len(list(filter(None, map(check_password, lines))))


def check_password_file(filename: str) -> int:
    with open(filename) as file:
        return count_valid_passwords(file.read().splitlines())


@ddt
class FooTestCase(unittest.TestCase):
    @data("1-3 a: abc", "1-3 a: aaabc", "1-3 a: aabc")
    def test_check_password(self, inp):
        self.assertTrue(check_password(inp))

    @data("2-3 a: abc", "1-3 a: aaaabc", "1-3 a: bc")
    def test_check_password_false(self, inp):
        self.assertFalse(check_password(inp))

    @data(["1-3 a: abc", "2-3 a: abc", "5-10 x: xxxxx"])
    def test_count(self, inp):
        self.assertEqual(count_valid_passwords(inp), 2)


if __name__ == '__main__':
    print(check_password_file("input2.txt"))

