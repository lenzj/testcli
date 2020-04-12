#!/bin/sh

displayUsage () {
  echo "Purpose:  A trivial demonstration script. The argument string is processed" >&2
  echo "          and printed to stdout.  Everything up to and including the first" >&2
  echo "          letter \"a\" is deleted, and everything after and including the" >&2
  echo "          last letter \"a\" is also deleted." >&2
  echo "Usage:    $NAME string" >&2
}

NAME=${0##*/}

# Check that one and only one argument is passed
if [ $# -ne 1 ]
then
  echo "Error: Incorrect number of arguments" >&2
  displayUsage
  exit 1
fi

OUTPUT=${1#*a}
OUTPUT=${OUTPUT%a*}

echo $OUTPUT
