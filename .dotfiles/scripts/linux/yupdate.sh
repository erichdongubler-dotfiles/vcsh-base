function yupdate_base() {
	yaourt -Syuaac --devel --noconfirm && sudo pacman -Rsn $(sudo pacman -Qdtq)
}

function yupdate() {
	sudo reflector --verbose --country 'United States' -l 200 -p https --sort rate --save /etc/pacman.d/mirrorlist
	yupdate_base
}

if [ "$(uname -m | grep arm)" ]; then
	echo "Warning: yupdate configured to clean cache"
	function yupdate() {
		yaourt -Scc
		yupdate_base
	}
fi

