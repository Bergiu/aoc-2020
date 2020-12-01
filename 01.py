from typing import List


def read_nums(filename: str) -> List[int]:
    "Reads all numbers in a file, split by new lines."
    numbers = []
    with open(filename) as f:
        for line in f:
            numbers.append(int(line))
    return numbers


def find_nums(numbers: List[int]):
    "Finds two numbers in the list that add up to 2020."
    for num1 in numbers:
        for num2 in numbers:
            if num1 + num2 == 2020:
                return (num1, num2)


def main():
    numbers: List[int] = read_nums("input.txt")
    num1, num2 = find_nums(numbers)
    print(num1, num2)
    print(num1 * num2)


if __name__ == '__main__':
    main()
