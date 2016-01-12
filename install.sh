#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ $# != 1 ]
then
    printf 'USAGE: ./install.sh path/to/vimfiles\n    (on Windows: $vim/vimfiles; on Linux: ~/.vim)\n'
    exit 1
fi

escaped_target="$(echo "${1}" | sed 's/\\\|\[\|\]\$\|\^/\\&/g')"

case `(uname -s)` in
    Darwin|Linux)
        echo 'Mac OS or Linux system detected, copying ".vimrc"...'
        cp -i ${DIR}/_vimrc ~/.vim/.vimrc
        ;;

    CYGWIN*|MINGW32*|MSYS*)
        echo 'Windows system detected, copying "_vimrc"...'
        cp -i ${DIR}/_vimrc $1/../_vimrc
        ;;
    *)
        echo 'System not recognized, Exiting...'
        exit 1
        ;;
esac

# if a target file is already there and is DIFFERENT than source file, ask for
# permission to overwrite
# if a target file is missing, copy the file
echo 'Copying files to vimfiles...'
for f in ${DIR}/vimfiles/**/*; do
    to_f="$(echo "${f}" | sed 's/^\/.*vimfiles/'${escaped_target}'/')"
    if [ -e ${to_f} ]; then
        diffresult=$(diff ${f} ${to_f})
        if [ "${diffresult}" != "" ]; then
            cp -i ${f} -T ${to_f}
        fi
    else
        cp ${f} -T ${to_f}
    fi
done

if [ ! -d $1/bundle/Vundle.vim ]
then
    echo 'Installing Vundle...'
    git clone https://github.com/VundleVim/Vundle.vim.git $1/bundle/Vundle.vim
fi

echo 'Installing plugins...'
gvim -c "PluginInstall" || echo 'Plugin installation failed because "gvim" command was
not found. You may run ":PluginInstall" in gvim to manually install your
plugins'

if [ -d $1/bundle/VimIM/plugin ]; then
    if [ ! -e $1/bundle/VimIM/plugin/vimim.wubi.txt ]; then
        echo 'VimIM detected, copying word dictionary...'
        cp ${DIR}/vimim.wubi.txt $1/bundle/VimIM/plugin/
    fi
fi

printf 'Done\n'

