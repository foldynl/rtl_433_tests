#!/bin/bash
if [ "$#" -ne 1 ]; then
   echo "Illegal number of parameters"
   echo "Usage: $0 <path_to_rtl_433>"
   exit
fi
## Test command
CMD="$1/rtl_433 -r"

## Find all data files (sort for consistency between runs)
DATAFILES=$(find . -iname "*.data" | sort)

## Run though all test data
for FILE in $DATAFILES
do
    # in case of very bad samples, check if they require specific level to pass
    # use only in emergency
    LEVEL_FILE="$(dirname "$FILE")/level"
    if [[ -r "$LEVEL_FILE" ]] ; then
        LEVEL="-l $(cat "$LEVEL_FILE")"
    else
        LEVEL=
    fi
	$CMD $FILE $LEVEL
done

