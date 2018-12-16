import docopt
import httppkg/main
import zip/zipfiles
import res/resources
import os

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

block:
  let zipFileName = writeZipFile()
  var z: ZipArchive
  if not z.open(zipFileName):
    echo "open zip fail"
  z.extractAll(getAppDir())
  z.close()

when isMainModule:
  let args = docopt(doc, version = "http 0.1.0")
  # echo "args=>", args
  let retCode = main(args)
  quit(retCode)
