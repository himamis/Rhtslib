#! /bin/bash

R_BIN="${1:-`which R`}"

R_CC=`${R_BIN} CMD config CC`

echo $R_CC

