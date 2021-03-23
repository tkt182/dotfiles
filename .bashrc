export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
export CLICOLOR=1
export LSCOLORS="DxGxcxdxCxegedabagacad"

export PATH=~/bin:$HOME/.nodebrew/current/bin:$PATH


alias grep='grep --color=auto'
alias ll='ls -al'
alias cdgit="cd ~/git"
alias cdwork="cd ~/work"
alias gitgraph='git log --graph --decorate --oneline'
alias dcup='docker-compose up'
alias dcexec='docker-compose exec'
alias curl_header='curl -D - -s -o /dev/null '

source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true

UNTRACKED_BASHRC="$HOME/.untracked_bashrc"
if [[ -f $UNTRACKED_BASHRC ]]; then
    source $UNTRACKED_BASHRC
fi

gittagsearch ()
{
    git for-each-ref --sort=-taggerdate --format='%(taggerdate:short) %(tag) %(taggername) %(subject)' refs/tags | head -n $1
}


set_term_bgcolor ()
{
    local R=$1
    local G=$2
    local B=$3
    /usr/bin/osascript <<EOF
tell application "iTerm2"
  tell current session of first window
    set background color to {$(($R*65535/255)), $(($G*65535/255)), $(($B*65535/255))}
  end tell
end tell
EOF
}

tmux_new ()
{
    tmux new -s $1
}

tmux_attach ()
{
    tmux a -t $1
}

tmux_kill ()
{
    tmux kill-session -t $1
}

create_random ()
{
    openssl rand -base64 64 | fold -w $1 | head -1 | tr -d '\n'
}


