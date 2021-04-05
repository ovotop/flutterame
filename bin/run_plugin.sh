#!/bin/sh

if [ -z $1 ];then
read -p "Input your plugin name:" plugin_name
else
plugin_name=$1
fi

if [ -d plugins/$plugin_name/.android ];then
bin/optimize_cn_network.py plugins/$plugin_name/.android 
fi

last_dir=`pwd`

cd plugins/$plugin_name/example
flutter run --dart-define=IS_RUN_ALONE=true
cd $last_dir

