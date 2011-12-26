#!/bin/bash
find modules manifests -name '*.pp' \
  | xargs -t -n1 -P2 sh -c 'puppet parser validate "$@" || exit 255' -

find modules/*/templates/ -maxdepth 1 -type f -not -name .svn \
  | xargs -n1 sh -c 'erb -x -T - $1 | ruby -c 2>&1 | sed -e "s,^,$1: ,"' -
