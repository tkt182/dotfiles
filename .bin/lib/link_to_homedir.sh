#!/usr/bin/env bash

set -ue

function backup_and_link() {
    link_src_file=$1
    link_dest_dir=$2
    backupdir=$3
    local f_filename
    f_filename=$(basename $link_src_file)
    local f_filepath="$link_dest_dir/$f_filename"
    if [[ -L "$f_filepath" ]];then
        command rm -f "$f_filepath"
    fi

    if [[ -e "$f_filepath" ]];then
        command cp -r "$f_filepath" "$backupdir"
    fi

    if [[ -e "$f_filepath" ]];then
        command mv "$f_filepath" "$backupdir"
    fi
    command ln -snf "$link_src_file" "$link_dest_dir"
}


function link_to_homedir() {
    echo "backup old dotfiles..."
    local tmp_date=$(date '+%y%m%d-%H%M%S')
    local backupdir="$HOME/.dotbackup/$tmp_date"
    mkdir -p $backupdir

    local current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
    local dotfiles_dir="$(builtin cd "$current_dir" && git rev-parse --show-toplevel)"
    if [[ "$HOME" != "$dotfiles_dir" ]];then
        for f in $dotfiles_dir/.??*; do
            local f_filename
            f_filename=$(basename $f)
            [[ "$f_filename" == ".git" || "$f_filename" == ".github" ]] && continue
            backup_and_link $f $HOME $backupdir
        done
    fi
}

link_to_homedir
