#!/bin/bash

################
# MULTIPLE FDS #
################

echo "################\n# MULTIPLE FDS #\n################\n" > results/bonus_folder/$3
echo "${4}" >> results/bonus_folder/$3
PROJECT='project.a'
GET_NEXT_LINE_FILES="${1}get_next_line_bonus.c ${1}get_next_line_utils_bonus.c"
OBJ="get_next_line_bonus.o get_next_line_utils_bonus.o"
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=$2 -c $GET_NEXT_LINE_FILES
ar rc utils/$PROJECT $OBJ
ranlib utils/$PROJECT
rm $OBJ
	
ret1='\033[1;31m[KO]\033[0m'
gcc -Wall -Werror -Wextra -g3 -o extest utils/$PROJECT gnl_test/tests/test_multiple_fds.c gnl_test/gnl_test_utils.c
/bin/echo "$(valgrind --log-file=valou ./extest tests_files/shakespear.txt tests_files/poe.txt tests_files/1_line_of_5_char_ending_with_bn.txt)" >> results/bonus_folder/$3
grep "definitely lost" valou | cut -d: -f2 > utils/maybe_leaks
rm -rf valou
if cmp -s -i $5:52 results/bonus_folder/$3 results/bonus_folder/bonus_corr
then
ret1='\033[1;32m[OK]\033[0m'
fi
if ! cmp -s utils/no_leaks utils/maybe_leaks
then
re1="\033[1;31m/!\\\\\033[0m${ret1}"
fi
rm extest
echo "BONUS buffer[\033[1;33m${2}\033[0m]: ${ret1}"