ImportCanonEOS
==============

Shell script to import and manage files from Canon EOS camera 

# Features

* Import and convert RAW photos from camera in 1920px max width/height JPG
* Sort photos/videos by year/month folder
* Keep RAW photos in special directory
* Synchronize converted JPG datetime with its corresponding RAW
* If a converted JPG is deleted, its corresponding RAW will be deleted too

# Requirements

```
sudo aptitude install ufraw-batchgphoto2
```

# Usage

First, you'll need to set the ```WORKING_PATH``` variable to the folder where the photos will be stored.

1. Connect your Canon camera to usb
1. run script : ```./importCanon.sh```
