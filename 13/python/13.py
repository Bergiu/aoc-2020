def read_file(filename):
    with open(filename) as file:
        lines = file.readlines()
        busses = list(map(int, filter(lambda a: a.isnumeric(), lines[1].split(","))))
        return (int(lines[0]), busses)


def bus_diff(arival, bus_id):
    return (bus_id - (arival % bus_id), bus_id)


def part1(filename):
    print("Part 1")
    arival, busses = read_file(filename)
    diffs = [bus_diff(arival, bus) for bus in busses]
    waittime, bus = min(diffs)
    print(waittime * bus)


def int_or_none(i):
    if i.isnumeric():
        return int(i)
    return None


def read_file_part2(filename):
    with open(filename) as file:
        lines = file.readlines()
        busses = list(map(int_or_none, lines[1].split(",")))
        return busses


def find_time(busses):
    first_bus = busses.pop(0)
    t = first_bus
    for i, bus in enumerate(busses):
        if bus is None:
            continue
        while True:
            t += first_bus
            if (t + i) % bus == 0:
                first_bus *= bus
                break
    return t


def part2(filename):
    print("Part 2")
    busses = read_file_part2(filename)
    print(find_time(busses))


if __name__ == '__main__':
    part1("input.txt")
    part2("input.txt")
