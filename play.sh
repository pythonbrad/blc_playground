#!/usr/bin/env bash

error=0

output=$(python -m blc.blc -n -d .5 -b 5 $HOST)

for i in $(echo "$output" | grep "\w* errors" -o | grep "[0-9]*" -o)
do
  if [ $i != 0 ]
  then
    error=1
  fi
done

echo "$output"

exit $error
