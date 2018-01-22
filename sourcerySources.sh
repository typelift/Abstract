#!/bin/bash

echo "Checking for Sourcery..."

if [ -f "Sourcery/sourcery" ]; then
	echo "Generating source files: Sources/Abstract + Templates/Sources -> Sources/Abstract/Generated"

	./Sourcery/sourcery --sources Sources/Abstract --templates Templates/Sources --output Sources/Abstract/Generated

else
	echo "Sourcery is not installed, ignoring."
fi
