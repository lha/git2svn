#!/bin/sh

./git2svn \
     --verbose \
     --no-unlink \
     /Users/lha/src/heimdal/git-trunk repro || exit 1

./git2svn \
     --verbose \
     --no-unlink \
     --svn-prefix=branches/heimdal-1-1-branch \
     --git-branch=heimdal-1-1-branch \
     /Users/lha/src/heimdal/git-trunk repro || exit 1

# try incremental
./git2svn \
     --verbose \
     --no-unlink \
    /Users/lha/src/heimdal/git-trunk repro || exit 1

echo "all tests passed"
exit 0
