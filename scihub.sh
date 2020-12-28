#!/bin/bash

#################################################################################
###  Functions                                                               ###
################################################################################
helpFunction() {
   echo ""
   echo "Usage: $0 DOI"
   echo -e " --about \tAbout this script"
   echo -e " -v, --version \tShows the Script version"
   echo -e " -h, --help \tThis help"
   exit 0 # Exit script after printing help
}

################################################################################
###  Sci-Hub mirrors                                                         ###
################################################################################
sources=(
"https://sci-hub.do/"
"https://sci-hub.st/"
"https://sci-hub.se/"
)

url=${sources[$RANDOM % ${#sources[@]} ]}

################################################################################
###  Variables                                                               ###
################################################################################
PAPER=$(curl ${url}${1} | grep "iframe src" | cut -d '"' -f 2 | cut -d "#" -f 1)
#10.1007/s11416-019-00338-7 

################################################################################
###  Arguments parser                                                        ###
################################################################################
if [[ $# == 0 ]]; then
  echo -e "You should pass the required arguments"
  helpFunction
  exit 1
fi

if [[ -n ${PAPER} ]]; then
  wget ${PAPER:2}
else
	echo "This Paper doesn't exist on Sci Hub"
fi
