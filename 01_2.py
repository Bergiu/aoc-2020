from typing import List, Tuple


def read_nums(filename: str) -> List[int]:
    "Reads all numbers in a file, split by new lines and sorted."
    with open(filename) as file:
        data = sorted(map(int, file.read().splitlines()))
        return data


def find_nums(numbers: List[int], number_sum: int) -> Tuple[int, int]:
    """Finds two numbers in the list that add up to 2020.

    Improved performance.
    """
    for pos in range(len(numbers)):
        num1 = numbers[pos]
        for num2 in numbers[pos + 1::-1]:
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

