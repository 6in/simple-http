import os
import base64
import zip/zipfiles


var zipFile : ZipArchive
let zipFilePath = getTempDir() / "html.zip"

# ZIP作成
block:
  if zipFile.open( zipFilePath, FileMode.fmWrite ) == false:
    echo "open failed"

  # 圧縮
  zipFile.addFile("html/index.html", "html/index.html")
  zipFile.addFile(dest="html/images/nim.png",src="html/images/nim.png")
  zipFile.close()

# コピー(BASE64作成→復元→保存)
block:
  let f = open(zipFilePath, FileMode.fmRead)
  let b = f.readAll()
  f.close

  let s = encode(b)
  # echo s
  let ss = decode(s)

  let zipFileName = getTempDir() / "html2.zip"
  let ff = open( zipFileName, FileMode.fmWrite)
  ff.write(ss)
  ff.close

# 展開
block:
  var z: ZipArchive
  let zipFileName = getTempDir() / "html2.zip"
  if not z.open(zipFileName):
    echo "open zip fail"
  z.extractAll("C:\\temp")
  z.close()

