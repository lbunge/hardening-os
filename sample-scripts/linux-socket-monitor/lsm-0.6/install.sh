#!/bin/sh
#
# LSM 0.6 [lsm@r-fx.org]
###
# Copyright (C) 2004, R-fx Networks <proj@r-fx.org>
# Copyright (C) 2004, Ryan MacDonald <ryan@r-fx.org>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
###
#
INSPATH="/usr/local/lsm"
BINPATH="/usr/local/sbin/lsm"

install(){
	if [ -d "/usr/local/pmon" ]; then
	 rm -rf /usr/local/pmon /etc/cron.d/pmon /usr/local/sbin/pmon
	fi
        rm -rf $INSPATH
        mkdir $INSPATH
        cp -R files/* $INSPATH
	cp README CHANGELOG COPYING.GPL $INSPATH
        chmod 640 $INSPATH/*
        chmod 750 $INSPATH/lsm
	if [ -f "/etc/cron.d/lsm" ]; then
		rm -f /etc/cron.d/lsm
	fi
	cp cron /etc/cron.d/lsm
	chmod 644 /etc/cron.d/lsm
        ln -fs $INSPATH/lsm $BINPATH
}
if [ -d "$INSPATH" ]; then
	rm -rf $INSPATH
	install
else
	install
fi

echo ".: LSM installed"
echo "Install path:    $INSPATH"
echo "Config path:     $INSPATH/conf.lsm"
echo "Executable path: $BINPATH"

if [ -f "/usr/local/lsm/lsm" ]; then
	/usr/local/lsm/lsm -g
fi
