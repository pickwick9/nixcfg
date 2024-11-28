export CLICOLOR=1
export MANPAGER='nvim +Man!'
export PS1=$'%n@%m:%{\e[01;32m%}%~%{\e[0m%}$ '

alias code='codium'
alias vi='nvim'

set -o vi

fcd() {
  local dir
  dir=$(find . -type d 2> /dev/null | fzf) && cd "$dir"
  zle reset-prompt
}
zle -N fcd
bindkey '^T' fcd

eval "$(direnv hook zsh)"
