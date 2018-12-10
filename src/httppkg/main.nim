import private/main_impl
import docopt
import os
import jester
import strutils

# スレッド処理
proc threadFunc(param: tuple[a, b: int]) {.thread.} =
  for x in param.a..param.b:
    echo "wait:" & $x
    sleep(1000)

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

