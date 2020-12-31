#!/bin/sh

if [ -z $1 ];then
read -p "Input your module name:" module_name
else
module_name=$1
fi

cd modules
flutter create -t module --org top.ovo $module_name
cd ..

#TODO insert dependencies in pubspec.yaml
#TODO Chinese network optimat