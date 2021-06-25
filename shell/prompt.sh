autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '[%b]'

setopt prompt_subst
export PROMPT='me:%F{51}%1~%f${vcs_info_msg_0_} '
