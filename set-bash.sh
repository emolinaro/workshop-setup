#!/bin/bash

## Generate CodeRefiner workspace for live coding.

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
# export LSCOLORS=dxfxcxdxbxegedabagacad

export PS1="\[\e[01;36m\]\W\[\e[m\] \[\e[31m\]\n\\$\[\e[m\] "
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
    ## enable nbdime extension
    nbdime extensions --enable > /dev/null 2>&1
    ## enable jupyterlab-git
    jupyter serverextension enable --py jupyterlab_git > /dev/null 2>&1
    jupyter lab build > /dev/null 2>&1
    ## install JupyterLab Extension Manager
    jupyter labextension install @jupyter-widgets/jupyterlab-manager > /dev/null 2>&1
    ## install Jupyter Notebook Widgets Extension
    jupyter nbextension enable --py widgetsnbextension > /dev/null 2>&1
    ## customize JupyterLab terminal
    cp terminal_plugin.json coderefinery/share/jupyter/lab/schemas/@jupyterlab/terminal-extension/plugin.json > /dev/null 2>&1

    printf "Setup completed.\n"
fi


