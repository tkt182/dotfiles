#!/usr/bin/env bash

set -ue

function main() {
    local current_dir
    current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")

    local is_link="false"
    local is_update="false"
    local no_gui="false"

    while [ $# -gt 0 ];do
        case ${1} in
            link)
                is_link="true"
                is_update="false"
                ;;
            update)
                is_link="false"
                is_update="true"
                ;;
        esac
        shift
    done

    if [ ! -d "dotfiles" ] && [ ! -d ".git" ]; then
        git clone https://github.com/tkt182/dotfiles.git
        current_dir="$current_dir/dotfiles"
    fi

    # default
    if [[ "$is_link" == false && "$is_update" == false ]]; then
        is_link="true"
    fi

    if [[ "$is_link" = true ]];then
        source $current_dir/.bin/lib/link_to_homedir.sh
        echo "#####################################################"
        echo "$(basename "${BASH_SOURCE[0]:-$0}") link success"
        echo "#####################################################"
    fi

}

main "$@"
