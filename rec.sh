#!/usr/bin/env bash

set -x

rm -f demo.cast

asciinema rec -y -c "bash -x run.sh" demo.cast

asciicast2gif demo.cast demo.gif

gifsicle --colors 8 --resize 800x600 demo.gif >demo800x600.gif

rm -f demo.{cast,gif}