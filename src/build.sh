#!/bin/sh

OUT=../public

if [[ $1 = "clean" ]]
then
  echo Cleaning $OUT
  rm -rf $OUT/*
  exit
fi

cp CNAME $OUT

echo Compiling index.jade
jade index.jade
cp index.html $OUT/index.html

echo "Compiling script/*.coffee"
coffee -c -o $OUT/script script
cp -R script/libs $OUT/script/libs

echo "Copying fonts"
mkdir -p $OUT/style
cp -R style/fonts $OUT/style/fonts

echo "Compiling style/style.less"
lessc style/style.less $OUT/style/style.css

echo "Copying img/*"
mkdir -p $OUT/img
cp img/*.jpg $OUT/img
cp img/*.png $OUT/img

echo "Copying project assets"
mkdir -p $OUT/projects/
cp -R projects/crosswords $OUT/projects/crosswords
cp -R projects/illusions $OUT/projects/illusions
cp construction.html $OUT

