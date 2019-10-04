#!/bin/sh

#Copyright 2018 The CDI Authors.
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

if [ $# != 3 ]; then
    echo "cloner: 3 args are supported: source|target, socket name, block|fs pv"
    exit 1
fi

obj="$1"      # source|target
rand_dir="$2" # part of socket path
volumeMode="$3" # FS|Block

pipe_dir="/tmp/clone/socket/$rand_dir/pipe"
image_dir="/tmp/clone/image/disk.img"
src_img="/tmp/clone/image-src/disk.img"

if [ "$volumeMode" == "block" ]; then
    image_dir="/dev/blockDevice"
fi

echo "image_dir is" $image_dir

if [ "$obj" == "target" ]; then
    echo "cloner: Starting copy clone target src: $src_img, dest: $image_dir"
    dd status='progress' conv=sparse if=$src_img bs=1M of=$image_dir
    exit 0
fi

echo "cloner: argument \"$obj\" is wrong; expect 'source' or 'target'"
exit 1