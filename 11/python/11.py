from enum import Enum


class State(Enum):
    Floor = "."
    Empty = "L"
    Occupied = "#"
    Unknown = None

    def __lt__(self, other):
        return self.value < other.value

    def __str__(self):
        return self.value


def _get_state(search_field):
    for field in State:
        if field.value.lower() == search_field.lower():
            return field
    raise Exception(f"Invalid field: {field.value}")


def _convert_line(line):
    return list(map(_get_state, line.strip()))


def read_file(filename):
    with open(filename) as file:
        return list(map(_convert_line, file.readlines()))


class Layout:
    def __init__(self, layout):
        self.layout = layout

    def __str__(self):
        return "\n".join(map(lambda x: " ".join(map(str, x)), self.layout)) + "\n"

    def print(self):
        print(str(self))

    def get(self, x, y):
        x_len = len(self.layout)
        if x < 0 or y < 0 or x >= x_len or y >= len(self.layout[x]):
            return State.Unknown
        return self.layout[x][y]

    def __eq__(self, other):
        return sorted(self.layout) == sorted(other.layout)

    @staticmethod
    def copy(self):
        return Layout([[x for x in y] for y in self.layout])


class Game:
    def __init__(self, layout, part, should_print=False):
        self.layout = layout
        self.should_print = should_print
        self.part = part

    def count_occupied_around_part_2(self, x, y):
        results = [None] * 8

        def add(x, y):
            return x + y

        def sub(x, y):
            return x - y

        def no(x, y):
            return x
        coords = [(add, add), (add, sub),
                  (sub, add), (sub, sub),
                  (no, add), (no, sub),
                  (add, no), (sub, no)]

        def intern(enumeration):
            i, pruef = enumeration
            x_pruef_m, y_pruef_m = pruef
            a = len(self.layout.layout)
            b = len(self.layout.layout[0])
            for diff in range(1, min(a, b)):
                x_pruef = x_pruef_m(x, diff)
                y_pruef = y_pruef_m(y, diff)
                state = self.layout.get(x_pruef, y_pruef)
                if state == State.Occupied:
                    return True
                if state == State.Empty or state == State.Unknown:
                    return False
            return False
        return sum(map(intern, enumerate(coords)))

    def count_occupied_around_part_1(self, x, y):
        coords = [(x + 1, y + 1), (x + 1, y - 1), (x - 1, y + 1), (x - 1, y - 1),
        (x, y + 1), (x, y - 1), (x + 1, y), (x - 1, y)]
        return sum([True for x, y in coords if self.layout.get(x, y) == State.Occupied])

    def count_occupied_around(self, x, y):
        if self.part == 1:
            return self.count_occupied_around_part_1(x, y)
        if self.part == 2:
            return self.count_occupied_around_part_2(x, y)

    def round(self):
        new_layout = Layout.copy(self.layout)
        for x in range(len(self.layout.layout)):
            for y in range(len(self.layout.layout[x])):
                if self.layout.layout[x][y] == State.Floor:
                    continue
                # print("a", end="", flush=True)
                count = self.count_occupied_around(x, y)
                if count == 0 and self.layout.layout[x][y] == State.Empty:
                    new_layout.layout[x][y] = State.Occupied
                if count >= 4 and self.layout.layout[x][y] == State.Occupied:
                    new_layout.layout[x][y] = State.Empty
        if self.layout == new_layout:
            return False
        self.layout = new_layout
        return True

    def maybe_print(self):
        if self.should_print:
            self.layout.print()

    def print(self):
        self.layout.print()

    def run(self, rounds):
        rounds = 0
        if self.should_print:
            print(f"Game Input:")
        self.maybe_print()
        while True:
            print(f"Round {rounds+1}")
            changed = self.round()
            self.maybe_print()
            rounds += 1
            if not changed:
                print(f"Terminated after {rounds} rounds.")
                return rounds

    @staticmethod
    def load(filename, part):
        raw_layout: List[List[int]] = read_file(filename)
        layout = Layout(raw_layout)
        return Game(layout, part)

    def count_occupied_seats(self):
        return sum([sum([pos == State.Occupied for pos in line])
                    for line in self.layout.layout])


def part1(filename):
    print("Part 1")
    game = Game.load(filename, 1)
    game.run(10)
    print(game.count_occupied_seats())


def part2(filename):
    print("Part 2")
    game = Game.load(filename, 2)
    game.run(10)
    print(game.count_occupied_seats())


if __name__ == '__main__':
    part1("test_input.txt")
    part2("test_input.txt")
