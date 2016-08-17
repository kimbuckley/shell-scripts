#!/bin/bash

# define string to find and directory to search
STRINGS=("<Claim>" "<Conviction>" "<Reason>" "Lapse</IncidentType>")
DIRECTORY="/*.xml"

# loop over files in a directory
for FILE in $DIRECTORY;
do
  CLEAN=true
  # if string is present in file
  for STRING in "${STRINGS[@]}"
  do
    if grep -l $STRING $FILE; then
      CLEAN=false
    fi
  done

  if $CLEAN == true; then
    # save file name only
    FILENAME=`basename $FILE`
    # output filename to text file
    echo $FILENAME >> CleanDrivers.txt
  fi
done
