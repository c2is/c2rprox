#!/bin/bash
go build -o macosx/c2rprox/c2rprox c2rprox.go
/Applications/xcode_auxiliary_tools/PackageMaker.app/Contents/MacOS/PackageMaker -d ./macosx/c2rprox.pmdoc -o ./macosx/c2rprox.pkg

mkdir ./macosx/tmp
cp -R ./macosx/c2rprox.pkg ./macosx/tmp
hdiutil create -srcfolder "/Users/andre/Documents/Work/go/c2rprox/macosx/tmp/" -volname "C2rproxInstall" -fs HFS+ -fsargs "-c c=64,a=16,e=16" -format UDRW -size 13m ./macosx/C2rproxInstall.dmg
rm -rf ./macosx/tmp