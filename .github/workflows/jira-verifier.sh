#!/bin/bash

alphabets=( "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" )
numbers=( "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" )
arg=$1
code=$(echo "$arg" | cut -d '-' -f 1)
number=$(echo "$arg" | cut -d '-' -f 2)
codeLength=${#code}
numLength=${#number}
split=$(echo "$code" | grep -o .)
split2=$(echo "$number" | grep -o .)

errorOrHelpMessage() {
echo "
The correct format of the argument is 

Example argument: ABC-1234

The alphabets before the hyphen like so \"ABC-\".

|**********************************************|
|                                              |
|  NOTE: all the alphabets must be in capital  |
|                                              |
|**********************************************|

The numbers after the hyphen like so \"-1234\".

-h or --help : for viewing the help document for the file

which are passed in like ./jira-verifier.sh <your.argument>"
    exit 1
}

if [[ -z "$arg" || -z "$code" || -z "$number" || "$arg" == "-h" || "$arg" == "--help" ]];
then
errorOrHelpMessage
else
    if [[ $codeLength -le 10 && $numLength -le 10 ]];
    then
        for ((i=1; i<=codeLength; i++))
        do
            :
            code=$(echo $split | cut -d ' ' -f $i)
            if [[ " ${alphabets[*]} " == *"$code"* ]];
            then
                # echo "correct format"
                continue
            else
                errorOrHelpMessage
            fi
        done

        for ((i=1; i<=codeLength; i++))
        do
        : 
            number=$(echo $split2 | cut -d ' ' -f $i)
            if [[ " ${numbers[*]} " == *"$number"* ]];
            then
                # echo "correct format"
                continue
            else
                errorOrHelpMessage
            fi
        done
    else
        echo "the length is greater than 10 characters"
        exit 1
    fi
fi
