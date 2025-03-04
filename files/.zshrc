[[ $- != *i* ]] && return
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -v
zstyle :compinstall filename '/home/pohlrabi/.zshrc'

autoload -Uz compinit
compinit

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vi='nvim'
alias src='source ~/.zshrc'

eval $(ssh-agent) >/dev/null

source <(fzf --zsh)
source <(starship init zsh)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

rein(){
    rebos gen commit "$1"
    rebos gen current build
}
