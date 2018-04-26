#!/bin/bash

echo "Checking for Sourcery..."

if [ -f "Sourcery/sourcery" ]
then
	echo "Generating source files: Sources/Abstract + Templates/Sources -> Sources/Abstract/Generated"

	./Sourcery/sourcery --sources Sources/Abstract --templates Templates/Sources --output Sources/Abstract/Generated
  
	echo "Generating test files: Sources/Abstract + Templates/Tests -> Tests/AbstractTests"

	./Sourcery/sourcery --sources Sources/Abstract --templates Templates/Tests --output Tests/AbstractTests

	echo "Removing first line from generated test files..."

	for filename in Tests/AbstractTests/*.generated.swift; do
		sed -i '' 1d $filename
	done

	echo "Generating LinuxMain file: Tests/AbstractTests + Templates/LinuxMain/LinuxMain.stencil -> Tests/LinuxMain.swift"

	./Sourcery/sourcery --sources Tests/AbstractTests --templates Templates/LinuxMain/LinuxMain.stencil --output Tests/LinuxMain.swift

	echo "Regenerating test files..."

	./Sourcery/sourcery --sources Sources/Abstract --templates Templates/Tests --output Tests/AbstractTests

	echo "Generating utility files for tests: Sources/Abstract + Templates/Other -> Tests/AbstractTests/Utility"

	./Sourcery/sourcery --sources Sources/Abstract --templates Templates/Other --output Tests/AbstractTests/Utility
else
	echo "Sourcery is not installed, ignoring."
fi
