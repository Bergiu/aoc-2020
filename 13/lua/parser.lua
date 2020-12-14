local parser = {}
local function parse_busses(lines, ignore_x)
    local busses = {}
    local word
    for word in string.gmatch(lines, "[^,]+") do
        local conv = tonumber(word) --> "x" will be nil
        if conv ~= nil then --> checks if conv not equals nil
            table.insert(busses, conv)
        elseif not ignore_x then
            table.insert(busses, "x")
        end
    end
    return busses
end

function parser.read_file(filename, ignore_x)
    if ignore_x == nil then ignore_x = true end --> default value
    local lines = {}
    local line
    for line in io.lines(filename) do --> read every line
        table.insert(lines, line)
    end
    lines[2] = parse_busses(lines[2], ignore_x)
    return tonumber(lines[1]), lines[2]
end

return parser
