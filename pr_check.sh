#!/bin/bash

echo "Check dart formatting"
dart format --line-length 100 lib

echo "Run static code analysis"
flutter analyze --fatal-infos
