#!/bin/bash

BIN=$(find .stack-work/install/ -name site)

REPO=../astynax.github.io

if [[ ! -d "$REPO" ]]; then
    echo "No repo found!";
    exit 1;
fi

if [[ ! -x "$BIN" ]]; then
    echo "No binary found!";
    exit 2;
fi

echo ========== Cleaning ==========
$BIN clean

echo ========== Building ==========
$BIN build

read -p "Press any key to continue..."

echo ========== Syncing ===========
rsync -r _site/* $REPO

echo ========== git:push ==========
pushd $REPO >> /dev/null
git pull && git add . && git com -m "$(date +%Y.%m.%d-%H:%M) - autocommit" && git push
popd >> /dev/null

