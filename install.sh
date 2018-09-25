#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ $# != 1 ]
then
    printf 'USAGE: ./install.sh path/to/vimfiles\n    (on Windows: $vim/vimfiles; on Linux: ~/.vim)\n'
    exit 1
fi

vimfiles_path=$1
escaped_target="$(echo "$vimfiles_path" | sed 's/\\\|\[\|\]\$\|\&\|\^\|\//\\&/g')"

vimfiles_path_with_tilde="$(echo "$1" | sed 's:^/home/[^/]\+/:~/:')"
SOURCE_CMD="source $vimfiles_path_with_tilde/_vimrc"
case `(uname -s)` in
    Darwin|Linux)
        echo 'Mac OS or Linux system detected.'
        touch ~/.vimrc
        vimrc_path=~/.vimrc
        ;;
    CYGWIN*|MINGW32*|MSYS*)
        echo 'Windows system detected'
        vimrc_path="$vimfiles_path/../_vimrc"
        mkdir -p "$vimfiles_path/../tmp"
        ;;
    *)
        echo 'System not recognized, Exiting...'
        exit 1
        ;;
esac
echo 'Sourcing _vimrc...'
grep -F "$SOURCE_CMD" "$vimrc_path" 2> /dev/null || echo "$SOURCE_CMD" >> "$vimrc_path" && printf "Done\n" || exit 1

# if a target file is already there and is DIFFERENT than source file, ask for
# permission to overwrite
# if a target file is missing, copy the file
echo 'Copying files to vimfiles...'
shopt -s globstar
for f in ${DIR}/vimfiles/**; do
    if [[ ! -f "$f" ]]; then
        continue
    fi
    to_f="$(echo "${f}" | sed 's/^\/.*vimfiles/'${escaped_target}'/')"
    mkdir -p "$( dirname "${to_f}" )"
    if [ -e ${to_f} ]; then
        diffresult=$(diff ${f} ${to_f})
        if [ "${diffresult}" != "" ]; then
            cp -i ${f} -T ${to_f}
        fi
    else
        cp ${f} -T ${to_f}
    fi
done
printf "Done\n"

if [ ! -d $vimfiles_path/bundle/Vundle.vim ]
then
    echo 'Installing Vundle...'
    git clone https://github.com/VundleVim/Vundle.vim.git $vimfiles_path/bundle/Vundle.vim
    printf "Done\n"
fi

echo 'Installing plugins...'
vim -c "PluginInstall" || echo 'Plugin installation failed because "vim" command was
not found. You may run ":PluginInstall" in gvim to manually install your
plugins'
printf "Done\n"

if [ -d $vimfiles_path/bundle/VimIM/plugin ]; then
    if [ ! -e $vimfiles_path/bundle/VimIM/plugin/vimim.wubi.txt ]; then
        echo 'VimIM detected, copying word dictionary...'
        cp ${DIR}/vimim.wubi.txt $vimfiles_path/bundle/VimIM/plugin/
        printf "Done\n"
    fi
fi

printf 'Installation completed\n'

