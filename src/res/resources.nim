
import os
import base64
import resource_file

proc writeZipFile* () : string = 
  result = getTempDir() / "resource.zip"
  let s = decode(resource_string)
  let f = open( result, FileMode.fmWrite)
  f.write(s)
  f.close()

# discard extract_file()
