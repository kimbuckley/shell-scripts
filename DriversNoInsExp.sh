#!/bin/bash

# define string to find and directory to search
STRING="<DateContinuousInsurance>"
DIRECTORY="/*.xml"

# loop over files in a directory
for FILE in $DIRECTORY;
do
  INSURANCE=false
  # if string is present in file
  if grep -l $STRING $FILE; then
    INSURANCE=true
  else
    # save file name only
    FILENAME=`basename $FILE`
    # output filename to text file
    echo $FILENAME >> DriversNoInsExp.txt
  fi
done
