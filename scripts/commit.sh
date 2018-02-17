#!/bin/sh

#  Commit.sh
#
#  Created by Tapash Majumder on 2017-05-20.
#  Copyright (c) Stashword Inc. All rights reserved.

print_usage() {
    echo Usage `basename $0` message
    exit 1;
}

if [ "$1" == "" ]; then
    print_usage
fi

git add --all .
git commit -m "$1"

git push origin master






