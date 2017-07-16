#!/bin/bash

echo "Checking for Sourcery..."

if [ -f "Sourcery/sourcery" ]; then
	echo "Sourcery: Sources/Abstract + Templates/Tests -> Tests/AbstractTests"

	./Sourcery/sourcery --sources Sources/Abstract --templates Templates/Tests --output Tests/AbstractTests
else
	echo "Sourcery is not installed, ignoring."
fi
