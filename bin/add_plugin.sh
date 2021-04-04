#!/bin/sh

if [ -z $1 ];then
read -p "Input your plugin name:" plugin_name
else
plugin_name=$1
fi

if [ -z $2 ];then
read -p "Input your platforms('android,ios,macos,web'):" platforms
else
platforms=$2
fi

PLUGINS_DIR="plugins/"

if [ ! -d ${PLUGINS_DIR} ];then
  mkdir ${PLUGINS_DIR}
fi

CURRENT_DIR=`pwd`
cd $PLUGINS_DIR
flutter create -t plugin --platforms $platforms --org top.ovo $plugin_name
cd ${CURRENT_DIR}

#TODO insert dependencies in pubspec.yaml
#TODO Chinese network optimat