#!/bin/sh
# tests image_server container
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

printc () {
    echo -e "${1}${2}${NC}"
}

# test if the given url returns a 200 status code
assert () {
    if [ $(curl -I -s -o /dev/null -w "%{http_code}" $1) -eq 200 ]
    then
        printc $GREEN "SUCCESS: $2"
    else
        printc $RED "FAIL: $2" && exit 1;
    fi
}

printc $GREEN "---------------- START image_server tests ---------------"

# test resize, crop, static mathods 
assert http://image_server/process_resize_10x10/58f82d09ae7555.jpg "test image resizing"
assert http://image_server/process_crop_10x10/58f82d09ae7555.jpg "test image croping"
assert http://image_server/static/58f82d09ae7555.jpg "test static images"