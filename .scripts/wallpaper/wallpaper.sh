#!/usr/bin/bash
exec >/tmp/wallpaper.log 2>&1

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
python "$BASEDIR"/set-wallpaper.py
