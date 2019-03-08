#!/usr/bin/env bash
#
# Amofi - App mode for Firefox
# Copyright (C) 2017-2018  Vitortec.com
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# GNU bash version 4.4
#
# @author    Vitor Guia <vitor.guia@vitortec.com>
# @copyright 2017-2018 Vitortec.com
# @license   http://www.gnu.org/licenses GPL-3.0-or-later
# @see       https://github.com/vitorteccom/amofi Repository of Amofi
#

#
# Check URI
#
if [ -z "$1" ]
then
    echo 'URI not found ...'
    exit
fi

#
# Check if the directory exists
#
if [ -d "/tmp/amofi/" ];
then
    #
    # Execute custom configuration
    #
    firefox -profile /tmp/amofi/ -no-remote -new-instance "$1"
fi

#
# Check if the directory does not exist
#
if [ ! -d "/tmp/amofi/" ];
then
    #
    # Create directories
    #
    mkdir -p /tmp/amofi/chrome

    #
    # Custom configuration
    #
    echo \
    "#nav-bar {
        visibility: hidden !important;
        max-height: 0 !important;
        margin-bottom: -20px !important;
    }
    #TabsToolbar {
        display: none !important;
    }" \
    >> /tmp/amofi/chrome/userChrome.css

    #
    # Execute custom configuration
    #
    firefox -profile /tmp/amofi/ -no-remote -new-instance "$1" \
    -width 800 -height 600
fi
