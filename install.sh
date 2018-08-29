#!/bin/bash

# download package manager for emacs
pushd .emacs.d/el-get
if [ ! -e el-get ]; then
    git clone https://github.com/dimitri/el-get.git
fi
popd

# Create symbolic links to files and directories in repository whose filename start with "." automatically. 
pwd=`pwd`
for dotfile in .??* 
do
    [[ "$dotfile" == ".git" ]] && continue       # ignore .git
    [[ "$dotfile" == ".gitignore" ]] && continue # ignore .gitignore
    if [ -e ~/$dotfile ]; then # If file or directory already exist. 
        if [ -d ~/$dotfile ]; then # If directory already exists, "ln" command could not overwrite it. 
            read -p "$dotfile directory already exists. Please remove or rename it and run $0 again. Continue? [Y/n]" answer
            case $answer in
                [Yy]* ) continue; ;;
                [Nn]* ) break
            esac
        fi
	      read -p "$dotfile file already exists. overwrite it? [Y/n]" answer
	      case $answer in
	          [Yy]* ) ln -fs $pwd/$dotfile ~/$dotfile; ;;
	          [Nn]* ) continue
	      esac
    else
	      ln -s $pwd/$dotfile ~/$dotfile
    fi
done
