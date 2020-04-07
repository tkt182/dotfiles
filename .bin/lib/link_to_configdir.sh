#!/usr/bin/env bash

set -ue

function link_to_configdir() {
    local current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
    local dotfiles_dir="$(builtin cd "$current_dir" && git rev-parse --show-toplevel)"
    local config_dir="$dotfiles_dir/.config"

    for sub_dir in `\find $config_dir -mindepth 1 -maxdepth 1 -type d`; do
        #app_name=$(basename $sub_dir)
        source "$sub_dir/_install.sh"
    done
}

link_to_configdir

