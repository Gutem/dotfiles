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
###   User Agents                                                            ###
################################################################################
useragents=(
"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36"
"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"
"Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:66.0) Gecko/20100101 Firefox/66.0"
"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36"
"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36"
"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1 Safari/605.1.15"
"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36"
"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36"
"Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101 Firefox/67.0"
"Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36"
)

###############################################################################
###  Sci-Hub mirrors                                                         ###
################################################################################
sources=(
"https://sci-hub.do/"
"https://sci-hub.se/"
"https://www.sci-hub.bar/"
"https://sci-hub.ee/"
"https://sci-hub.ren/"
"https://sci-hub.tf/"
)

################################################################################
###   Functions                                                              ###
################################################################################
function get_random_ua {
  ua=${useragents[$RANDOM % ${#useragents[@]} ]}
}

function get_random_source {
  url=${sources[$RANDOM % ${#sources[@]} ]}
}

################################################################################
###  Variables                                                               ###
################################################################################
get_random_ua
get_random_source

# DEBUG Mode
# echo "${ua}"
# echo "${url}"

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
  if [[ ${PAPER} =~ ^https?:// ]]; then
    # echo ${PAPER}
    wget -U "${ua}" ${PAPER}
  else
    # echo ${PAPER}
    wget -U "${ua}" ${PAPER:2}
  fi
else
	echo "This Paper doesn't exist on Sci Hub"
fi
