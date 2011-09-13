#!/bin/bash
/usr/bin/rsync -amrzl --safe-links --progress --exclude='sample-text/sample.txt' --exclude='*.gz' --exclude='*.tar' --exclude='*.sh' --exclude='*.sh.template' --exclude='.git*' -e ssh leopard1@schizo.cs.byu.edu:~/public_html/coding-projects/productive-vocabulary/* ./ 
