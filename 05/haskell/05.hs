import Data.List


-- COMPILE: ghc -o 05.out 05.hs
-- RUN: ./05.out


-- GLOBALS --
upper = 1
lower = -1
neutral = 0
-------------


-- TYPES --
type SeatPositionBinary = [(Int, Int)]    -- binary description of the seat
type SeatCoordinates = (Int, Int)         -- x and y coordinates of a seat
type Seat = Int                           -- seat number (x*8 + y)
-----------


-- HELPER --
transform_list_in_tuple :: [(Int, Int)] -> ([Int], [Int])
-- transforms a list of 2-tuples into two lists
transform_list_in_tuple list = (map fst list, map snd list)
------------


-- BINARY SEAT FINDER --
_binary_seat_finder :: [Int] -> Int -> Int -> Int -> Int
-- converts the binary description of the position into its number
_binary_seat_finder list lower higher multi
  | lower == higher = lower
  | (head list) == upper = _binary_seat_finder (tail list) (lower + multi) higher (multi `div` 2)
  | (head list) == lower = _binary_seat_finder (tail list) lower (higher - multi) (multi `div` 2)
  | otherwise = _binary_seat_finder (tail list) lower higher multi


binary_seat_finder_fb :: [Int] -> Int
-- finds the seat in front/back direction
binary_seat_finder_fb list = _binary_seat_finder list 0 127 64


binary_seat_finder_lr :: [Int] -> Int
-- finds the seat in right/left direction
binary_seat_finder_lr list = _binary_seat_finder list 0 7 4


convert_binary_pos_to_coordinates :: SeatPositionBinary -> SeatCoordinates
-- calculates the coordinates of the seat
convert_binary_pos_to_coordinates binary = do
    let transformed = transform_list_in_tuple binary
    (binary_seat_finder_fb (fst transformed), binary_seat_finder_lr (snd transformed))
------------------------


-- PARSER --
convert_char :: Char -> (Int, Int)
-- converts the chars into binary directions
convert_char single_char
  | single_char == 'B' = (upper, neutral)  -- upper half (64-127)
  | single_char == 'F' = (lower, neutral)  -- lower half (0-63)
  | single_char == 'R' = (neutral, upper)  -- upper half (4-7)
  | single_char == 'L' = (neutral, lower)  -- lower half (0-3)
  | otherwise = (neutral, neutral)


interpret_line :: String -> SeatPositionBinary
-- interprets the string as the binary position of a seat
interpret_line line = map convert_char line


parse_line :: String -> SeatCoordinates
-- interprets the string as a position of a seat
-- and returns the coordinates of the seat
parse_line line = do
    let binary_position = interpret_line line
    convert_binary_pos_to_coordinates binary_position
------------


-- REST --
get_seat_number :: SeatCoordinates -> Seat
-- converts coordinates of a seat into the seat number
get_seat_number coordinates = fst coordinates * 8 + snd coordinates


_find_my_seat :: [Seat] -> Seat -> Seat
-- to find my seat, i iterate over the list and compare the last and the current seat
-- if the difference between them is 2, my seat is between them
-- !! needs a sorted list of seats !!
_find_my_seat seats last_seat
  | (head seats) - 2 == last_seat = last_seat + 1
  | otherwise = _find_my_seat (tail seats) (head seats)


find_my_seat :: [Seat] -> Seat
find_my_seat seats = _find_my_seat seats (head seats)
----------


process_file filename = do
    content <- readFile(filename)
    let seats_coordinates = map parse_line (lines content)
    let seats = sort (map get_seat_number seats_coordinates)
    print("Maximum (Part 1):")
    print(maximum seats)
    print("My Seat (Part 2)")
    print(find_my_seat seats)

main = process_file "input.txt"
