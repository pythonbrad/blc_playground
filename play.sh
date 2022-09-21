#!/usr/bin/env bash

error=0

for i in $(python -m blc.blc -D -n -d .5 -b 5 $HOST | grep "\w* errors" -o | grep "[0-9]*" -o)
do
  if [ $i != 0 ]
  then
    error=1
  fi
done

exit $error
