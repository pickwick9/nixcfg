set -o vi
alias vi='nvim'

export CLICOLOR=1
export PS1=$'%n@%m:%{\e[01;32m%}%~%{\e[0m%}$ '

fcd() {
  local dir
  dir=$(find . -type d 2> /dev/null | fzf) && cd "$dir"
  zle reset-prompt
}
zle -N fcd
bindkey '^T' fcd

export MANPAGER='nvim +Man!'
