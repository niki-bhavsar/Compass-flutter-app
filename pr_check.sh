#!/bin/bash

echo "Check dart formatting"
dart format --line-length 100 lib

echo "Run flutter static code analysis"
flutter analyze --fatal-infos

echo "Run dart static code analysis"
dart analyze --fatal-infos
