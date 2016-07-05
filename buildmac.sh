#!/bin/bash
go build -o macosx/c2rprox/c2rprox c2rprox.go
/Applications/xcode_auxiliary_tools/PackageMaker.app/Contents/MacOS/PackageMaker -d ./macosx/c2rprox.pmdoc -o ./macosx/c2rprox.pkg