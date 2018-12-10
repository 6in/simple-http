import docopt
import httppkg/main


let doc = """
http.

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
  let args = docopt(doc, version = "http 0.1.0")
  # echo "args=>", args
  let retCode = main(args)
  quit(retCode)
