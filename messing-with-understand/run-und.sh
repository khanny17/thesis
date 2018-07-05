#!/bin/bash

UND="/home/kevin/scitools/bin/linux64/und"
COMMITS=$(cat git_commits.txt)
mkdir -p und_results/

for commit in $COMMITS;
do
    # checkout the commit
    cd ~/thesis/git
    git checkout $commit
    cd -

    # Get all C and H files except the test files
    find /home/kevin/thesis/git | grep "\.c$\|\.h$\|\.cpp$\|\.hpp$" | grep -v "/t/" > git_files.txt

    # delete old db
    rm -rf git.udb
    $UND create git.udb

    # run understand on this commit
    $UND process und_process.txt git.udb

    # save results
    mv git.csv und_results/$commit.csv
done
