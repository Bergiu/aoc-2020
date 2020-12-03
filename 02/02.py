import unittest
from ddt import ddt, data, unpack

import re
from typing import List


class PasswordPolicy:
    @staticmethod
    def check_password(line: str):
        raise NotImplementedError()

    @classmethod
    def count_valid_passwords(cls, lines: List[str]) -> int:
        return sum(filter(None, map(cls.check_password, lines)))

    @classmethod
    def check_password_file(cls, filename: str) -> int:
        with open(filename) as file:
            return cls.count_valid_passwords(file.read().splitlines())


class OldPasswordPolicy(PasswordPolicy):
    @staticmethod
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


class NewPasswordPolicy(PasswordPolicy):
    @staticmethod
    def check_password(line: str) -> bool:
        reg = "(\\d+)-(\\d+) (.): (.*)"
        match = re.search(reg, line)
        if match:
            z1, z2, char, passwd = match.groups()
            if passwd[int(z1) - 1] == char and not passwd[int(z2) - 1] == char:
                return True
            if not passwd[int(z1) - 1] == char and passwd[int(z2) - 1] == char:
                return True
            return False
        print("No match")
        raise Exception("Wrong format")


@ddt
class TestOld(unittest.TestCase):
    @data("1-3 a: abc", "1-3 a: aaabc", "1-3 a: aabc")
    def test_check_password(self, inp):
        self.assertTrue(OldPasswordPolicy.check_password(inp))

    @data("2-3 a: abc", "1-3 a: aaaabc", "1-3 a: bc")
    def test_check_password_false(self, inp):
        self.assertFalse(OldPasswordPolicy.check_password(inp))

    @data(["1-3 a: abc", "2-3 a: abc", "5-10 x: xxxxx"])
    def test_count(self, inp):
        self.assertEqual(OldPasswordPolicy.count_valid_passwords(inp), 2)


@ddt
class TestNew(unittest.TestCase):
    @data("1-3 a: abcde")
    def test_check_password(self, inp):
        self.assertTrue(NewPasswordPolicy.check_password(inp))

    @data("1-3 b: cdefg", "2-9 c: ccccccccc")
    def test_check_password_false(self, inp):
        self.assertFalse(NewPasswordPolicy.check_password(inp))

    @data(["1-3 b: cdefg", "2-9 c: ccccccccc", "1-3 a: abcde"])
    def test_count(self, inp):
        self.assertEqual(NewPasswordPolicy.count_valid_passwords(inp), 1)


if __name__ == '__main__':
    print(OldPasswordPolicy.check_password_file("input2.txt"))
    print(NewPasswordPolicy.check_password_file("input2.txt"))

