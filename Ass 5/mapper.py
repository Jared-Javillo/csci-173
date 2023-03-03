#!/usr/bin/python
# classic mapper for wordcount
# wyu@ateneo.edu
import sys

for line in sys.stdin:
    line = line.strip()
    keys = line.split()
    for line in keys:
        value = 1
        print( "%s\t%d" % (line, value) )
