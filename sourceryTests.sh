#!/bin/bash

echo "Checking for Sourcery..."

if [ -f "Sourcery/sourcery" ]; then
	echo "Sourcery: Sources/Abstract + Templates/Tests -> Tests/AbstractTests"

	./Sourcery/sourcery --sources Sources/Abstract --templates Templates/Tests --output Tests/AbstractTests

	echo "Sourcery: Tests/AbstractTests + Templates/Other/LinuxMain.stencil -> Tests/LinuxMain.swift"

	./Sourcery/sourcery --sources Tests/AbstractTests --templates Templates/Other/LinuxMain.stencil --output Tests/LinuxMain.swift

else
	echo "Sourcery is not installed, ignoring."
fi
