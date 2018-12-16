# Package

packageName   = "http"
version       = "0.1.0"
author        = "input your name"
description   = "sample app with nimble"
license       = "MIT"           

srcDir        = "src"                     # ソースフォルダ
binDir        = "bin"                     # 実行モジュールを配置するフォルダ
bin           = @[ "http" ]    # アプリケーションファイル名
skipDirs      = @[ "tests" , "util" ]     # nimble install時にスキップするフォルダ
backend       = "c"                       # デフォルトはc

const resourceDir   = "html"

# Dependencies

requires "nim >= 0.19.0"
requires "docopt >= 0.6.7"
requires "jester >= 0.4.1" 
requires "zip >= 0.2.1"

task run, "アプリケーションを実行します":
  exec "nimble build"
  exec "bin/" & packageName & " --port=4000 "

task test2, "テスト実行":                  # デフォルトのtestコマンドは、backendの値を参照しない
  # キャッシュファイルをクリア
  exec "nimble clean"
  # テスト実行開始
  exec "nim " & backend & " -r tests/alltest"

task clean, "キャッシュのクリア":
  rmDir "bin"
  rmDir "src/nimcache"
  rmDir "tests/nimcache"
  rmDir "util/nimcache"
  mkDir "bin"

task rename, "プロジェクト名を伴うファイル名・内容を置換します":
  rmDir ".git"
  mkDir "bin"
  exec "nim c -r --out:bin/rename_app util/rename_app.nim . " & packageName
  rmDir "src/" & packageName & "pkg"
  exec "nimble clean"

task rename_test, "リネームテスト用":
  mkDir "bin"
  rmDir "../http2"
  exec "cp -rp . ../http2"
  exec "nim c -r --out:bin/rename_app util/rename_app.nim ../http2 " & packageName
  rmDir "../http2/src/" & packageName & "pkg"

task musl, "MUSLでシングルバイナリを作成します for linux":
  exec "nim c -d:release -d:pcre --out:bin/" & packageName & "src/" & packageName & ".nim"

task make_resource, "リソースを作成":
  exec "nim c -r --out:bin/make_resource util/make_resource.nim " & resourceDir
  