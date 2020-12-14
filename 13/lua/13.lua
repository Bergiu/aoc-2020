parser = require("parser")


metatable = {
    __lt = function(t1, t2)  --> overload the __lt operator in this table
        return t1[1] < t2[1]
    end
}

function bus_diff(arrival, bus_id)
    local diff = {bus_id - (arrival % bus_id), bus_id} --> create table with diff and bus id
    setmetatable(diff, metatable)                      --> the diff table now has __lt method
    return diff
end

function bus_diffs(arrival, busses)
    local diffs = {}
    local i, bus
    for i, bus in ipairs(busses) do --> iterate over list
        table.insert(diffs, bus_diff(arrival, bus))
    end
    return diffs
end

function print_diffs(diffs) --> prints all diffs for debugging purposes
    local i
    for i = 1, #diffs do --> #diffs means length of diffs
        print(diffs[i][1], diffs[i][2])
    end
end

function minimum_waittime(diffs)
    table.sort(diffs)              --> uses __lt method to sort the table
    return table.unpack(diffs[1])  --> first element is the smallest
end

function find_time(busses)
    local first_bus = table.remove(busses, 1)
    local t = first_bus
    local i, bus
    for i, bus in ipairs(busses) do
        if bus ~= "x" then
            repeat
                t = t + first_bus
                if (t + i) % bus == 0 then
                    first_bus = first_bus * bus
                    break
                end
            until false
        end
    end
    return t
end


function part1(filename)
    print("Part 1")
    local arrival, busses
    arrival, busses = parser.read_file(filename)
    local diffs = bus_diffs(arrival, busses)
    local waittime, bus = minimum_waittime(diffs)
    print(waittime * bus)
end

function part2(filename)
    print("Part 2")
    local _, busses
    _, busses = parser.read_file(filename, false)
    print(find_time(busses))
end


function main()
    part1("input.txt")
    part2("input.txt")
end


main()
