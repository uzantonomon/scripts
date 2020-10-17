#!/usr/bin/env python3
#
# Calculates number of files, hidden or not, in my home.
# WIP

import subprocess
from os.path import expanduser

home = expanduser("~")

ls = subprocess.Popen(("ls", home), stdout=subprocess.PIPE)
wc = subprocess.check_output(("wc", "-l"), stdin=ls.stdout)
result = wc.decode("utf-8")
print("number of non hidden files: " + wc.decode("utf-8"), end='')

ls1 = subprocess.Popen(("ls", "-a", home), stdout=subprocess.PIPE)
wc1 = subprocess.check_output(("wc", "-l"), stdin=ls1.stdout)
result1 = wc1.decode("utf-8")
print("total number of files: " + wc1.decode("utf-8"), end='')

diff = int(result1) - int(result)
print("number of hidden files: ", diff)
