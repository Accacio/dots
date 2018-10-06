#!/bin/bash
touch dummy.dummy
find . -maxdepth 1 -type f -not -name '*.tex'\
     -not -name '*.org' \
     -not -name '*.exe' \
     -not -name '*.sty' \
     -not -name '*.cls' \
     -not -name '*.bib' \
     -not -name '*.bat' \
     -not -name '*.sh' \
     -not -name '*.pdf' \
     -not -name '*.projectile'\
     -not -name 'makefile'\
     | xargs rm --
     
