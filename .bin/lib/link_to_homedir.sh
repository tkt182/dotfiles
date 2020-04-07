#!/usr/bin/env bash

set -ue

function link_to_homedir() {
    echo "backup old dotfiles..."
    local backupdir="$HOME/.dotbackup/$EXEC_DATE"
    mkdir -p $backupdir

    local current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
    source "$current_dir/utils.sh"
    local dotfiles_dir="$(builtin cd "$current_dir" && git rev-parse --show-toplevel)"
    if [[ "$HOME" != "$dotfiles_dir" ]];then
        for f in $dotfiles_dir/.??*; do
            local f_filename
            f_filename=$(basename $f)
            [[ "$f_filename" == ".git" || "$f_filename" == ".github" || "$f_filename" == ".config" ]] && continue
            backup_and_link $f $HOME $backupdir
        done
    fi
}

link_to_homedir

