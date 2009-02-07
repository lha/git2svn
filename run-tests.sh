#!/bin/sh

rm -rf repro

gitrepro=/Users/lha/src/heimdal/git-trunk

(cd $gitrepro && git tag -d git2svn-syncpoint-master)

echo "####full import of master -> trunk"
./git2svn \
     --verbose \
     $gitrepro repro || exit 1

echo "####full import of branch -> branches/heimdal-1-1-branch"
./git2svn \
     --verbose \
     --svn-prefix=branches/heimdal-1-1-branch \
     --git-branch=heimdal-1-1-branch \
     $gitrepro repro || exit 1

echo "####incremental import of master -> trunk"
./git2svn \
     --verbose \
    $gitrepro repro || exit 1

echo "####test that repro looks ok at a glance"

svn=file://`pwd`/repro

svn ls $svn | grep trunk > /dev/null || exit 1
svn ls $svn/branches | grep heimdal-1-1-branch > /dev/null || exit 1

echo "####all tests passed"

exit 0
