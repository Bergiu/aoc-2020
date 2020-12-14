-- Comment
print("Hello World")
--[[
multiline
]]
name = "Derek"
io.write("Size of string ", #name, "\n")
io.write("Size of string ", name, "\n")
io.write("Type of string ", type(name), "\n")
io.write("Type of string ", type(7), "\n")
longString = [[
I am a very very long
string that goes on forever]]

longString = longString .. name

io.write(longString, "\n")

driver = true

print(5+3,5-3,5*3,5/3,5%3)
number = 8
number = number + 1

-- es gibt viele build in math functions

-- boolean:
-- > < >= <= ==
-- not equal ~=
-- and or not

age = 12
age = age + 1

-- strings: "string"
-- chars: 'c'
-- patterns: '[%w_]*'

-- program "Hello World"
print("Hello World") --> Hello World (result of the expression)
print(13 + 3)        --> 16

-- this == that

-- defines a factorial function
function fact (n)
    if n == 0 then
        return 1
    else
        return n * fact(n-1)
    end
end

print("enter a number:")
a = io.read("*number")
print(fact(a))

-- ein chunk ist eine sequenz aus statements
-- semikolons und newlines sind optional
a = 1
b = a*2

a = 1;
b = a*2;

a = 1; b = a*2;

a = 1 b = a*2

if age < 16 then
    io.write("cool\n")
    local localVar = 8  -- ist local to this function
elseif(age <= 16) and (age < 18) then
    io.write("nice\n")
else
    io.write("perfect\n")
end

print(localVar)  -- nil

-- canVote = age > 18 ? true : false
canVote = age > 18 and true or false
quote = "I likes chicken"
print(string.gsub(quote, "I", "me"), "\n")
print(string.find(quote, "I"), "\n")

i = 1
while (i<=10) do
    io.write(i)
    i = i + 1
    if i == 8 then break end
end

repeat
    io.write("enter")
    guess = io.read()
until true -- tonumber(guess) == 15

-- STRING to NUMBER: tonumber(...)


for i = 1, 10, 1 do
    io.write(i)
end

mytable = {"jan", "feb", "marc", "april"}  -- table; like a list

for key, value in pairs(mytable) do
    io.write(key, value)
end

aTable = {}
for i = 1, 10 do
    aTable[i] = i
end

io.write(#aTable)  -- length of table

table.insert(aTable, 1, 0)
print(table.concat(aTable, ", "))

function getSum(a1, a2)
    return a1 + a2
end

print(getSum(7, 9))


function splitStr(theString)
    stringTable = {}
    local i = 1
    for word in string.gmatch(theString, "[^%s]+") do  -- regex: while no space
        stringTable[i] = word
        i = i + 1
    end
    return stringTable, i
end

splitStrTable, num = splitStr("Hallo Welt, Wie gehts")
for j = 1, num do
    print(splitStrTable[j])
end

function getSumMore(...)
    local sum = 0
    for k, v in pairs{...} do -- attributes are unwrapped
        sum = sum + v
    end
    return sum
end

print(getSumMore(35,5,23,2,4,6,6))

-- functions are variables
doubleIt = function(x) return x * 2 end
dit = doubleIt
print(dit(7))

-- closure
function outerFunc()
    local i = 0
    return function()
        i = i+1
        return i
    end
end

getI = outerFunc()
print(getI())
print(getI())
print(getI())
print(getI())


-- coroutine
-- threats without parallel

co = coroutine.create(function()
    for i = 1, 10, 1 do
        print(i)
        print(coroutine.status(co))
        if i == 5 then coroutine.yield() end
    end
end)


print(coroutine.status(co))
coroutine.resume(co)
print(coroutine.status(co))

co2 = coroutine.create(function()
    for i = 101, 110, 1 do
        print(i)
    end
end)

coroutine.resume(co2)
coroutine.resume(co)
print(coroutine.status(co))


file = io.open("input.txt", "r")

-- file:write("random\n")
-- file:write("nextline")
-- file:seek("set", 0) -- go to line 1
-- print(file:read("*a"))  -- read everything (a: all)
-- file:close()


-- module: filename: convert.lua

-- local convert = {}  -- table that indizes our module
-- function convert.ftToCm(feet)  -- add a method to the table
--     return feet + 30.48
-- end
-- return convert  -- return our module

-- other file:
-- convertModule = require("convert")
-- print(convert.ftToCm(7))


-- meta tables
aTable = {}
for x = 1, 10 do
    aTable[x] = x
end

mt = {
    __add = function(table1, table2) -- define how tables should be added
        sumTable = {}
        for y = 1, #table1 do
            if (table1[y] ~= nil) and (table2[y] ~= nil) then
                sumTable[y] = table1[y] + table2[y]
            else
                sumTable[y] = 0
            end
        end
        return sumTable
    end,
    -- __sub -- how tables should be subtracted
    -- __mul
    -- __div 
    -- __mod -- modulo
    -- __concat
    __eq = function(t1, t2) -- equality
        return t1.value == t2.value
    end
    -- __lt
    -- __le
}


setmetatable(aTable, mt)
