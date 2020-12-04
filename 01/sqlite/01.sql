create table if not exists day1 (value INTEGER, pk INTEGER PRIMARY KEY AUTOINCREMENT);
delete from day1;
.import input.txt day1
SELECT "Part 1";
select first.value, second.value, first.value*second.value from day1 as first join day1 as second where first.value + second.value == 2020 and first.pk < second.pk;
SELECT "Part 2";
select first.value, second.value, third.value, first.value*second.value*third.value from day1 as first join day1 as second join day1 as third where first.value + second.value + third.value == 2020 and first.pk < second.pk and second.pk < third.pk;
