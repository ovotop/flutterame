#!/bin/sh

if [ -z $1 ];then
read -p "Input your module name:" module_name
else
module_name=$1
fi

bin/optimize_cn_network.py modules/$module_name/.android 

last_dir=`pwd`

cd modules/$module_name/
flutter run --dart-define=IS_RUN_ALONE=true
cd $last_dir

