#!/bin/bash
# A sample script

cp $1 $2

# Let's verify the copy worked

echo Details for $2
ls -lh $2

# $0  returns the name of the Bash script.
$0

# $1-$9 refers to the first 9 arguments to the Bash script.
# $# gives how many arguments were passed to the Bash script.
$#

# $@ gives all the arguments passed to the Bash script.
$@

# $$ gives the process ID of the current script.
$$

# $USER gives the username of the user running the script.
$USER

# $HOSTNAME gives the hostname of the machine the scripts running on.
$HOSTNAME

# $SECONDS gives the number of seconds since the script was started.
$SECONDS

# $RANDOM returns a different random number each time it is referred to.
$RANDOM

# $LINENO returns the current line number in the Bash script.
$LINENO

# $? returns the exit status of the most recently run process.
$?

# env is a command that will give you a list of other vairables you may refer to.
env

sampledir=/etc

ls $sampledir

# command substitution using output in a variable
myvar=$( ls /etc | wc -l)
echo There are $myvar entries in the directory /etc

