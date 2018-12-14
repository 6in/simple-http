import docopt
import os
import jester
import strutils

proc main*(args: Table[string, Value]): int =
  result = 0
  let port: int = parseInt($args["--port"])

  var root: string = getCurrentDir()
  if args["--root"].kind == vkStr:
    root = $args["--root"]
    if os.existsDir(root) == false:
      root = os.joinPath(getCurrentDir(), root)

  echo "root=>" & root
  let settings = newSettings(
    Port(port), root
  )

  var myJester = initJester(settings)

  myJester.serve()

