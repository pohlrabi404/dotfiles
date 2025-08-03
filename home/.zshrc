alias ls='ls --color=auto'
alias lls='ls -la --color=auto'
alias grep='grep --color=auto'
alias bm='bashmount'
alias nv="nvim"
alias hd="Hyprland -c ~/.config/hypr/hyprlandd.conf"

function rein() {
	rebos gen commit "$1"
	rebos gen current build
}

function redit() {
	CONFIG_DIR="~/.config/rebos/imports/"
	nvim $CONFIG_DIR
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
