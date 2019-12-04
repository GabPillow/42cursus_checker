#!/bin/bash

############
# Aff Menu #
############

echo "\033[1;34m########
# Menu #
########\033[0m\n
Path : \033[1;33m| $(cat utils/PATH_GNL) |\033[0m
Buffer_size : \033[1;33m| $(cat utils/buffer_size) |\033[0m
\033[1;31m/!\\\\\033[0m : Leaks
\033[1;32m[OK]\033[0m : Ok keep going
\033[1;31m[KO]\033[0m : Result not ok (look at the results folder for more info)\n
Needed for first use :
a. Change path
b. Change BUFFER_SIZE
____________________________\n
1. Run all tests
2. Run simple test
3. Run No crash test
4. Run Error return
5. BONUS
0. Exit
Choose :"