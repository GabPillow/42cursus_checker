#!/bin/bash

###############
# BUFFER_SIZE #
###############

echo "What is the size of buffer you want ?"
read BUFFER_SIZE
/bin/echo -n "$BUFFER_SIZE" > utils/buffer_size