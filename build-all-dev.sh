#!/usr/bin/env bash

./build.sh
export PLUGINS_DIR=$HOME/win/Openplanet4/Plugins
./build.sh
export PLUGINS_DIR=$HOME/win/OpenplanetTurbo/Plugins
./build.sh
