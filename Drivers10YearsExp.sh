#!/bin/bash

#######################################
## MUST USE 'brew install coreutils' ##
## BEFORE RUNNING THIS SCRIPT        ##
## OR IT WON'T WORK!!                ##
## NOTE: ALL 'DATE' ITEMS MUST       ##
## CONTAIN A 'G' IN FRONT OF THEM    ##
#######################################

# define directory to search and current date
DIRECTORY="/.xml"
CURRENT_DATE=$(date +'%Y%m%d')

# loop over files in a directory
for FILE in $DIRECTORY;
do
  # grab user's license class from XML file
  LICENSE_CLASS=$(sed -n '/LicenseClass/{s/.*<LicenseClass>//;s/<\/LicenseClass>.*//;p;}' $FILE)

  for LICENSE in $LICENSE_CLASS;
  do
    if [ "$LICENSE" == "G2" ]; then
      # grab user's license date from XML file
      LICENSE_DATE=$(grep -A1 '<LicenseClass>G2</LicenseClass>' $FILE | sed -n '/LicenseDate/{s/.*<LicenseDate>//;s/<\/LicenseDate.*//;p;}')
      break
    elif [ "$LICENSE" == "G" ]; then
      # grab user's license date from XML file
      LICENSE_DATE=$(grep -A1 '<LicenseClass>G</LicenseClass>' $FILE | sed -n '/LicenseDate/{s/.*<LicenseDate>//;s/<\/LicenseDate.*//;p;}')
    fi
  done

  # set flag for output to false initially
  FLAG=false

  # loop through license dates in file
  # (there can be multiple license dates/drivers)
  for DATE in $LICENSE_DATE;
  do
    # calculate the difference between the current date
    # and the user's license date (seconds)
    DIFFERENCE=$(( ( $(gdate -ud $CURRENT_DATE +'%s') - $(gdate -ud $DATE +'%s') )/60/60/24))

    # calculate the number of years between
    # the current date and the user's license date
    YEARS=$(($DIFFERENCE / 365))

    # if the driver has more than 10 years experience
    if [ "$YEARS" -ge 10 ]; then
      # save file name only
      FILENAME=`basename $FILE`
      # set flag to true (driver has more than 10 years experience)
      FLAG=true
    fi
  done

  # if there is a driver with more than
  # 10 years experience in the file
  if $FLAG == true; then
    # output filename to text file
    echo $FILENAME >> Drivers10YearsExp.txt
  fi
done
