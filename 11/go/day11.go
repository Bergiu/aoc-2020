package main

import (
	"bufio"
	"errors"
	"fmt"
	"log"
	"os"
)

var (
	empty int32 = 76
	floor int32 = 46
	occupied int32 = 35
	unknown int32 = -1
)

type Layout = [][]int32

func printLayout(layout Layout) {
	for _, line := range layout {
		for _, char := range line {
			fmt.Printf("%c ", char)
		}
		fmt.Print("\n")
	}
}

func parseData(input *bufio.Scanner) (layout Layout, error error) {
	for input.Scan() {
		line := input.Text()
		var row []int32
		for _, char := range line {
			if char == occupied || char == floor || char == empty {
				row = append(row, char)
			} else {
				return nil, errors.New("Invalid input")
			}
		}
		layout = append(layout, row)
	}
	return layout, nil
}


func readFile(filename string) (layout Layout, error error) {
	file, err := os.Open(filename)
	if err != nil {
		return nil, error
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	return parseData(scanner)
}


type coordinate struct {
	x int
	y int
}


func get_state(layout Layout, coord coordinate) int32 {
	xLen := len(layout)
	if coord.x < 0 || coord.y < 0 || coord.x >= xLen || coord.y >= len(layout[coord.x]) {
		return unknown
	}
	return layout[coord.x][coord.y]
}


func add(x int, y int) int {
	return x + y
}

func sub(x int, y int) int {
	return x - y
}

func no(x int, y int) int {
	return x
}

func Min(a int, b int) int {
	if a < b {
		return a
	}
	return b
}

func Max(a int, b int) int {
	if a < b {
		return b
	}
	return a
}

func intern(coordFunc FuncPair, layout Layout, x int, y int) bool {
	xPruefM := coordFunc.f1
	yPruefM := coordFunc.f2
	xLen := len(layout)
	yLen := len(layout[0])
	for diff := 1; diff < Min(xLen, yLen); diff++ {
		xPruef := xPruefM(x, diff)
		yPruef := yPruefM(y, diff)
		state := get_state(layout, coordinate{xPruef, yPruef})
		if state == occupied {
			return true
		} else if state == unknown || state == empty {
			return false
		}
	}
	return false
}

type FuncPair struct {
	f1 func(int, int) int
	f2 func(int, int) int
}

func count_occupied_around_2(layout Layout, x int, y int) int {
	coordFuncs := []FuncPair{
		{add, add},
		{add, sub},
		{sub, add},
		{sub, sub},
		{no, add},
		{no, sub},
		{add, no},
		{sub, no},
	}
	sum := 0
	for _, coordFunc := range coordFuncs {
		if intern(coordFunc, layout, x, y) {
			sum += 1
		}
	}
	return sum
}

func count_occupied_around_1(layout Layout, x int, y int) int {
	coords := []coordinate{
		{x + 1, y + 1},
		{x + 1, y - 1},
		{x - 1, y + 1},
		{x - 1, y - 1},
		{x, y + 1},
		{x, y - 1},
		{x + 1, y},
		{x - 1, y},
	}
	sum := 0
	for _, coord := range coords {
		if get_state(layout, coord) == occupied {
			sum += 1
		}
	}
	return sum
}


func count_occupied_around(layout Layout, x int, y int, version int) int {
	if version == 1 {
		return count_occupied_around_1(layout, x, y)
	} else {
		return count_occupied_around_2(layout, x, y)
	}
}

func round(layout Layout, emptyRule int, version int) (bool, Layout) {
	changed := false
	newLayout := make(Layout, len(layout))
	for x, line := range layout {
		newLayout[x] = make([]int32, len(line))
		copy(newLayout[x], line)
	}
	for x, line := range layout {
		for y, char := range line {
			if layout[x][y] == floor {
				continue
			}
			count := count_occupied_around(layout, x, y, version)
			if count == 0 && char == empty {
				changed = true
				newLayout[x][y] = occupied
			}
			if count >= emptyRule && char == occupied {
				changed = true
				newLayout[x][y] = empty
			}
		}
	}
	return changed, newLayout
}

func count_occupied_seats(layout Layout) (counter int) {
	counter = 0
	for _, line := range layout {
		for _, char := range line {
			if char == occupied {
				counter++
			}
		}
	}
	return
}

func run(layout Layout, emptyRule int, version int) (rounds int, outLayout Layout) {
	i := 0
	for {
		fmt.Printf("Round %v\n", i+1)
		changed, newLayout := round(layout, emptyRule, version)
		i += 1
		if ! changed {
			return i, layout
		} else {
			layout = newLayout
		}
	}
}

func part1(filename string) {
	print("Part 1\n")
	layout, err := readFile(filename)
	if err != nil {
		log.Fatal(err)
	}
	var rounds int
	rounds, layout = run(layout, 4, 1)
	fmt.Printf("Rounds: %v\n", rounds)
	count := count_occupied_seats(layout)
	fmt.Printf("Count: %v\n", count)
}

func part2(filename string) {
	print("Part 2\n")
	layout, err := readFile(filename)
	if err != nil {
		log.Fatal(err)
	}
	var rounds int
	rounds, layout = run(layout, 5, 2)
	fmt.Printf("Rounds: %v\n", rounds)
	count := count_occupied_seats(layout)
	fmt.Printf("Count: %v\n", count)
}

func main() {
	part1("input.txt")
	part2("input.txt")
}
