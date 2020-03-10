#!/bin/bash

## Generate CodeRefiner workspace for live coding.

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
# export LSCOLORS=dxfxcxdxbxegedabagacad

export PS1="\[\e[01;36m\]\W\[\e[m\] \[\e[31m\]\n\\$\[\e[m\] "
if [[ -d "coderefinery" ]]
then
    source set-prompt.sh
else
    python3 -m venv coderefinery
    
    ## desable Dropbox sync
    # xattr -w com.dropbox.ignored 1 $PWD/coderefinery
    source coderefinery/bin/activate
    pip install -q --upgrade pip 
    pip install -q -r requirements.txt
    
    ## enable nbdime extension
    nbdime extensions --enable 
    
    ## enable jupyterlab-git
    jupyter serverextension enable --py jupyterlab_git
    jupyter lab build 
    
    ## install JupyterLab Extension Manager
    jupyter labextension install @jupyter-widgets/jupyterlab-manager@1.1.0   
    
    ## install DataRegistry extension
    jupyter labextension install @jupyterlab/dataregistry-extension@3.0.0 

    ## install support for hdf5 files
    pip install jupyterlab_hdf==0.3.0
    jupyter labextension install @jupyterlab/hdf5@0.3.0

    ## install TOC extension
    jupyter labextension install @jupyterlab/toc@2.0.0  

    ## install Collapsible Headings extension
    jupyter labextension install @aquirdturtle/collapsible_headings@0.5.0 

    ## install Code Formatter
    jupyter labextension install @ryantam626/jupyterlab_code_formatter@1.1.0
    pip install jupyterlab_code_formatter==1.1.0 
    jupyter serverextension enable --py jupyterlab_code_formatter 

    ## install Jupyter Notebook Widgets Extension
    jupyter nbextension enable --py widgetsnbextension 
    
    ## customize JupyterLab terminal
    cp terminal_plugin.json coderefinery/share/jupyter/lab/schemas/@jupyterlab/terminal-extension/plugin.json 

    ## reset JupyterLab user settings
    ./reset-jupyter-settings.sh

    printf "Setup completed.\n"
fi


