#!/bin/bash
# part 2
sed -e "s/^$/;/gm" "$1" `# separate passports by ;` | tr "\n" " " | tr ";" "\n" | sed -e "s/^ //gm" `# every passport in one line` | xargs -I @ bash -c 'echo "@;" | sed -e "s/ /\n/gm" | sort | tr "\n" " " | tr ";" "\n" | sed -e "s/^ //gm" `# sorted fields` | grep -E "^byr:((19[2-9][0-9])|(200[0-2])) (cid:(.+) )?ecl:(amb|blu|brn|gry|grn|hzl|oth) eyr:((202[0-9])|2030) hcl:(#[0-9a-f]{6}) hgt:(((1[5-8][0-9])|(19[0-3]))cm|(59|(6[0-9])|(7[0-6]))in) iyr:((201[0-9])|2020) pid:([0-9]{9})\s*$"' `#filtered valid passports` | wc -l
