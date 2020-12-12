: len-num
 105
;

variable nums len-num cells allot
: num cells nums + ;

 73   0 num !
114   1 num !
100   2 num !
122   3 num !
 10   4 num !
141   5 num !
 89   6 num !
 70   7 num !
134   8 num !
  2   9 num !
116  10 num !
 30  11 num !
123  12 num !
 81  13 num !
104  14 num !
 42  15 num !
142  16 num !
 26  17 num !
 15  18 num !
 92  19 num !
 56  20 num !
 60  21 num !
  3  22 num !
151  23 num !
 11  24 num !
129  25 num !
167  26 num !
 76  27 num !
 18  28 num !
 78  29 num !
 32  30 num !
110  31 num !
  8  32 num !
119  33 num !
164  34 num !
143  35 num !
 87  36 num !
  4  37 num !
  9  38 num !
107  39 num !
130  40 num !
 19  41 num !
 52  42 num !
 84  43 num !
 55  44 num !
 69  45 num !
 71  46 num !
 83  47 num !
165  48 num !
 72  49 num !
156  50 num !
 41  51 num !
 40  52 num !
  1  53 num !
 61  54 num !
158  55 num !
 27  56 num !
 31  57 num !
155  58 num !
 25  59 num !
 93  60 num !
166  61 num !
 59  62 num !
108  63 num !
 98  64 num !
149  65 num !
124  66 num !
 65  67 num !
 77  68 num !
 88  69 num !
 46  70 num !
 14  71 num !
 64  72 num !
 39  73 num !
140  74 num !
 95  75 num !
113  76 num !
 54  77 num !
 66  78 num !
137  79 num !
101  80 num !
 22  81 num !
 82  82 num !
 21  83 num !
131  84 num !
109  85 num !
 45  86 num !
150  87 num !
 94  88 num !
 36  89 num !
 20  90 num !
 33  91 num !
 49  92 num !
146  93 num !
157  94 num !
 99  95 num !
  7  96 num !
 53  97 num !
161  98 num !
115  99 num !
127 100 num !
152 101 num !
128 102 num !

: max-num ( length -- max )
  0 swap ( 0 l )
  0 do ( 0 )
    i num @ ( 0 5 )
    2dup ( 0 5 0 5 )
    < ( 0 5 -1 )
    if ( 0 5 )
      swap drop ( 5 )
    else ( 0 5 )
      drop ( 0 )
    then
  loop
;

: print-num
  len-num 0 do
    i num ?
  loop
;

: swap-num ( zielpos pruefpos -- )
  swap 2dup ( stack: p z p z ) ( 0 4 0 4 0 )
  ( tmp = myarray[zielpos] )
  num @ ( loescht zielpos und speichert dort den wert aus dem array ) ( 0 4 0 4 73 )
  swap ( holt pruefpos nach vorne und schiebt tmp nach hinten ) ( 0 4 0 73 4 )
  num @ ( loescht pruefpos und speichert dort den wert aus dem array ) ( 0 4 0 73 10 )
  rot ( 0 4 73 10 0 )
  ( myarray[zielPos] = myarray[pruefpos] )
  num ! ( 0 4 73 )
  swap ( 0 73 4 )
  ( myarray[pruefpos] = tmp )
  num ! ( 0 )
;

: sort ( -- )
  len-num 1 - 0 do ( loop )
    i ( zielPos )
    len-num i 1 + do ( second loop )
      dup dup ( 0 0 0 )
      num @ ( myArray[zielPos] ) ( 0 0 73 )
      i num @ ( myArray[pruefPos] ) ( 0 0 73 114 )
      > ( 0 0 -1/0 )
      if ( 0 0 )
        i ( 0 0 1 ) ( 0 zielpos pruefpos )
        swap-num ( 0 )
      else ( 0 0 )
        drop ( 0 )
      then
    loop
    drop
  loop
;

: prepare-num ( -- )
  0 103 num !
  max-num 3 + 104 num !
  sort
;



( increases the last value on the stack )
: inc ( n1 -- n1+1 ) 1 + ;
( increases the prev value on the stack )
: prev-inc ( n1 n2 -- n1+1 n2 ) swap 1 + swap ;


: count-differences ( -- one-jolt three-jolt )
  0 0 ( one-jolt and three-jolt counter )
  len-num 1 do
    i num @ ( 0 0 21 )
    i 1 - num @ ( 0 0 21 19 )
    - ( 0 0 2 )
    dup ( 0 0 2 2 )
    1 = ( 0 0 2 0/-1 )
    if ( 0 0 2 )
      drop ( 0 0 )
      prev-inc ( 1 0 )
    else ( 0 0 2 )
        3 = ( 0 0 0/-1 )
        if ( 0 0 )
          inc ( 0 1 )
        then
    then
  loop
;

2variable cache-var 1000 cells allot
: cache cells nums + ;

: len-cache ( -- n )
    170 3 + 1 +
;

: print-cache
  len-cache 0 do
    i 2 * cache 2@ d.
  loop
;

: init-cache ( -- )
  len-cache 0 do
    0. i 2 * cache 2!
  loop
  1. len-cache 2 * cache 2!
;

: count-combinations ( -- n )
  init-cache
  len-num 0 do
    len-num i - nums @
    3 - 2 * cache 2@ ( x + 3 )
    len-num i - nums @
    2 - 2 * cache 2@ ( x + 2 )
    len-num i - nums @
    1 - 2 * cache 2@ ( x + 1 )
    d+ d+ ( cache[x+1] + cache[x+1] + cache[x+1] )
    len-num i - 2 * cache 2!
  loop
  print-cache
  0 cache 2@
;

: part1
  .( Part 1: ) cr
  count-differences
  * .
;

: part2
  .( Part 2: ) cr
  count-combinations
  * d.
;

: main
  103 prepare-num
  part1
  part2
;

main

