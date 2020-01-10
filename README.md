# Git Internals Visualization

## What?
This project provides a small script which compiles a text file in
PlantUML notation, provided the invoking command is run from within a
Git repository. The resulting PlantUML diagram is meant to visualize the
internal graph of Git commits, refs, trees and blobs.

## How?
A bash or awk script inspects the .git/ directory using standard git
commands. The script generates a [PlantUML](plantuml.com) description
file on stdout.  The output can be piped to PlantUML, either directly in
case of a local installation or via the clipboard to the web
demonstration page.

## Why?
Git is very powerful tool with overwhelming feature richness. Most
casual or new users only use a part of its functionality and have
troubles to understand, scale or fully exploit it. It is always
difficult and sometimes impossible to really work well with a tool you
do not understand. To aid learning Git, I thought it is a good idea to
have a visual representation of the DAG under the hood. Inspired by
[Learning Git Internals by
Example](http://teohm.com/blog/learning-git-internals-by-example/), I
wanted to have the possibility to visualize any Git repository without
big hassle or drawing by hand.

## Who?
I use it. I also plan to write a tutorial so any new learner may try it
out.  It is intended for a purely educational purpose, displaying only
small repos.



