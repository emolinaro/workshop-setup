#!/bin/bash

WORKSPACE=$(jupyter lab path |grep Workspaces | awk '{print $3}')
USER_SETTINGS=$(jupyter lab path |grep Settings | awk '{print $4}')

## remove JupyterLab user settings
rm -rf $USER_SETTINGS/@jupyterlab/*

## reset JupyterLab workspace
rm -rf $WORKSPACE/*


