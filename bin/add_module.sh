#!/bin/sh

if [ -z $1 ];then
read -p "Input your module name:" module_name
else
module_name=$1
fi

MODULES_DIR="modules/"

if [ ! -d ${MODULES_DIR} ];then
  mkdir ${MODULES_DIR}
fi

CURRENT_DIR=`pwd`
cd $MODULES_DIR
flutter create -t module --org top.ovo $module_name
cd ${CURRENT_DIR}

#TODO insert dependencies in pubspec.yaml
#TODO Chinese network optimat