#!/bin/bash

# Thanks goes to @pete-otaqui for the initial gist:
# https://gist.github.com/pete-otaqui/4188238
#
# Original version modified by Marek Suscak
#
# works with a file called VERSION in the current directory,
# the contents of which should be a semantic version number
# such as "1.2.3" or even "1.2.3-beta+001.ab"

# this script will display the current version, automatically
# suggest a "minor" version update, and ask for input to use
# the suggestion, or a newly entered value.

# once the new version number is determined, the script will
# pull a list of changes from git history, prepend this to
# a file called CHANGELOG.md (under the title of the new version
# number), give user a chance to review and update the changelist
# manually if needed and create a GIT tag.

NOW="$(date +'%B %d, %Y')"
RED="\033[1;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
WHITE="\033[1;37m"
RESET="\033[0m"
NC='\033[0m'

LATEST_HASH=`git log --pretty=format:'%h' -n 1`

QUESTION_FLAG="${GREEN}?"
WARNING_FLAG="${YELLOW}!"
NOTICE_FLAG="${CYAN}❯"

BASE_STRING=`cat VERSION`
BASE_LIST=(`echo $BASE_STRING | tr '.' ' '`)
V_MAJOR=${BASE_LIST[0]}
V_MINOR=${BASE_LIST[1]}
V_PATCH=${BASE_LIST[2]}
echo -e "${NOTICE_FLAG} Current version: ${NC}$BASE_STRING"
echo -e "${NOTICE_FLAG} Latest commit hash: ${NC}$LATEST_HASH"
V_PATCH=$((V_PATCH + 1))
SUGGESTED_VERSION="$V_MAJOR.$V_MINOR.$V_PATCH"
echo -ne "${QUESTION_FLAG} ${CYAN}Enter a version number [${NC}$SUGGESTED_VERSION${CYAN}]: "
read INPUT_STRING
if [ "$INPUT_STRING" = "" ]; then
    INPUT_STRING=$SUGGESTED_VERSION
fi
echo -e "${NOTICE_FLAG} Will set new version to be ${NC}$INPUT_STRING"
echo $INPUT_STRING > VERSION
echo "## $INPUT_STRING ($NOW)" > tmpfile
git log --pretty=format:"  - %s" "v$BASE_STRING"...HEAD >> tmpfile
echo "" >> tmpfile
echo "" >> tmpfile
cat CHANGELOG.md >> tmpfile
mv tmpfile CHANGELOG.md

echo -e "${NOTICE_FLAG} Finished.${NC}"