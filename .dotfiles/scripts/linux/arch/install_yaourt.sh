pacman -S --needed base-devel git wget yajl
function install_package_from_aur() {
	git clone "https://aur.archlinux.org/$1.git"
	cd "$1"
	makepkg -sri
	cd ..
}
install_package_from_aur package-query
install_package_from_aur yaourt

