import os
import base64
import zip/zipfiles
import strutils

proc makeZipToSrc(dirName, srcFileName : string) : bool = 
  result = true
  var zipFile : ZipArchive
  let zipFilePath = getTempDir() / "sample.zip"

  if zipFilePath.existsFile() == true :
    zipFilePath.removeFile

  if zipFile.open( zipFilePath, FileMode.fmWrite ) == false:
    return

  # ディレクトリを探索してZIPに追加する
  for f in walkDirRec(dirName, yieldFilter={pcFile}):
    let tokens = f.split($DirSep)
    let newFile = tokens[1..^1].join("/")
    echo "newFile=>" & newFile
    zipFile.addFile(newFile, f)
  zipFile.close
  
  # ZipFileを開いて、Base64を作成して、ソースに埋め込む
  block:
    let f = open(zipFilePath, FileMode.fmRead)
    let b = f.readAll()
    f.close

    let w = open(srcFileName, FileMode.fmWrite)
    w.write("const resource_string* = \"\"\"" & encode(b) & "\"\"\"")
    w.close

let src = "src/res/resource_file.nim" 

var 
  dir = "html"

if paramCount() == 1: 
  dir = $os.commandLineParams()[0]

discard makeZipToSrc(dir,src)

