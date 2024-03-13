#!/bin/zsh
ICON_DEFAULT_PATH=$XDG_DATA_HOME/icons/default
mkdir -p $ICON_DEFAULT_PATH

echo -e "[icon theme]\nInherits=$XCURSOR_THEME" > $ICON_DEFAULT_PATH/index.theme
logger "set cursor theme: $XCURSOR_THEME"
