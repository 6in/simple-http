import os
import docopt
import httppkg/main
import res/resources

let doc = """
http server for static contents.

Usage:
  http --port=<port> [--root=<root>]
  http (-h | --help)
  http --version

Options:
  --port=<port> port no .
  --root=<root> document root directory [default: .].
  -h --help     Show this screen.
  --version     Show version.
"""

when isMainModule:
  if expandResource(getAppDir()) == true :
    let args = docopt(doc, version = "http 0.1.0")
    # echo "args=>", args
    let retCode = main(args)
    quit(retCode)
  else:
    echo "expand resources failed"