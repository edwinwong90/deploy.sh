#!/bin/bash

RELEASE_DIRECTORY="./release"

# step 1 - create release folder
if [ -d "$RELEASE_DIRECTORY" ];
  then
    # Control will enter here if $DIRECTORY exists
    echo "directory exists"
  else
    mkdir $RELEASE_DIRECTORY
    echo "create directory"
fi


# step 2 - Clone repo and rename it for naming convention 
cd $RELEASE_DIRECTORY

REPO_URL="https://edwinwong1990@bitbucket.org/edwinwong1990/weilibaocn-nuxt.git"

# naming convention e.g 2018-05-16-19-39-10
RELEASE_APP_FOLDER="$(date +'%Y-%m-%d-%H-%M-%S')"

# get the last segment of repo URL. e.g ../my-repo.git
REPO_NAME=${REPO_URL##*/}

# find .git extention for replace
FIND=".git"
REPLACE=""

# remove extention by replace it empty. e.g my-repo.git > my-repo
REPO_FOLDER_NAME=${REPO_NAME//$FIND/$REPLACE}

# git clone repo
sudo git clone $REPO_URL

# rename it to naming convention folder name
sudo mv $REPO_FOLDER_NAME $RELEASE_APP_FOLDER


# Step 3 - create symlink
cd ..

PWD=$(pwd)
PROJECT_PATH="$PWD/release/$RELEASE_APP_FOLDER"

if [ -L "current" ];
  then
    echo "symblink exist and deleting"
    rm current
fi

ln -s $PROJECT_PATH current
