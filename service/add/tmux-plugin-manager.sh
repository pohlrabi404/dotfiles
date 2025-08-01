#!/bin/bash
DIR=~/.tmux/plugins/tpm
if [ ! -d "$DIR" ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
