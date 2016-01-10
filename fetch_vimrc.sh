#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ $# != 1 ]
then
    printf 'USAGE: ./fetch_vimrc.sh path/to/vimrc'
    exit 1
fi

case `(uname -s)` in
    Darwin|Linux)
        echo 'Mac OS or Linux system detected, copying ".vimrc"...'
        cp ~/.vim/.vimrc ${DIR}/_vimrc
        ;;

    CYGWIN*|MINGW32*|MSYS*)
        echo 'Windows system detected, copying "_vimrc"...'
        cp $1/_vimrc ${DIR}/_vimrc
        ;;
    *)
        echo 'System not recognized, Exiting...'
        exit 1
        ;;
esac

echo 'Done'
