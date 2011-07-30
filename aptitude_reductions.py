#!/usr/bin/env python
# ===========================================
# Author: Bosha.
# E-Mail: thebosha [at] gmail [dot] com
# Web-site: http://post-geek.com
#============================================

import os, sys

# Paths, where can be aptitude
a_paths = ['/usr/bin/aptitude', '/bin/aptitude', '/usr/local/bin/aptitude']

# 
cmds = {
        'i': 'install',
        'ri': 'reinstall',
        's':'search',
        'sh':'show',
        'r':'remove',
        'p':'purge',
        'up':'update',
        'ug':'upgrade',
        'su':'safe-upgrade',
        'fu':'full-upgrade',
        'c':'clean',
        'h':'hold',
        'uh':'unhold',
        'd':'download',
        'au':'autoclean',
        'fv':'forbid-version',
        'fn':'forget-new',
        'ma':'markauto',
        'bd':'build-dep',
        'w':'why',
        'wn':'wny-not',
        }

def check_inst_aptitude():
    for path in a_paths:
        if os.path.isfile(path):
            return
        else:
            raise Exception('There is no aptitude installed! Install it first!')

def show_help():
    print "Following \"reductions\" can be used: \n\
============================= \n\
i     -- install \n\
ri    -- reinstall \n\
s     -- search \n\
sh    -- show \n\
r     -- remove \n\
p     -- purge \n\
up    -- update \n\
ug    -- upgrade \n\
su    -- safe-upgrade \n\
fu    -- full-upgrade \n\
c     -- clean \n\
h     -- hold \n\
uh    -- unhold \n\
d     -- download \n\
au    -- autoclean \n\
fu    -- forbid-version \n\
fn    -- forget-new \n\
ma    -- markauto \n\
bd    -- build-dep \n\
w     -- why \n\
wn    -- wny-not \n\
============================= "

if len(sys.argv) == 1:
    os.system('sudo aptitude')
    sys.exit(0)

if len(sys.argv) == 2:
    # No need to check if we only show help or usage
    check_inst_aptitude()
    for k, v in cmds.iteritems():
        if sys.argv[1] == k:
            cmd = "sudo aptitude " + v
            os.system(cmd)
            sys.exit(0)
    else:
        show_help()
else:
    # No need to check if we only show help or usage
    check_inst_aptitude()

    for k, v in cmds.iteritems():
        if sys.argv[1] == k:
            cmd = "sudo aptitude " + v + " " + sys.argv[2]
            os.system(cmd)
            sys.exit(0)
    else: 
        print "Don't have key '%s'!" % sys.argv[1]
        show_help()
