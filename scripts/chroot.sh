echo "[Dotfiles]"
		ident="  "
		st="p"
		log "Move dotfiles to home"
		mv /dotfiles /home/pohlrabi/.dotfiles
		chown -R pohlrabi /home/pohlrabi/.dotfiles
		log
echo "[Dotfiles] DONE"
