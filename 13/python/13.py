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


if __name__ == '__main__':
    part1("input.txt")
