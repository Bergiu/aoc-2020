#!/bin/bash
# part 1
sed -e "s/^$/;/gm" "$1" `# separate passports by ;` | tr "\n" " " | tr ";" "\n" | sed -e "s/^ //gm" `# every passport in one line` | xargs -I @ bash -c 'echo "@;" | sed -e "s/ /\n/gm" | sort | tr "\n" " " | tr ";" "\n" | sed -e "s/^ //gm" `# sorted fields` | grep -E "^byr:(.+) (cid:(.+) )?ecl:(.+) eyr:(.+) hcl:(.*) hgt:(.*) iyr:(.*) pid:(.*)$"' `#filtered valid passports` | wc -l
