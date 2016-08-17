#!/bin/bash

# define string to find and directory to search
STRING="<LicenseClass>G2</LicenseClass>"
DIRECTORY="/*.xml"

# loop over files in a directory
for FILE in $DIRECTORY;
do
  # if string is present in file
  if grep -l $STRING $FILE; then
    # save file name only
    FILENAME=`basename $FILE`
    # output filename to text file
    echo $FILENAME >> DriversLicense_G2.txt
  fi
done
