#!/bin/sh

WORKING_PATH=/media/win4/Users/Sand/Pictures/ImportCanon

mkdir -p $WORKING_PATH/tmp

cd $WORKING_PATH/tmp
gphoto2 --get-all-files

#
# Convert CR2 raw files to jpg file (max 1920px width/height)
# then move the raw file to its monthly folder
#
find $WORKING_PATH/tmp -type f -name '*.CR2' -print | while read file
do
  ufraw-batch --overwrite --size=1920 --out-type=jpeg $file
  touch -r $file ${file%.CR2}.jpg
  yearmonth=`date -r "$file" "+%Y%m"`
  dest=$WORKING_PATH/$yearmonth/raw
  mkdir -p "$dest"
  mv "$file" "$dest"
done

#
# Move temp file (convert file, video or gopro) to monthly folder
#
find $WORKING_PATH/tmp -type f -regex '.*\.\(JPG\|jpg\|MOV\)' -print | while read file
do
  yearmonth=`date -r "$file" "+%Y%m"`
  dest=$WORKING_PATH/$yearmonth
  mkdir -p "$dest"
  mv "$file" "$dest"
done

#
# Set convert file datetime to raw file datetime
# Remove raw file if convert file doesn't exists
#
find $WORKING_PATH -type d -name '*raw' -print | while read folder
do
  find $folder -type f -name '*.CR2' -print | while read image
  do
    basename=${image%.CR2}
    convert=$folder/..${basename#$folder}.jpg
    if [ -e "$convert" ]
    then
      touch -r $image $folder/..${basename#$folder}.jpg
    else
      echo [removed] $image
      rm $image
    fi
  done
done

#gphoto2 --delete-all-files

