#!/usr/bin/env bash

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

function backup_and_copy() {
    src_file=$1
    dest_dir=$2
    backupdir=$3
    local f_filename
    f_filename=$(basename $src_file)
    local f_filepath="$dest_dir/$f_filename"
    if [[ -L "$f_filepath" ]];then
        command rm -f "$f_filepath"
    fi

    if [[ -e "$f_filepath" ]];then
        command cp -r "$f_filepath" "$backupdir"
    fi

    if [[ -e "$f_filepath" ]];then
        command mv "$f_filepath" "$backupdir"
    fi
    command cp "$src_file" "$dest_dir"
}
