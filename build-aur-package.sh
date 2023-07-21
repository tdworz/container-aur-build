#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ]; then
    echo -e "Please provide an AUR package name to build."
    echo -e "Usage: docker run --rm -v \$(pwd):/out tdworz/aur-build <package-name>"
    exit 1
fi

sudo -u builder git clone --depth 1 https://aur.archlinux.org/$1.git /build/src

pacman -Syu --noconfirm

cd /build/src
sudo -u builder makepkg --noconfirm -sf

