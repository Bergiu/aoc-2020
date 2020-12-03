from typing import List, Tuple


def read_nums(filename: str) -> List[int]:
    "Reads all numbers in a file, split by new lines."
    numbers = []
    with open(filename) as file:
        for line in file:
            numbers.append(int(line))
    return numbers


def find_nums(numbers: List[int], number_sum: int) -> Tuple[int, int]:
    "Finds two numbers in the list that add up to 2020."
    for pos1, num1 in enumerate(numbers):
        for pos2, num2 in enumerate(numbers):
            if pos1 == pos2:
                continue
            if num1 + num2 == number_sum:
                return (num1, num2)
    raise Exception("Sum is not possible")


def main():
    numbers: List[int] = read_nums("input.txt")
    num1, num2 = find_nums(numbers, 2020)
    print(num1, num2)
    print(num1 * num2)


if __name__ == '__main__':
    main()
