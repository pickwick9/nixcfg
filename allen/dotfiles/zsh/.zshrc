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

fvi() {
  local file
  file=$(find . -type f 2> /dev/null | fzf) && vi "$file"
  zle reset-prompt
}
zle -N fvi
bindkey '^V' fvi

eval "$(direnv hook zsh)"
