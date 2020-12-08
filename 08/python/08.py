
def read_file(filename: str):
    with open(filename) as file:
        data = list(map(lambda line: line.split(" "), file.readlines()))
        return data


def prepare_instructions(instructions):
    # second argument in tuple is if the line was already executed
    return list(map(lambda inst: [inst[0], int(inst[1]), False], instructions))


class LoopException(Exception):
    pass


def run_instruction(instruction, acc, pos):
    if instruction[2]:
        raise LoopException()
    instruction[2] = True
    if instruction[0] == "acc":
        acc += instruction[1]
        pos += 1
    elif instruction[0] == "jmp":
        pos += instruction[1]
    else:
        pos += 1
    return (acc, pos)


def run(instructions):
    instructions = prepare_instructions(instructions)
    acc = 0
    pos = 0
    try:
        while pos >= 0 and pos < len(instructions):
            acc, pos = run_instruction(instructions[pos], acc, pos)
        return (True, pos, acc)
    except LoopException:
        return (False, pos, acc)


def next_change(change_pos, instructions):
    for i, line in enumerate(instructions[change_pos:]):
        if line[0] == "nop":
            new_instructions = instructions
            new_instructions[i + change_pos][0] = "jmp"
            return (i + change_pos, new_instructions)
        elif line[0] == "jmp":
            new_instructions = instructions
            new_instructions[i + change_pos][0] = "nop"
            return (i + change_pos, new_instructions)
    raise Exception()


def bruteforce(instructions):
    original_instructions = instructions.copy()
    change_pos = 0
    length = len(instructions)
    while change_pos < length:
        change_pos, new_instructions = next_change(change_pos + 1, [a.copy() for a in instructions])
        terminated, _, acc = run(new_instructions)
        if terminated:
            return acc


def part1(filename):
    instructions = read_file(filename)
    terminated, pos, acc = run(instructions)
    print(acc)


def part2(filename):
    instructions = read_file(filename)
    acc = bruteforce(instructions)
    print(acc)


if __name__ == '__main__':
    part1("input.txt")
    part2("input.txt")
