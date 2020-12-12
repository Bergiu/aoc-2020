.( Hello World!) CR

( Large letter F)
: STAR 42 EMIT ;
: STARS 0 DO STAR LOOP ;
: MARGIN CR 30 SPACES ;
: BLIP MARGIN STAR ;
: BAR MARGIN 5 STARS ;
: F BAR BLIP BAR BLIP BLIP CR ;

F

10 5 STARS

CR

( n -- n+1 )
: ++ 1 + ;

1 ++ STARS

( n1 n2 -- sum )
( dieser kommentar sagt, dass vorher auf dem stack n1 und n2 waren und jetzt nur noch die summe dort ist)

( Duplicates the last element in the stack )
1 dup
( now 1 1 is on the stack )

( drops the last element )
drop
( now ony 1 is on the stack )

swap
( swaps last two )

3 4 over
( kopiert das vorletzte element auf den stack )
( auf dem stack ist dann 3 4 3 )

1 2 3 rot
( rotiert die letzten 3 elemente )
( 2 3 1 )

1 2 3 . . . .
( . printed den top stack )

45 emit
( emit gibt letzte zahl als ascii aus )
( und entfernt sie vom stack )
( dup emit, wenn man die zahl nicht entfernen will )

cr
( neue zeile )

." hallo welt"
( ." printed einen string. aufpassen: das leerzeichen nach der klammer am anfang, aber nicht mehr am ende... )

( booleans: 0 = false; alles andere true; 5 5 = gibt -1 aus )
5 5 =
4 5 <

( es gibt: and or invert )

true .
false .

cr cr

: ⭐️ 42 EMIT ;
: 😳⭐️ 0 DO ⭐️ LOOP ;
: ❤️ 10 😳⭐️ ;

❤️


: buzz? 5 mod 0 = if ." Buzz" then ;
3 buzz?
4 buzz?
5 buzz?


: is-it-zero?  0 = if ." Yes!" else ." No!" then ;
0 is-it-zero?
1 is-it-zero?
2 is-it-zero?


: loop-test 10 0 do i . loop ;



variable balance ( associates memory for variable balance )
balance ( pushes its memory location on the stack )
.

123 balance ! ( stores a value at the memory location referenced )
balance @ . ( @ fetches the value from a memory location )

( ? is defined as @ . )
( +! ist quasi += )

variable numbers
3 cells allot ( 4 memory )
10 numbers 0 cells + !
20 numbers 1 cells + !
30 numbers 2 cells + !
40 numbers 3 cells + !

variable nums
3 cells allot
: num  ( offset -- addr )  cells nums + ;

10 0 num !
20 1 num !
30 2 num !
40 3 num !

2 num ?


( keyboard input )
key . key . key .


( Forth has another kind of loop called begin until. This works like a while loop in C-based languages. Every time the word until is hit, the interpreter checks to see if the top of the stack is non-zero true. If it is, it jumps back to the matching begin. If not, execution continues. )
: print-keycode  begin key dup . 32 = until ;
print-keycode
