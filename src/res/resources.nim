
import os
import base64
import resource_file
import zip/zipfiles

proc expandResource* (dir: string) : bool = 
  # base64をzipファイルとして保存する
  let s = decode(resource_string)
  let zipFileName = getTempDir() / "resource.zip"
  let f = open(zipFileName, FileMode.fmWrite)
  f.write(s)
  f.close()

  # ZIPを任意のフォルダに解凍する
  var z: ZipArchive
  if not z.open(zipFileName):
    echo "open zip fail"
  z.extractAll(dir)
  z.close()

