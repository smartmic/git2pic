#!/bin/bash

# gitvis.sh
#
# Create PlantUML code to visualize the graph of a git repository
# This script is experimental. Purely educational purpose.
#
# Copyright 2019 Martin Michel
#
# This file is part of git2pic.
#
# git2pic is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# git2pic is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with git2pic.  If not, see <http://www.gnu.org/licenses/>.


echo "@startuml"
echo "!pragma ratio 0.99"
echo "scale 0.9"
echo "left to right direction"

for obj in $(find .git/objects -type f  \
    | sed -e 's/^.git\/objects\///'  -e 's/\///' \
    | cut -c-5) 
do
    if [[ $(git cat-file -t $obj) == "commit" ]]
    then
        echo "[$obj] <<commit>>"
        git cat-file commit $obj \
        | grep tree \
        | awk -v o=$obj \
        '{printf "[%s] <<tree>>\n[%s] --> %s\n", \
substr($2,1,5), o, substr($2,1,5)}'
    elif [[ $(git cat-file -t $obj) == "tree" ]]
    then
        for item in $(git ls-tree $obj | awk '{print $2}')
        do
            if [[ $item == "tree" ]]
            then
                git ls-tree $obj \
                | grep tree \
                | awk -v o=$obj \
                '{printf "[%s] <<tree>>\n\
[%s] --> %s : <color:Blue><size:14><&folder>%s/\n", \
substr($3,1,5), o, substr($3,1,5), $4}'
            elif [[ $item == "blob" ]]
            then
                git ls-tree $obj \
                | grep blob \
                | awk -v o=$obj \
                '{printf "[%s] <<blob>>\n\
[%s] --> %s : <color:Green><size:14><&file>%s\n", \
substr($3,1,5), o, substr($3,1,5), $4}'
            fi
        done
    fi
done | sort -k 3 | uniq

echo "@enduml"
