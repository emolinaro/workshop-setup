#!/bin/bash

GIT_DIR=$(git rev-parse --show-toplevel)

export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1="\[\e[01;36m\]\W\[\e[m\] \[\e[31m\]\n\\$\[\e[m\] "
source $GIT_DIR/coderefinery/bin/activate

