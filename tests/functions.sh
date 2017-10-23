#!/bin/bash
# 
# Test functions for command tests.
#

# - - -
# Your functions declared here.
# - - -

timeout ()
{
  if [[  "$( uname -s )" == "Darwin" ]]
  then
    "$( which gtimeout )" "$@"
  else
    "$( which timeout )" "$@"
  fi
}
