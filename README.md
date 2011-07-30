Some scripts which i create for my need. I am not a good programmer, so code is ugly.

Aptitude reductions
=====================

Small script to reduce the commands for aptitude. The idea comes from 'ip' utility. Move script to /usr/bin/:

    sudo mv aptitude_reductions.py /usr/bin/a

And try install for example python-markup:

    a i python-markup

For complete list of reductions, run script without arguments.
