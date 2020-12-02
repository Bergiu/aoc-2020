from typing import List, Tuple
import bisect


def read_nums(filename: str) -> List[int]:
    "Reads all numbers in a file, split by new lines and sorted."
    with open(filename) as file:
        data = sorted(map(int, file.read().splitlines()))
        return data


def find_nums(numbers: List[int], number_sum: int) -> Tuple[int, int]:
    """Finds two numbers in the list that add up to 2020.

    Complexity: n log n
    """
    for pos1, num1 in enumerate(numbers):
        sub = number_sum - num1
        # start searching at next position
        pos2 = bisect.bisect_left(numbers, sub, pos1 + 1)
        if pos2 != len(numbers) and numbers[pos2] == sub:
            return (num1, numbers[pos2])
    raise Exception("Sum is not possible")


def find_nums_part_2(numbers: List[int], number_sum: int) -> Tuple[int, int, int]:
    """Finds three numbers in the list that add up to 2020.

    Complexity: 2n log n
    """
    for pos1, num1 in enumerate(numbers):
        for pos2, num2 in enumerate(numbers):
            sub = number_sum - num1 - num2
            # start searching at next position
            pos3 = bisect.bisect_left(numbers, sub, pos1 + 1)
            if pos3 != len(numbers) and numbers[pos3] == sub:
                return (num1, numbers[pos3], num2)
    raise Exception("Sum is not possible")


def main():
    numbers: List[int] = read_nums("input.txt")
    num1, num2 = find_nums(numbers, 2020)
    print(num1, num2)
    print(num1 * num2)
    num1, num2, num3 = find_nums_part_2(numbers, 2020)
    print(num1, num2, num3)
    print(num1 * num2 * num3)


if __name__ == '__main__':
    main()

