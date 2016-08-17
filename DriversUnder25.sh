#!/bin/bash

#######################################
## MUST USE 'brew install coreutils' ##
## BEFORE RUNNING THIS SCRIPT        ##
## OR IT WON'T WORK!!                ##
## NOTE: ALL 'DATE' ITEMS MUST       ##
## CONTAIN A 'G' IN FRONT OF THEM    ##
#######################################

# define directory to search and current date
DIRECTORY="/*.xml"
CURRENT_DATE=$(date '+%Y%m%d')

# loop over files in a directory
for FILE in $DIRECTORY;
do
  # set flag for output to false initially
  FLAG=false

  # grab user's birth date from XML file
  BIRTH_DATE=$(sed -n '/Birthdate/{s/.*<Birthdate>//;s/<\/Birthdate.*//;p;}' $FILE)

  # loop through birth dates in file (there can be multiple drivers)
  for BIRTHDAY in $BIRTH_DATE;
  do
    # calculate the difference between the current date
    # and the user's birth date (seconds)
    DIFFERENCE=$(( ( $(gdate -ud $CURRENT_DATE +'%s') - $(gdate -ud $BIRTHDAY +'%s') )/60/60/24))

    # calculate the number of years between
    # the current date and the user's birth date
    YEARS=$(($DIFFERENCE / 365))

    # if the user is under 25
    if [ "$YEARS" -le 25 ]; then
      # save file name only
      FILENAME=`basename $FILE`
      # set flag to true (driver is under 25 years of age)
      FLAG=true
    fi
  done

  # if there is a driver under 25 in the file
  if $FLAG == true; then
    # output filename to text file
    echo $FILENAME >> DriversUnder25.txt
  fi
done
