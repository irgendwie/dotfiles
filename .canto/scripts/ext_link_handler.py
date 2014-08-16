#!/usr/bin/env python
import sys
import pafy
from subprocess import call

url = sys.argv[1]

if url.startswith("https://www.youtube.com/watch?v="):
	call(["cvlc", "-q", pafy.new(url).getbest().url])
else:
	call(["firefox", url])
