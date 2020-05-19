#!/usr/bin/env python
import os, random, sys
mydir = os.path.dirname(__file__)
r = random.Random()
maxidx = None
with open('{}/web2'.format(mydir)) as webdict:
  for idx, raw_word in enumerate(webdict.readlines()):
    word = raw_word.strip()
    if sys.version_info[0] == 2:
      r.seed(word)
    elif sys.version_info[0] == 3:
      r.seed(word, version=1)
    else:
      raise Exception("Unexpected python version")
    print("{}: {}".format(word, r.randrange(0, 65535, 1)))
    if maxidx != None and idx >= maxidx:
      break

