#!/bin/bash

which python >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "没有此命令！"
else
    echo "有此命令。"
fi