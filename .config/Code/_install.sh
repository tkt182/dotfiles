#!/usr/bin/env bash

set -ue

function link_vscode_config() { 
    local current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
    local dotfiles_dir="$(builtin cd "$current_dir" && git rev-parse --show-toplevel)"
    local app_name=$(basename $current_dir)
    local backupdir="$HOME/.dotbackup/$EXEC_DATE/$app_name"
    mkdir -p $backupdir

    source "$dotfiles_dir/.bin/lib/utils.sh"
    cd $current_dir

    if [ "$(uname)" == 'Darwin' ]; then
        local destdir="$HOME/Library/Application Support/Code/User"
        if [[ -d $destdir ]]; then
            for f in $current_dir/User/mac/*; do
                backup_and_link $f "$destdir" $backupdir
            done
        fi
    fi
}

link_vscode_config

