#!/bin/sh

if [ -z $1 ];then
read -p "Input your module name:" module_name
else
module_name=$1
fi

last_dir=`pwd`

cd modules/$module_name/
flutter run --dart-define=IS_RUN_ALONE=true
cd $last_dir

