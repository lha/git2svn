#!/bin/sh

rm -rf repro

echo "####full import of master -> trunk"
./git2svn \
     --verbose \
     --no-unlink \
     /Users/lha/src/heimdal/git-trunk repro || exit 1

echo "####full import of branch -> branches/heimdal-1-1-branch"
./git2svn \
     --verbose \
     --no-unlink \
     --svn-prefix=branches/heimdal-1-1-branch \
     --git-branch=heimdal-1-1-branch \
     /Users/lha/src/heimdal/git-trunk repro || exit 1

echo "####incremental import of master -> trunk"
./git2svn \
     --verbose \
     --no-unlink \
    /Users/lha/src/heimdal/git-trunk repro || exit 1

echo "####test that repro looks ok at a glance"

svn=file://`pwd`/repro

svn ls $svn | grep trunk > /dev/null || exit 1
svn ls $svn/branches | grep heimdal-1-1-branch > /dev/null || exit 1

echo "all tests passed"

exit 0
