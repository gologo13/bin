#!/bin/sh

# Copyright 2012, Yohei Yamaguchi <joker13meister@gmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#     * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following disclaimer
# in the documentation and/or other materials provided with the
# distribution.
#     * Neither the name of Google Inc. nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# startup programs before xmonad starts

(
# xmodmap $HOME/.Xmodmap &
xrdb -merge $HOME/.Xresources &
xsetroot -solid midnightblue &
nautilus -n &
if [ `hostname` = "yohei-vm" -a -x `which vmware-user-wrapper` ]; then
    vmware-user-wrapper &
fi
if [ -x `which xscreensaver` ]; then
    xscreensaver -no-splash &
fi
if [ -x `which trayer` ]; then
    trayer --edge top --align right --SetDockType true \
           --SetPartialStrut true --expand true --width 10\
           --transparent true --tint 0x191970 --height 11 &
fi
if [ -x `which synergys` ]; then
    synergys --config $HOME/.synergy &
fi
if [ -x `which nm-applet` ]; then
   nm-applet --sm-disable &
fi
if [ -x `which gnome-power-manager` ]; then
   sleep 3
   gnome-power-manager &
fi
if [ -x /usr/bin/dropbox ]; then
    /usr/bin/dropbox start &
fi
if [ -x `which gnome-terminal` ]; then
    gnome-terminal &
fi
if [ -x /usr/bin/ibus-daemon ]; then
    /usr/bin/ibus-daemon &
fi

# vrome
if [ -e $HOME/bin/vrome ]; then
    /usr/bin/nohup $HOME/bin/vrome > /dev/null &
fi
# edit-emacs
if [ -x `which plackup` ]; then
    plackup --host 127.0.0.1 --port 9292 $HOME/bin/edit-server.psgi &
fi

if [ -x `checkgmail` ]; then
    checkgmail &
fi

) &
exec xmonad
