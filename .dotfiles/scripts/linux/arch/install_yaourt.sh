pacman -S --needed base-devel git wget yajl
function install_package_from_aur() {
	git clone "https://aur.archlinux.org/$1.git"
	cd "$1"
	makepkg -sri
	cd ..
	rm -rf "$1"
}
install_package_from_aur package-query
install_package_from_aur yaourt

yaourt -S package-query yaourt --noconfirm

