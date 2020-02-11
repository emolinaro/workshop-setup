#!/bin/bash

## Generate CodeRefiner workspace for live coding.

export PS1="\[\e[36m\]\W\[\e[m\] \[\e[31m\]\n\\$\[\e[m\] "
if [[ -d "coderefinery" ]]
then
    source coderefinery/bin/activate
else
    python3 -m venv coderefinery
    ## desable Dropbox sync
    # xattr -w com.dropbox.ignored 1 $PWD/coderefinery
    source coderefinery/bin/activate
    pip install -q --upgrade pip 
    pip install -q -r requirements.txt
    printf "Setup completed.\n"
fi


