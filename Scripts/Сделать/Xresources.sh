#!/bin/bash

echo " Создать файл .Xresources в ~/ (home_user) "
touch ~/.Xresources   # Создать файл в ~/.Xresources
cat > ~/.Xresources <<EOF
Xft.dpi: 96
Xft.antialias: true
Xft.hinting: true
Xft.rgba: rgb
Xft.autohint: false
Xft.hintstyle: hintslight
Xft.lcdfilter: lcddefault

#include ".colors/dui"

!URxvt.font: xft:CozetteVector:size=9
!URxvt.font: xft:Hack Nerd Font Mono:size=9

!!! xlsfonts | grep ttyp0    &&    fc-list : family style
URxvt.font: xft:UW Ttyp0:size=10,xft:Hack Nerd Font Mono:size=9
URxvt.boldFont: xft:UW Ttyp0:size=10,xft:Hack Nerd Font Mono:size=9

!URxvt.termname: xterm-256color
URxvt.iconFile: /usr/share/icons/Papirus/48x48/apps/urxvt.svg
URxvt.geometry: 84x22
URxvt.internalBorder: 15
URxvt.letterSpace: 0
URxvt.antialias: true
URxvt.pointerBlank: true
URxvt.saveLines:    7000
URxvt.scrollBar:    false
URxvt.cursorBlink:  true
URxvt.urgentOnBell: true
URxvt.scrollTtyOutput: true
URxvt.scrollWithBuffer: true
URxvt.scrollTtyKeypress: true
URxvt.transparent:false
URxvt.depth: 32
URxvt.iso14755:        false
URxvt.iso14755_52:     false

URxvt.perl-ext-common: default,matcher,clipboard,keyboard-select,url-select
URxvt.url-launcher: /usr/bin/xdg-open
URxvt.url-select.underline: true
URxvt.matcher.button: 1
URxvt.keysym.C-u: perl:url-select:select_next

URxvt.keysym.C-Escape: perl:keyboard-select:activate
URxvt.keysym.C-/: perl:keyboard-select:search

URxvt.clipboard.autocopy: true
URxvt.keysym.Shift-Control-V: eval:paste_clipboard
URxvt.keysym.Shift-Control-C: eval:selection_to_clipboard

! ctrl + arrows
URxvt.keysym.Control-Up:    \033[1;5A
URxvt.keysym.Control-Down:  \033[1;5B
URxvt.keysym.Control-Left:  \033[1;5D
URxvt.keysym.Control-Right: \033[1;5C

EOF
###############
echo " Сделайте файл .Xresources исполняемым "
sudo chmod a+x ~/.Xresources
############
### end of script