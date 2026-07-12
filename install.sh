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

    # ---- special handling for .config ----
    if [[ "$dotfile" == ".config" && -d "$dotfile" ]]; then
	mkdir -p ~/.config

	for config_item in "$pwd/.config/"*
	do
	    name=$(basename "$config_item")
	    target="$HOME/.config/$name"

	    # ---- herdr: ソケットをUnixドメインソケット非対応のファイルシステム
	    # (WSL2のDrvFsマウント配下等)に作らせないよう、ディレクトリ自体は
	    # symlinkにせず、設定ファイルだけを実ディレクトリの中にlinkする ----
	    if [[ "$name" == "herdr" && -d "$config_item" ]]; then
		mkdir -p "$target"

		for herdr_file in "$config_item"/*
		do
		    fname=$(basename "$herdr_file")
		    # herdrが自分で生成するランタイムファイルはlinkしない
		    case "$fname" in
			session.json|*.log|*.sock) continue ;;
		    esac
		    ln -sfn "$herdr_file" "$target/$fname"
		done

		continue
	    fi
	    # -------------------------------------

	    if [ -e "$target" ] || [ -L "$target" ]; then
		read -p "$target already exists. overwrite? [Y/n] " answer
		case $answer in
		    [Nn]* ) continue ;;
		esac
	    fi

	    # file / directory の区別なく symlink
	    ln -sfn "$config_item" "$target"
	done

	continue
    fi
    # -------------------------------------

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
